from flask import Flask, flash, session, redirect, url_for, escape, request, render_template
from flask_login import LoginManager, login_required, login_user, logout_user, current_user

from models.user import User
from database.utils import *

import pprint

import config
db_string = config.db['db_string']

app = Flask(__name__)

#config
app.config.update(
    DEBUG = config.app['debug'],
    SECRET_KEY = config.app['secret_key']
)

#flask-login
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "index"

##################
##    Routes    ##
##################
@app.route('/')
def index():
    if(current_user.is_authenticated):
        return redirect(url_for('frontpage'))
    return render_template('index.html')

@app.route('/profile/<id>')
@app.route('/profile')
@login_required
def profile(id=None):
    if not id:
        return redirect(url_for('profile', id=current_user.id))
    try:
        user = get_one_with_id('users', id)
        _twaats = get_custom_query("SELECT * FROM twaat t JOIN users u ON (u.id = t.user_id) WHERE user_id = %s and parent_id is null", (id,))
        twaats = [dict(record) for record in _twaats]
    except Exception as e:
        raise
    return render_template('profile.html.jinja2', twaats=twaats, user=user)

@app.route('/frontpage')
@login_required
def frontpage():
    db_query = "select *, twaat.id as twaat_id from twaat join follower on twaat.user_id = follower.whom_id inner join users on users.id = follower.whom_id where follower.who_id = %s";
    following_count = len(get_fields_from_table_with_id('*', 'follower', 'who_id', current_user.id))
    follower_count = len(get_fields_from_table_with_id('*', 'follower', 'whom_id', current_user.id))
    my_twaats = []
    try:
        conn = psycopg2.connect(db_string)
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute(db_query, (current_user.id,))
        twaats_followed = [dict(record) for record in cur.fetchall()] # it calls .fecthone() in loop

        _twaats = get_custom_query("SELECT * FROM twaat t JOIN users u ON (u.id = t.user_id) WHERE user_id = %s and parent_id is null", (current_user.id,))
        twaats = [dict(record) for record in _twaats]

        cur.close()
        conn.close()
    except Exception as e:
        print e

    twaats.reverse()
    my_twaats = twaats[:2]

    return render_template('frontpage.html',
                            twaats_followed = twaats_followed,
                            my_twaats = my_twaats,
                            following_count = following_count,
                            follower_count = follower_count)

@app.route('/register', methods=['POST'])
def register():
    full_name = request.form['full_name']
    email     = request.form['email']
    password  = request.form['password']

    try:
        conn = psycopg2.connect(db_string)
        cur = conn.cursor()
        cur.execute("""
        INSERT INTO users (full_name, email, password) VALUES (%s, %s, %s)
        """, (full_name, email, password))
        conn.commit()
        cur.close()
        conn.close()
        # session['username'] = request.form['username']
    except Exception as e:
        if('duplicate' in e.pgerror):
            flash('Email already exists')
        print e
    return redirect(url_for('index'))

@app.route('/login', methods=['POST'])
def login():
    email = request.form['email']
    password = request.form['password']
    try:
        conn = psycopg2.connect(db_string)
        cur = conn.cursor()
        cur.execute("""
        SELECT * FROM users WHERE email=%s and password=%s
        """, (email, password))
        query = cur.fetchone()
        cur.close()
        conn.close()
        if not query:
            flash('Incorrect email or password')
        user = User(query[0],
                    query[1],
                    query[2],
                    query[3],
                    query[4],
                    query[5],
                    query[6])
        login_user(user)
        return redirect(url_for('index'))
    except Exception as e:
        print e
    return redirect(url_for('index'))

@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('index'))

#helpers
@app.route('/post_twaat', methods=['POST'])
@app.route('/post_twaat/<id>', methods=['POST'])
@login_required
def post_twaat(id=None):
    parent_id = id
    text = request.form['twaat_text']
    if not text:
        redirect(url_for('index'))
    # img = request.form['twaat_img']
    insert_new_twaat(current_user.id, text, parent_id)
    return redirect(url_for('index'))

@app.route('/favorite_twaat/<id>', methods=['POST'])
@login_required
def favorite_twaat(id=None):
    favorited_twaats = get_favorited_twaats_for_user(current_user.id)
    if any(x['twaat_id'] == int(id) for x in favorited_twaats):
        flash('Incorrect email or password', 'errors')
        return 'nok'
    #If this was not already favorited by user add it and incerement
    insert_new_favorite_twaat_for_id(id, current_user.id)
    update_custom_query('''
    UPDATE twaat SET favorited_count = favorited_count + 1 where id = %s
    ''', (id))
    return 'ok'

@app.route('/search_results/<type>/<query>', methods=['GET'])
def search_results(query=None, type=None):
    if query is None or type is None:
        return redirect(url_for('index'))

    if 'tag' in type:
        flash('Not implemented yet', 'errors')
        return redirect(url_for('index'))
    
    search_results = get_search_results(type, query);
    return render_template('search_results.html.jinja2', search_results=search_results)

@app.route('/search', methods=['POST'])
def search():
    query = request.form['query']
    type  = request.form['type']
    print type, query
    return redirect(url_for('search_results', query=query, type=type))

# handle login failed
@app.errorhandler(401)
def page_not_found(e):
    return Response('<p>Login failed</p>')

@login_manager.user_loader
def load_user(userid):
    try:
        conn = psycopg2.connect(db_string)
        cur = conn.cursor()
        cur.execute("SELECT * FROM users WHERE id = %s", (userid,))
        x = cur.fetchone()
        cur.close()
        conn.close()
        return User(x[0], x[1], x[2], x[3], x[4], x[5], x[6])
    except Exception as e:
        print e
    return None
