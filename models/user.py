from flask_login  import UserMixin
class User(UserMixin):
    __tablename__ = 'users'
    def __init__(self, id, full_name, email, password, created_at, avatar, description):
        self.id = id
        self.email = email
        self.full_name = full_name
        self.password = password
        self.created_at = created_at
        #hack
        self.timestamp = created_at
        self.avatar = avatar
        self.description = description

    def __repr__(self):
        return "%d / %s / %s / %s / %s" % (self.id, self.email, self.full_name, self.password, self.created_at)
