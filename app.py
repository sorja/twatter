from flask import Flask, flash, session, redirect, url_for, escape, request, render_template
from flask.ext.login import LoginManager, UserMixin, login_required, login_user, logout_user, current_user

import psycopg2
import psycopg2.extras

import pprint

app = Flask(__name__)

#config
app.config.update(
    DEBUG = True,
    SECRET_KEY = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'
)

#flask-login
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = "index"

#db settings
db_string = "dbname=sorja user=sorja"

class User(UserMixin):
    def __init__(self, id, full_name, email, password, created_at):
        self.id = id
        self.email = email
        self.full_name = full_name
        self.password = password
        self.created_at = created_at

    def __repr__(self):
        return "%d/%s/%s" % (self.id, self.full_name, self.password)

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
        conn = psycopg2.connect(db_string)
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("SELECT * FROM twaat t JOIN users u ON (u.id = t.user_id) WHERE user_id = %s and parent_id is null", (id,))
        twaats = [dict(record) for record in cur.fetchall()] # it calls .fecthone() in loop
        cur.execute("SELECT * FROM users WHERE id = %s", (id,))
        user = cur.fetchone()
        cur.close()
        conn.close()
    except Exception as e:
        print e
    return render_template('profile.html.jinja2', twaats=twaats, user=user)

@app.route('/frontpage')
@login_required
def frontpage():
    return render_template('frontpage.html')

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
        conn = psycopg2.connect("host='localhost' dbname='twatter' user='mxo' password='123'")
        cur = conn.cursor()
        cur.execute("""
        SELECT * FROM users WHERE email=%s and password=%s
        """, (email, password))
        query = cur.fetchone()
        cur.close()
        conn.close()
        if not query:
            flash('Incorrect email or password')
        user = User(
             query[0],
             query[1],
             query[2],
             query[3],
             query[4])
        print user
        login_user(user)
        return redirect(url_for('index'))
    except Exception as e:
        print e
    return redirect(url_for('index'))

@app.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('index'))

#helpers
@app.route('/post_twaat', methods=['POST'])
@app.route('/post_twaat/<id>', methods=['POST'])
def post_twaat(id=None):
    user_id = current_user.id
    parent_id = id
    text = request.form['twaat_text']
    if not text:
        redirect(url_for('index'))
    img = request.form['twaat_img']
    try:
        conn = psycopg2.connect(db_string)
        cur = conn.cursor()
        cur.execute("""
        INSERT INTO twaat (user_id, text, img, parent_id) VALUES (%s, %s, %s, %s)
        """, (user_id, text, img, parent_id))
        conn.commit()
        cur.close()
        conn.close()
        # session['username'] = request.form['username']
    except Exception as e:
        print e
    return redirect(url_for('index'))


# handle login failed
@app.errorhandler(401)
def page_not_found(e):
    return Response('<p>Login failed</p>')

@login_manager.user_loader
def load_user(userid):
    try:
        conn = psycopg2.connect("dbname=twatter user=mxo password=1")
        cur = conn.cursor()
        cur.execute("SELECT * FROM users WHERE id = %s", (userid,))
        query = cur.fetchone()
        cur.close()
        conn.close()
        return User(
             query[0],
             query[1],
             query[2],
             query[3],
             query[4])
    except Exception as e:
        print e
    return None
