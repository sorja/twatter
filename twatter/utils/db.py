# -*- coding: utf-8 -*-

import config

import psycopg2
from psycopg2 import extensions
from psycopg2.extras import DictCursor

class DbConnection(object):
    def __init__(self):
        self.connection = None

    def get(self):
        if self.connection:
            conn = self.connection
        else:
            conn = psycopg2.connect(**config.DATABASE['default'])
        return conn

db_connection = DbConnection()

#Investigate how to use gevent for multi db fetch

def fetch(sql_query, to_dict=False):
    q = sql_query
    conn = db_connection.get()
    cursor = conn.cursor(cursor_factory=DictCursor)
    result = {}
    try:
        cursor.execute(q.sql, q.params)
        r = getattr(cursor, q.result_action)()
        q.result = r
        result[q.name] = r
        if to_dict:
            #zip column names to values ex. {'id': 1}
            column_names = [x[0] for x in cursor.description]
            result[q.name] = [dict(zip(column_names, x)) for x in r]
    except:
        conn.rollback()
        raise
    finally:
        if q.auto_commit:
            conn.commit()
        cursor.close()
    return result