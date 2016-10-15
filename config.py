import random
import string
import os

PROJ_DIR = os.path.dirname(__file__)

DATABASE = {
    "default": {
        "database":"sorja",
        "user":"sorja",
    }
}

DEBUG = True
SECRET_KEY = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits) for _ in range(64))
MAX_CONTENT_LENGTH = 16 * 1024 * 1024
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif'])
PROJ_NAME = 'twatter'
UPLOAD_FOLDER = 'static/uploads'

APPS_DIR = PROJ_NAME + '.twatter'
APPLICATIONS = (
    'authentication',
    'frontpage',
)

#One should move config.py to settings_locals.py
try:
    from settings_locals import *
except ImportError:
    pass
