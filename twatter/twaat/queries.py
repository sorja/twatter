# -*- coding: utf-8 -*-

from twatter.twatter.utils import query

class NewTwaat(query.SQLQuery):
    name = 'new_twaat'
    result_action = 'fetchone'
    sql  = '''
            INSERT INTO twaat (user_id, text, parent_id) VALUES (%s, %s, %s) RETURNING *
    '''

    def __init__(self, user_id, text, parent_id):
        self.params = (user_id, text, parent_id)

class Twaat(query.SQLQuery):
    name = 'twaat'
    result_action = 'fetchone'
    sql  = '''
            SELECT t.*, u.email, u.full_name, u.timestamp, u.avatar, u.description, u.id as user_id
            from twaat t 
            INNER JOIN users u on t.user_id = u.id
            WHERE t.id=%s
    '''

    def __init__(self, twaatid):
        self.params = [twaatid]

class LovedTwaats(query.SQLQuery):
    name = 'loved_twaats'
    sql  = '''
            SELECT t.*, u.email, u.full_name, u.timestamp, u.avatar, u.description, u.id as user_id
            FROM favorited_twaats ft
            INNER JOIN twaat t on ft.twaat_id = t.id 
            INNER JOIN users u on ft.who_id = u.id
            WHERE ft.who_id=%s
            ORDER BY t.favorited_count DESC
    '''

    def __init__(self, userid):
        self.params = [userid]

class Unlove(query.SQLQuery):
    name = 'unlove'
    result_action = 'fetchone'
    sql  = '''
            DELETE FROM favorited_twaats ft
            WHERE ft.who_id = %s AND ft.twaat_id = %s
            RETURNING *
    '''

    def __init__(self, userid, id):
        self.params = (userid, id)

class UpdateUnloved(query.SQLQuery):
    name = 'update_unloved' 
    sql = '''
        UPDATE twaat SET favorited_count = favorited_count - 1 WHERE id = %s RETURNING *
    '''

    def __init__(self, id):
        self.params = [id]

class Love(query.SQLQuery):
    name = 'love'
    result_action = 'fetchone'
    sql  = '''
            INSERT INTO favorited_twaats (who_id, twaat_id)
            VALUES (%s, %s)
            RETURNING *
    '''

    def __init__(self, userid, id):
        self.params = (userid, id)

class UpdateLove(query.SQLQuery):
    name = 'update_loved' 
    sql = '''
        UPDATE twaat SET favorited_count = favorited_count + 1 WHERE id = %s RETURNING *
    '''

    def __init__(self, id):
        self.params = [id]
