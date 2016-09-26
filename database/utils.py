import psycopg2
import psycopg2.extras
from .. import config

#GET STUFF

def get_one_with_id(table, id):
    assert table
    assert id
    conn = psycopg2.connect(config.db['db_string'])
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("SELECT * FROM %s WHERE id = %s", (table,id))
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
    print results
    print query
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


# UPDATE STUFF

def update_custom_query(query, vars=None):
    try:
        conn = psycopg2.connect(config.db['db_string'])
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
