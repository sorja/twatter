#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, os
import config
from twatter import app
sys.path.insert(0, config.PROJ_DIR)

if __name__ == "__main__":
    print type(app)
    app.run(host='0.0.0.0')


# //TODO: Figure out why this doesnt work
# 
# # Import applications into namespace
# for application in config.APPLICATIONS:
#     __import__('.'.join((config.APPS_DIR, application)))
#     try:
#         module_name = '.'.join((application, 'views'))
#         __import__(module_name)
#     except ImportError as e:
#         pass
#     else:
#         print 'imported: %s' % module_name

# #Import utils into namespace (for imports etc)
# utils_path = os.listdir(os.path.join(config.PROJ_NAME, 'utils'))
# for module in utils_path:
#     if not module.endswith('.py'):
#         continue
#     module_name = module[:-3]
#     try:
#         __import__('.'.join(('utils', module_name)))
#     except ImportError:
#         pass
        