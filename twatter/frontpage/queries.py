# -*- coding: utf-8 -*-

from twatter.twatter.utils import query

class Following(query.SQLQuery):
    name = 'following'
    sql  = '''
            SELECT whom_id
            FROM follower
            WHERE follower.who_id=%s
            AND deleted = false
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
            AND deleted = false
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
            and t.parent_id is null
            LIMIT 10
    '''

    def __init__(self, userid):
        self.params = [userid]

class Twaat(query.SQLQuery):
    name = 'twaat'
    result_action = 'fetchone'
    sql  = '''
            SELECT t.*, u.email, u.full_name, u.timestamp, u.avatar, u.description
            FROM twaat t
            INNER JOIN users u on t.user_id = u.id
            WHERE t.user_id=%s
            ORDER BY t.timestamp desc
            LIMIT 1
    '''

    def __init__(self, userid):
        self.params = [userid]

class Search(query.SQLQuery):
        name = 'search_results'
        sql = '''
                SELECT * FROM users WHERE lower(full_name) LIKE %(like)s ESCAPE '=' LIMIT 25
        '''

        def __init__(self, name):
                self.params = dict(like= '%'+name+'%')

class InsertTwaat(query.SQLQuery):
        name = 'insert_twaat'
        result_action = 'fetchone'
        sql = '''
                INSERT INTO twaat (user_id, text, parent_id) VALUES (%s, %s, %s) RETURNING *
        '''

        def __init__(self, user_id, text, parent_id=None):
                self.params = (user_id, text, parent_id)




# def get_search_results(type, term):
#     term = str(term.lower())
#     query = '';
#     if type.lower() in 'users':
#         query = """SELECT * FROM users WHERE lower(full_name) like %s """
#     if type.lower() == 'tags':
#         return ['not implemented yet']

#     try:
#         conn = psycopg2.connect(config.db['db_string'])
#         cur = conn.cursor()
#         cur.execute(query, (['%'+term+'%']))
#         search_results = cur.fetchall()
#         #some problems with psycon, doesnt accept loop here..
#         cur.close()
#         conn.close()
#         return [User(x[0], x[1], x[2], x[3], x[4], x[5], x[6]) for x in search_results]
#     except Exception as e:
#         print e
#         return e
    