CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(64) NOT NULL,
  email VARCHAR(64) UNIQUE NOT NULL,
  password VARCHAR NOT NULL,
  avatar VARCHAR,
  description VARCHAR(256),
  timestamp timestamp default current_timestamp
);

CREATE TABLE twaat (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  parent_id INTEGER REFERENCES twaat(id),
  text VARCHAR(256),
  img VARCHAR(512),
  timestamp timestamp default current_timestamp,
  favorited_count INTEGER DEFAULT 0,
  deleted boolean default false
);

CREATE TABLE favorited_twaats (
  who_id INTEGER REFERENCES users(id),
  twaat_id INTEGER REFERENCES twaat(id),
  PRIMARY KEY(who_id, twaat_id)
);

CREATE TABLE follower (
  who_id INTEGER REFERENCES users(id),
  whom_id INTEGER REFERENCES users(id),
  deleted boolean default false,
  PRIMARY KEY(who_id, whom_id)
);

CREATE TABLE tag (
  user_id INTEGER REFERENCES users(id),
  text VARCHAR(24),
  id SERIAL,
  twaat_id INTEGER REFERENCES twaat(id),
  PRIMARY KEY(user_id, text)
);