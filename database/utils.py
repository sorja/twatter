import psycopg2
import psycopg2.extras
from ..models.user import User
from twatter import config

def get_connection():
    return psycopg2.connect(config.db['db_string'])

#GET STUFF

def get_one_with_id(table, id):
    assert table
    assert id
    query = "SELECT * FROM {} WHERE id = %s".format(table)
    conn = psycopg2.connect(config.db['db_string'])
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(query, (id,))
    result = cur.fetchone()
    cur.close()
    conn.close()
    return result

def get_fields_from_table_with_id(fields, table, id_name, id):
    assert fields
    assert table
    assert id_name
    assert id
    query = '''select %s from {} where {} = %s'''.format(table, id_name)
    conn = psycopg2.connect(config.db['db_string'])
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(query, (fields, id))
    results = cur.fetchall()
    cur.close()
    conn.close()
    return results

def get_all_from_table(table):
    assert table
    conn = psycopg2.connect(config.db['db_string'])
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("SELECT * FROM %s", (table,))
    result = cur.fetchone()
    cur.close()
    conn.close()
    return results

def get_custom_query(query, vars=None):
    assert query
    conn = psycopg2.connect(config.db['db_string'])
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(query, vars)
    results = cur.fetchall()
    cur.close()
    conn.close()
    return results

def get_favorited_twaats_for_user(id):
    assert id
    query = """
    SELECT * FROM favorited_twaats WHERE who_id = %s
    """
    conn = psycopg2.connect(config.db['db_string'])
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute(query, (id,))
    twaats = [dict(record) for record in cur.fetchall()] # it calls .fecthone() in loop
    cur.close()
    conn.close()
    return twaats

def get_search_results(type, term):
    term = str(term.lower())
    query = '';
    if type.lower() in 'users':
        query = """SELECT * FROM users WHERE lower(full_name) like %s """
    if type.lower() == 'tags':
        return ['not implemented yet']

    try:
        conn = psycopg2.connect(config.db['db_string'])
        cur = conn.cursor()
        cur.execute(query, (['%'+term+'%']))
        search_results = cur.fetchall()
        #some problems with psycon, doesnt accept loop here..
        cur.close()
        conn.close()
        return [User(x[0], x[1], x[2], x[3], x[4], x[5], x[6]) for x in search_results]
    except Exception as e:
        print e
        return e
    

# INSERT stuff

def insert_new_favorite_twaat_for_id(twaat_id, user_id):
    try:
        conn = psycopg2.connect(config.db['db_string'])
        cur = conn.cursor()
        cur.execute("""
        INSERT INTO favorited_twaats (who_id, twaat_id) VALUES (%s, %s)
        """, (user_id, twaat_id))
        conn.commit()
        cur.close()
        conn.close()
    except Exception as e:
        if('duplicate' in e.pgerror):
            return 'Twaat already favorited'
        print e
        return e

def insert_new_twaat(user_id, text, parent_id):
    try:
        conn = get_connection()
        cur = conn.cursor()
        cur.execute("""
        INSERT INTO twaat (user_id, text, parent_id) VALUES (%s, %s, %s)
        """, (user_id, text, parent_id))
        conn.commit()
        cur.close()
        conn.close()
        # session['username'] = request.form['username']
    except Exception as e:
        print e
        return e


# UPDATE STUFF

def update_custom_query(query, vars=None):
    try:
        conn = get_connection()
        cur = conn.cursor()
        cur.execute(query, vars)
        conn.commit()
        cur.close()
        conn.close()
    except Exception as e:
        if('duplicate' in e.pgerror):
            return 'Twaat already favorited'
        print e
        return e
