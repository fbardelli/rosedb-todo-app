CREATE TABLE status_codes (
    id INTEGER PRIMARY KEY,
    name VARCHAR(25),
    UNIQUE(name)
);
INSERT INTO status_codes VALUES (NULL, "Not Started");
INSERT INTO status_codes VALUES (NULL, "In progress");
INSERT INTO status_codes VALUES (NULL, "Completed");

CREATE TABLE importance (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    UNIQUE(name)
);
INSERT INTO importance VALUES (NULL, "Trivial");
INSERT INTO importance VALUES (NULL, "Minor");
INSERT INTO importance VALUES (NULL, "Normal");
INSERT INTO importance VALUES (NULL, "Major");
INSERT INTO importance VALUES (NULL, "Earth Shattering");


CREATE TABLE task_types (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    UNIQUE(name)
);
INSERT INTO task_types VALUES (NULL, "Bug");
INSERT INTO task_types VALUES (NULL, "New Feature");
INSERT INTO task_types VALUES (NULL, "Tech Debt");

CREATE TABLE tasks (
    id INTEGER PRIMARY KEY,
    short_description VARCHAR(100),
    long_description TEXT,
    start_date DATE,
    end_date DATE,
    status_id INTEGER NOT NULL,
    task_type_id INTEGER NOT NULL,
    importance_id INTEGER NOT NULL,
    FOREIGN KEY(status_id) REFERENCES status_codes (id),
    FOREIGN KEY(task_type_id) REFERENCES task_types(id),
    FOREIGN KEY(importance_id) REFERENCES importance(id)
);

INSERT INTO tasks VALUES ( NULL, "Unimportant Task", "Nobody care about this one", "2012-10-01", "2012-10-31", 1, 1, 1);
