import os, sys, errno, time
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from flask import Flask, flash, session, redirect, url_for, escape, request, render_template
from flask_login import LoginManager, login_required, login_user, logout_user, current_user
from werkzeug.utils import secure_filename

import config
app = Flask(__name__)

app.debug = config.DEBUG
app.secret_key = config.SECRET_KEY
app.MAX_CONTENT_LENGTH = config.MAX_CONTENT_LENGTH
app.UPLOAD_FOLDER = config.UPLOAD_FOLDER

#  fix this
# #import views
# print ['.'.join((x, 'views')) for x in config.APPLICATIONS]
# for view in config.APPLICATIONS:
#     try:
#         module_name = '.'.join((view, 'views'))
#         __import__(module_name)
#     except ImportError as e:
#         pass
#     else:
#         print 'imported: %s' % module_name

##################
##    Routes    ##
##################

import authentication.views
import frontpage.views

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
    db_query = "select *, twaat.id as twaat_id from twaat join follower on twaat.user_id = follower.whom_id inner join users on users.id = follower.whom_id where follower.who_id = %s";
    following_count = len(get_fields_from_table_with_id('*', 'follower', 'who_id', current_user.id))
    follower_count = len(get_fields_from_table_with_id('*', 'follower', 'whom_id', current_user.id))
    return render_template('profile.html.jinja2',
                            twaats=twaats, user=user,
                            following_count = following_count,
                            follower_count = follower_count)

# @app.route('/frontpage')
# @login_required
# def frontpage():
#     # db_query = "select *, twaat.id as twaat_id from twaat join follower on twaat.user_id = follower.whom_id inner join users on users.id = follower.whom_id where follower.who_id = %s";
#     # following_count = len(get_fields_from_table_with_id('*', 'follower', 'who_id', current_user.id))
#     # follower_count = len(get_fields_from_table_with_id('*', 'follower', 'whom_id', current_user.id))
#     my_twaats = []
#     # try:
#     #     conn = psycopg2.connect(db_string)
#     #     cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
#     #     cur.execute(db_query, (current_user.id,))
#     #     twaats_followed = [dict(record) for record in cur.fetchall()] # it calls .fecthone() in loop

#     #     _twaats = get_custom_query("SELECT * FROM twaat t JOIN users u ON (u.id = t.user_id) WHERE user_id = %s and parent_id is null", (current_user.id,))
#     #     twaats = [dict(record) for record in _twaats]

#     #     cur.close()
#     #     conn.close()
#     # except Exception as e:
#     #     print e

#     # twaats.reverse()
#     # my_twaats = twaats[:2]

#     return render_template('frontpage.html',
#                             twaats_followed = [],
#                             my_twaats = my_twaats,
#                             following_count = 3,
#                             follower_count = 1)

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
@login_required
def search_results(query=None, type=None):
    if query is None or type is None:
        return redirect(url_for('index'))

    if 'tag' in type:
        flash('Not implemented yet', 'errors')
        return redirect(url_for('index'))
    
    search_results = get_search_results(type, query);
    return render_template('search_results.html.jinja2', search_results=search_results)

@app.route('/search', methods=['POST'])
@login_required
def search():
    query = request.form['query']
    type  = request.form['type']
    print type, query
    return redirect(url_for('search_results', query=query, type=type))

@app.route('/upload_avatar', methods=['POST'])
@login_required
def upload_avatar():
    def allowed_file(filename):
        return '.' in filename and \
           filename.rsplit('.', 1)[1] in config.app['allowed_extenstions']
    if 'file' not in request.files:
        flash('No file found', errors)
        redirect(request.url)
    
    file = request.files['file']
    if file.filename == '':
        flash('No selected file')
        return redirect(request.url)
    
    if file and allowed_file(file.filename):
        path = app.config['UPLOAD_FOLDER']+'/avatars'
        filename = '{}_{}.{}'.format(int(time.time()), current_user.id, file.filename.split('.')[-1])
        filename = secure_filename(filename)
        file.save(os.path.join(path, filename))
    # also update for user!
    update_user_avatar(current_user.id, filename)
    return redirect(url_for('profile'))

