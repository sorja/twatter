drop table if exists user;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  full_name varchar(64) NOT NULL,
  email varchar(64) UNIQUE NOT NULL,
  password varchar NOT NULL,
  timestamp timestamp default current_timestamp
);

drop table if exists twaaat;
CREATE TABLE twaat (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  parent_id INTEGER REFERENCES twaat(id),
  text varchar(256),
  img varchar(512),
  timestamp timestamp default current_timestamp,
  favorited_count INTEGER
);

drop table if exists follower;
create table follower (
  who_id integer,
  whom_id integer
);
