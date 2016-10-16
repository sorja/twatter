# -*- coding: utf-8 -*-

from flask import Flask, flash, session, redirect, url_for, escape, request, render_template
from flask_login import LoginManager, login_required, login_user, logout_user, current_user
import pdb

from twatter.twatter.app import app as application

from twatter.twatter.models import models
from twatter.twatter.utils import db, query

from twatter.twatter.authentication import queries as auth_queries

#flask-login
login_manager = LoginManager()
login_manager.init_app(application)
login_manager.login_view = "index"

@application.route('/register', methods=['POST'])
def register():
    full_name = request.form['full_name']
    email     = request.form['email']
    password  = request.form['password']
    result = db.fetch(
        auth_queries.Register(full_name, email, password)
    )
    return redirect(url_for('index'))

@application.route('/login', methods=['POST'])
def login():
    email = request.form['email']
    password = request.form['password']
    result = db.fetch(
        auth_queries.Login(email, password)
    )
    user = result['login']
    login_user(models.User(
        user['id'],
        user['full_name'],
        user['email'],
        user['password'],
        user['timestamp'],
        user['avatar'],
        user['description']
    ))
    return redirect(url_for('index'))

@application.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('index'))

# handle login failed
@application.errorhandler(401)
def page_not_found(e):
    return Response('<p>Login failed</p>')

@login_manager.user_loader
def load_user(userid):
    result = db.fetch (
        auth_queries.VerifyUser((userid))
    )
    user = result['verify_user']

    return models.User(
        user['id'],
        user['full_name'],
        user['email'],
        user['password'],
        user['timestamp'],
        user['avatar'],
        user['description']
    )