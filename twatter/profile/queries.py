# -*- coding: utf-8 -*-

from twatter.twatter.utils import query

class User(query.SQLQuery):
    name = 'user'
    result_action = 'fetchone'
    sql  = '''
            SELECT *
            FROM users
            WHERE users.id=%s
    '''

    def __init__(self, userid):
        #params needs to be iterable
        self.params = [userid]

class MyTwaats(query.SQLQuery):
    name = 'my_twaats'
    sql  = '''
            SELECT *, u.email, u.full_name, u.timestamp, u.avatar, u.description
            FROM twaat t
            INNER JOIN users u on t.user_id = u.id
            WHERE t.user_id=%s
    '''

    def __init__(self, userid):
        self.params = [userid]

class Following(query.SQLQuery):
    name = 'following'
    result_action = 'fetchone'
    sql  = '''
            SELECT whom_id
            FROM follower
            WHERE who_id = %s
            AND whom_id = %s 
            AND deleted = false
    '''

    def __init__(self, current_user_id, id):
            self.params = (current_user_id, id)

class Unfollow(query.SQLQuery):
    name = 'unfollow'
    result_action = 'fetchone'
    sql = '''
            UPDATE follower
            SET deleted = true
            WHERE who_id = %s
            AND whom_id = %s
            RETURNING *
    '''

    def __init__(self, current_user_id, id):
            self.params = (current_user_id, id)

class Follow(query.SQLQuery):
    name = 'follow'
    result_action = 'fetchone'
    sql = '''
            INSERT INTO follower (who_id, whom_id)
            VALUES (%s, %s)
            ON CONFLICT(who_id, whom_id)
            DO UPDATE SET deleted = false
            RETURNING *
    '''

    def __init__(self, current_user_id, id):
            self.params = (current_user_id, id)
