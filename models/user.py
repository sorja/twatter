from flask.ext.login  import UserMixin
class User(UserMixin):
    def __init__(self, id, full_name, email, password, created_at):
        self.id = id
        self.email = email
        self.full_name = full_name
        self.password = password
        self.created_at = created_at

    def __repr__(self):
        return "%d/%s/%s" % (self.id, self.full_name, self.password)
