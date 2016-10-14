# -*- coding: utf-8 -*-
from flask import render_template, request, redirect, url_for
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

@app.route('/search_results/<type>/<query>', methods=['GET'])
@login_required
def search_results(query=None, type=None):
    if query is None or type is None:
        return redirect(url_for('index'))

    if 'tag' in type:
        flash('Not implemented yet', 'errors')
        return redirect(url_for('index'))
    ctx = {}
    search_results = db.fetch(
        fp_queries.Search(query)
    )
    ctx.update(search_results) 
    print ctx
    return render_template('search_results.html.j2', **ctx)

@app.route('/search', methods=['POST'])
@login_required
def search():
    query = request.form['query']
    type  = request.form['type']
    return redirect(url_for('search_results', query=query, type=type))