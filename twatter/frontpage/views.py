# -*- coding: utf-8 -*-
from flask import render_template
from flask_login import current_user, login_required

from twatter.twatter.app import app

from twatter.twatter.models import models
from twatter.twatter.utils import db, query

from twatter.twatter.frontpage import queries as fp_queries

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
    twaat = db.fetch(
        fp_queries.Twaat(current_user.id)
    )
    ctx.update(twaat)
    return render_template('frontpage.html', **ctx)
