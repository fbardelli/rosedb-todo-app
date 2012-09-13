CREATE TABLE status_code (
    id INTEGER PRIMARY KEY,
    name VARCHAR(25),
    description VARCHAR(200),
    UNIQUE(name)
);
INSERT INTO status_code VALUES (NULL, "Not Started","");
INSERT INTO status_code VALUES (NULL, "In progress","");
INSERT INTO status_code VALUES (NULL, "Completed","");
