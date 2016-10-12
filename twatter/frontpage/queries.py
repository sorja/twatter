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
            SELECT *, twaat.id as twaat_id
            FROM twaat
            JOIN follower on twaat.user_id = follower.whom_id
            JOIN users ON users.id = follower.whom_id
            WHERE follower.whom_id=%s
    '''

    def __init__(self, userid):
        self.params = [userid]

class MyTwaats(query.SQLQuery):
    name = 'my_twaats'
    sql  = '''
            SELECT *
            FROM twaat
            WHERE twaat.user_id=%s
            ORDER BY timestamp DESC
            LIMIT 2
    '''

    def __init__(self, userid):
        self.params = [userid]

# class Login(query.SQLQuery):
#     name = 'login'
#     sql = '''
#             SELECT * FROM users WHERE email=%s and password=%s
#         '''

#     def __init__(self, email, password):
#         self.params = (email, password)

#     # db_query = "select *, twaat.id as twaat_id from twaat join follower on twaat.user_id = follower.whom_id inner join users on users.id = follower.whom_id where follower.who_id = %s";
#     # following_count = len(get_fields_from_table_with_id('*', 'follower', 'who_id', current_user.id))
#     # follower_count = len(get_fields_from_table_with_id('*', 'follower', 'whom_id', current_user.id))
#     my_twaats = []
#     # try:
#     #     conn = psycopg2.connect(db_string)
#     #     cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
#     #     cur.execute(db_query, (current_user.id,))
#     #     twaats_followed = [dict(record) for record in cur.fetchall()] # it calls .fecthone() in loop

#     #     _twaats = get_custom_query("SELECT * FROM twaat t JOIN users u ON (u.id = t.user_id) WHERE user_id = %s and parent_id is null", (current_user.id,))
#     #     twaats = [dict(record) for record in _twaats]

#     #     cur.close()
#     #     conn.close()
#     # except Exception as e:
#     #     print e

#     # twaats.reverse()
#     # my_twaats = twaats[:2]
