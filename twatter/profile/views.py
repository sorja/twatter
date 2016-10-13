# -*- coding: utf-8 -*-
from flask import render_template, redirect, url_for
from flask_login import current_user, login_required 

from twatter.twatter.app import app

from twatter.twatter.models import models
from twatter.twatter.utils import db, query

from twatter.twatter.profile import queries as profile_queries

@app.route('/profile/<id>')
@app.route('/profile')
@login_required
def profile(id=None):
    if not id:
        return redirect(url_for('profile', id=current_user.id))
    return render_template('profile.html.jinja2', user=current_user)
    # try:
    #     user = get_one_with_id('users', id)
    #     _twaats = get_custom_query("SELECT * FROM twaat t JOIN users u ON (u.id = t.user_id) WHERE user_id = %s and parent_id is null", (id,))
    #     twaats = [dict(record) for record in _twaats]
    # except Exception as e:
    #     raise
    # db_query = "select *, twaat.id as twaat_id from twaat join follower on twaat.user_id = follower.whom_id inner join users on users.id = follower.whom_id where follower.who_id = %s";
    # following_count = len(get_fields_from_table_with_id('*', 'follower', 'who_id', current_user.id))
    # follower_count = len(get_fields_from_table_with_id('*', 'follower', 'whom_id', current_user.id))
    # return render_template('profile.html.jinja2',
    #                         twaats=twaats, user=user,
    #                         following_count = following_count,
    #                         follower_count = follower_count)
