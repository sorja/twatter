import random
import string
db = dict(
    db_string = "dbname=sorja user=sorja"
)

app = dict(
    secret_key = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits) for _ in range(64)),
    debug = True
)
