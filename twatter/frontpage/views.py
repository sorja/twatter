# -*- coding: utf-8 -*-
from flask import render_template
from flask_login import current_user, login_required

from twatter.twatter.app import app

from twatter.twatter.models import models
from twatter.twatter.utils import db, query

from twatter.twatter.frontpage import queries as fp_queries

from pprint import pprint

@app.route('/frontpage', methods=['GET'])
@login_required
def frontpage():
    ctx = {}
    following = db.fetch(
        fp_queries.Following(current_user.id)
    )
    ctx.update(following)
    followers = db.fetch(
        fp_queries.Followers(current_user.id)
    )
    ctx.update(followers)
    followed_twaats = db.fetch(
        fp_queries.FollowedTwaats(current_user.id)
    )
    ctx.update(followed_twaats)
    my_twaats = db.fetch(
        fp_queries.MyTwaats(current_user.id)
    )
    ctx.update(my_twaats)
    pprint(ctx)
    return render_template('frontpage.html', **ctx)

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