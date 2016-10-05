import random
import string
import os
db = dict(
    db_string = os.environ['DB_STRING']
)

app = dict(
    secret_key = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits) for _ in range(64)),
    debug = True,
    max_content_length= 16 * 1024 * 1024,
    allowed_extenstions = set(['png', 'jpg', 'jpeg', 'gif']),
    upload_folder = os.environ['UPLOAD_FOLDER']
)
