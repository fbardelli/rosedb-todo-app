CREATE TABLE status (
    id INTEGER PRIMARY KEY,
    name VARCHAR(25),
    description VARCHAR(200),
    UNIQUE(name)
);
INSERT INTO status VALUES (NULL, "Not Started","");
INSERT INTO status VALUES (NULL, "In progress","");
INSERT INTO status VALUES (NULL, "Completed","");
