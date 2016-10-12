# -*- coding: utf-8 -*-

from twatter.twatter.utils import query

class Login(query.SQLQuery):
    name = 'login'
    result_action = 'fetchone'
    sql = '''
            SELECT * FROM users WHERE email=%s and password=%s
        '''

    def __init__(self, email, password):
        self.params = (email, password)

class Register(query.SQLQuery):
    name = 'register'
    result_action = 'fetchone'
    sql = '''
            INSERT INTO users (full_name, email, password) VALUES (%s, %s, %s) RETURNING *
        '''

    def __init__(self, full_name, email, password):
        self.params = (full_name, email, password)

class VerifyUser(query.SQLQuery):
    name = 'verify_user'
    result_action = 'fetchone'
    sql = '''
            SELECT * FROM users WHERE id=%s
        '''

    def __init__(self, id):
        self.params = [id]
