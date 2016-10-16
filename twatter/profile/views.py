# -*- coding: utf-8 -*-
from flask import render_template, redirect, url_for
from flask_login import current_user, login_required 

from twatter.twatter.app import app as application

from twatter.twatter.models import models
from twatter.twatter.utils import db, query

from twatter.twatter.profile import queries as profile_queries

@application.route('/profile/<id>', methods=['GET'])
@application.route('/profile')
@login_required
def profile(id=None):
    if not id:
        return redirect(url_for('profile', id=current_user.id))
    ctx = {}
    user = db.fetch(
        profile_queries.User(id)
    )
    ctx.update(user)
    if not user['user']:
        return redirect(url_for('index'))
    my_twaats = db.fetch(
        profile_queries.MyTwaats(id)
    )
    ctx.update(my_twaats)
    following = db.fetch(
        profile_queries.Following(current_user.id, id)
    )
    ctx.update(following)
    current_user.is_following = following['following'] > 0
    
    return render_template('profile.html', **ctx)

@application.route('/unfollow/<id>', methods=['GET'])
@login_required
def unfolow(id=None):
    if not id:
        return redirect(url_for('index'))
    ctx = {}
    unfollow = db.fetch(
        profile_queries.Unfollow(current_user.id, id)
    )
    ctx.update(unfollow)
    return redirect(url_for('profile', id=id))

@application.route('/follow/<id>', methods=['GET'])
@login_required
def follow(id=None):
    if not id:
        return redirect(url_for('index'))
    ctx = {}
    follow = db.fetch(
        profile_queries.Follow(current_user.id, id)
    )
    ctx.update(follow)
    return redirect(url_for('profile', id=id))
