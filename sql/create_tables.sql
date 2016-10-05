CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  full_name varchar(64) NOT NULL,
  email varchar(64) UNIQUE NOT NULL,
  password varchar NOT NULL,
  avatar varchar,
  description varchar(256),
  timestamp timestamp default current_timestamp
);

CREATE TABLE twaat (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  parent_id INTEGER REFERENCES twaat(id),
  text varchar(256),
  img varchar(512),
  timestamp timestamp default current_timestamp,
  favorited_count INTEGER DEFAULT 0,
  deleted boolean default false
);

CREATE TABLE favorited_twaats (
  who_id integer REFERENCES users(id),
  twaat_id integer REFERENCES twaat(id),
  PRIMARY KEY(who_id, twaat_id)
);

create table follower (
  who_id integer REFERENCES users(id),
  whom_id integer REFERENCES users(id),
  PRIMARY KEY(who_id, whom_id)
);
