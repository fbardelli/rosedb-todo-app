CREATE TABLE tasks (
    id INTEGER PRIMARY KEY,
    short_description VARCHAR(100),
    long_description TEXT,
    start_date DATETIME,
    end_date DATETIME,
    status_id INTEGER,
    FOREIGN KEY(status_id) REFERENCES status(id)
);
