# -*- coding: utf-8 -*-

from twatter.twatter.utils import query

class InfoTwaats(query.SQLQuery):
    name = 'info_twaats'
    sql = '''
            SELECT * FROM twaat
        '''

    def __init__(self):
        self.params = ()

class InfoFollowers(query.SQLQuery):
    name = 'info_followers'
    sql = '''
            SELECT * FROM follower
        '''

    def __init__(self):
        self.params = ()

class InfoLoves(query.SQLQuery):
    name = 'info_loves'
    sql = '''
            SELECT * FROM favorited_twaats
        '''

    def __init__(self):
        self.params = ()

class UpdateAvatar(query.SQLQuery):
    name = 'update_avatar'
    result_action = 'fetchone'
    sql = '''
            UPDATE users SET avatar = %s WHERE id = %s RETURNING *
    '''

    def __init__(self, avatar, id):
        self.params = (avatar, id)
