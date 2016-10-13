# -*- coding: utf-8 -*-

from twatter.twatter.utils import query

class Following(query.SQLQuery):
    name = 'following'
    sql  = '''
            SELECT whom_id
            FROM follower
            WHERE follower.who_id=%s
    '''

    def __init__(self, userid):
        #params needs to be iterable
        self.params = [userid]

class Followers(query.SQLQuery):
    name = 'followers'
    sql  = '''
            SELECT who_id
            FROM follower
            WHERE follower.whom_id=%s
    '''

    def __init__(self, userid):
        #params needs to be iterable
        self.params = [userid]

class FollowedTwaats(query.SQLQuery):
    name = 'followed_twaats'
    sql  = '''
            SELECT t.*, u.email, u.full_name, u.timestamp, u.avatar, u.description
            FROM twaat t
            INNER JOIN users u ON t.user_id = u.id
            WHERE t.user_id IN
                (SELECT whom_id FROM follower WHERE who_id = %s)
            and t.parent_id is null;
    '''

    def __init__(self, userid):
        self.params = [userid]

class MyTwaats(query.SQLQuery):
    name = 'my_twaats'
    sql  = '''
            SELECT *, u.email, u.full_name, u.timestamp, u.avatar, u.description
            FROM twaat t
            INNER JOIN users u on t.user_id = u.id
            WHERE t.user_id=%s
            LIMIT 2
    '''

    def __init__(self, userid):
        self.params = [userid]
