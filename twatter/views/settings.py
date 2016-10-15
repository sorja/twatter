# -*- coding: utf-8 -*-
from flask import flash, redirect, render_template, request, url_for
from flask_login import current_user, login_required
from twatter.twatter.app import app

@app.route('/settings', methods=['GET', 'POST'])
@login_required
def settings():
    if request.method == 'POST':
        current_password = request.form['current_password']
        password = request.form['password']
        password2 = request.form['password2']
        full_name = request.form['full_name']
        email = request.form['email']
        description = request.form['description']


        password = current_password
        if current_user.password != password:
            flash('Current password is wrong!', 'is-danger')
            return redirect(url_for('settings'))
        if password != password2:
            flash('Passwords didnt match!', 'is-danger')
            return redirect(url_for('settings'))
        
            #models update person

        flash('Fields updated', 'is-info')
        return redirect(url_for('settings'))
    else:
        ctx = {}
        # following = db.fetch(
        #     fp_queries.Following(current_user.id)
        # )
        # ctx.update(following)
        # followers = db.fetch(
        #     fp_queries.Followers(current_user.id)
        # )
        # ctx.update(followers)
        # followed_twaats = db.fetch(
        #     fp_queries.FollowedTwaats(current_user.id)
        # )
        # ctx.update(followed_twaats)
        # twaat = db.fetch(
        #     fp_queries.Twaat(current_user.id)
        # )
        # ctx.update(twaat)
        # favorited_twaats = db.fetch(
        #     twaat_queries.LovedTwaats(current_user.id)
        # )
        # ctx.update(favorited_twaats)
        # #check if already loved
        # session['loved'] = []
        # for loved in ctx['loved_twaats']:
        #     for followed in ctx['followed_twaats']:
        #         if loved['id'] == followed['id']:
        #             session['loved'].append(followed['id'])
        # print session['loved']
        return render_template('settings.html', **ctx)
