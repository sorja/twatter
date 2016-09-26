INSERT INTO users ("full_name", "email", "password") VALUES ('123', '123', '123');
INSERT INTO users ("full_name", "email", "password") VALUES ('Matti Niemi', 'matti.niemi@email.com', 'passw0rd');

INSERT INTO users ("full_name", "email", "password") VALUES ('Sami Niemi', 'sami.niemi@email.com', 'passw0rd');

INSERT INTO users ("full_name", "email", "password") VALUES ('Kalle Niemi', 'kalle.niemi@email.com', 'passw0rd');

INSERT INTO follower ("who_id", "whom_id") VALUES (2, 1);

INSERT INTO twaat ("user_id", text) VALUES (1, 'I am the first twaat, hello world');
INSERT INTO twaat ("user_id", text) VALUES (25, 'Lorem ipsum dolor sit amet, consect');
INSERT INTO twaat ("user_id", text) VALUES (21, 'Lorem dolor sit amet, consect');
INSERT INTO twaat ("user_id", text) VALUES (25, 'Lorem dolor sit amet, consect foo Bar');
INSERT INTO twaat ("user_id", text, parent_id) VALUES (1, 'second', 1);
