from flask_login import UserMixin


class User(UserMixin):
    __tablename__ = 'users'
    def __init__(self, id, full_name, email, password, created_at, avatar, description):
        self.id = str(id)
        self.email = email
        self.full_name = full_name
        self.password = password
        self.created_at = created_at
        #hack
        self.timestamp = created_at
        self.avatar = avatar
        self.description = description

    def getid(self):
        return int(self.id)

    def __repr__(self):
        return "{}\n{}\n{}\n{}\n{}\n".format(self.id, self.email, self.full_name, self.password, self.created_at)

class Twaat():
    __tablename__ = 'twaat'
    user = {}
    
    def __init__(self, id, user_id, parent_id, text, img, timestamp, favorited_count, deleted, *args):
        self.id = id
        self.user_id = user_id
        self.parent_id = parent_id
        self.text = text
        self.img = img
        self.timestamp = timestamp
        self.favorited_count = favorited_count
        self.deleted = deleted
        self.user = args

    def getid(self):
        return int(self.id)

    def __repr__(self):
        return "{}, {}, {}, {}, {}, {}, {}, {}, {}".format(self.id, self.user_id, self.parent_id, self.text, self.img, self.timestamp, self.favorited_count, self.deleted, self.user)
