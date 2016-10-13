# -*- coding: utf-8 -*-

from twatter.twatter.utils import query

class User(query.SQLQuery):
    name = 'user'
    sql  = '''
            SELECT *
            FROM users
            WHERE user.id=%s
    '''

    def __init__(self, userid):
        #params needs to be iterable
        self.params = [userid]
