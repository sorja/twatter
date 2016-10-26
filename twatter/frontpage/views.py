# -*- coding: utf-8 -*-
from flask import redirect, render_template, request, session, url_for
from flask_login import current_user, login_required
from twatter.twatter.app import app as application
from twatter.twatter.frontpage import queries as fp_queries
from twatter.twatter.models import models
from twatter.twatter.twaat import queries as twaat_queries
from twatter.twatter.utils import db


@application.route('/frontpage', methods=['GET'])
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
    favorited_twaats = db.fetch(
        twaat_queries.LovedTwaats(current_user.id)
    )
    ctx.update(favorited_twaats)
    #check if already loved
    session['loved'] = []
    for loved in ctx['loved_twaats']:
        for followed in ctx['followed_twaats']:
            if loved['id'] == followed['id']:
                session['loved'].append(followed['id'])
    print session['loved']
    return render_template('frontpage.html', **ctx)

@application.route('/post_twaat', methods=['POST'])
@application.route('/post_twaat/<id>', methods=['POST'])
@login_required
def post_twaat(id=None):
    parent_id = id
    text = request.form['twaat_text']
    assert application.debug == False


    if not text:
        redirect(url_for('index'))
    # img = request.form['twaat_img']
    ctx = {}
    insert_twaat = db.fetch(
        fp_queries.InsertTwaat(current_user.getid(), text, parent_id)
    )
    ctx.update(insert_twaat)
    return redirect(url_for('index', **ctx))

@application.route('/search_results/<type>/<query>', methods=['GET'])
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
    return render_template('search_results.html', **ctx)

@application.route('/search', methods=['POST'])
@login_required
def search():
    query = request.form['query']
    type  = request.form['type']
    return redirect(url_for('search_results', query=query, type=type))
