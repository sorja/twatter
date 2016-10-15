# -*- coding: utf-8 -*-
from flask import render_template, request, redirect, url_for, flash
from flask_login import current_user, login_required

from twatter.twatter.app import app

from twatter.twatter.models import models
from twatter.twatter.utils import db, query, helpers

from twatter.twatter.twaat import queries as twaat_queries

@app.route('/retwaat/<id>', methods=['GET'])
@login_required
def retwaat(id=None):
    if not id:
        return redirect(url_for('index'))
    ctx = {}
    twaat = db.fetch(
        twaat_queries.Twaat(id)
    )
    ctx.update(twaat)
    _twaat = models.Twaat(*twaat['twaat'])
    new_twaat = db.fetch(
        twaat_queries.NewTwaat(
            current_user.getid(),
            _twaat.text,
            id)
    )
    ctx.update(new_twaat)
    flash('TWAAT was reTWAATed!', 'is-info')
    return redirect(helpers.redirect_url())

@app.route('/loved', methods=['GET'])
@login_required
def loved():
    ctx = {}
    favorited_twaats = db.fetch(
        twaat_queries.LovedTwaats(current_user.id)
    )
    ctx.update(favorited_twaats)
    return render_template('loved.html', **ctx)

@app.route('/love/<id>', methods=['GET'])
@login_required
def love(id=None):
    if not id:
        return redirect(url_for('index'))
    ctx = {}
    favorited_twaats = db.fetch(
        twaat_queries.LovedTwaats(current_user.id)
    )
    ctx.update(favorited_twaats)
    #check if already loved
    if any([int(id) == x['id'] for x in ctx['loved_twaats']]):
        print 'already loved'
        return redirect(helpers.redirect_url())

    love = db.fetch(
        twaat_queries.Love(str(current_user.id), str(id))
    )
    ctx.update(love)
    update_loved = db.fetch(
        twaat_queries.UpdateLove(ctx['love']['twaat_id'])
    )
    ctx.update(love)
    print ctx
    return redirect(helpers.redirect_url())

@app.route('/unlove/<id>', methods=['GET'])
@login_required
def unlove(id=None):
    if not id:
        return redirect(url_for('index'))
    ctx = {}
    unlove = db.fetch(
        twaat_queries.Unlove(str(current_user.id), str(id))
    )
    ctx.update(unlove)
    update_unloved = db.fetch(
        twaat_queries.UpdateUnloved(ctx['unlove']['twaat_id'])
    )
    ctx.update(update_unloved)
    if ctx['unlove']['who_id'] == current_user.getid():
        #do something?
        pass
    url = request.referrer.split('/')[-1]
    return redirect(helpers.redirect_url())



# favorited_twaats = get_favorited_twaats_for_user(current_user.id)
#     if any(x['twaat_id'] == int(id) for x in favorited_twaats):
#         flash('Incorrect email or password', 'errors')
#         return 'nok'
#     #If this was not already favorited by user add it and incerement
#     insert_new_favorite_twaat_for_id(id, current_user.id)
#     update_custom_query('''
#     UPDATE twaat SET favorited_count = favorited_count + 1 where id = %s
#     ''', (id))
