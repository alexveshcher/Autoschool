CREATE TABLE workers
(
  id         INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  lastname   VARCHAR(25)                                 NOT NULL,
  firstname  VARCHAR(25)                                 NOT NULL,
  patronymic VARCHAR(25)                                 NOT NULL,
  phone      VARCHAR(14)                                 NOT NULL,
  born       DATE                                        NOT NULL
);
CREATE TABLE lectors
(
  id            INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  teaches_since YEAR(4)                                     NOT NULL,
  CONSTRAINT lectrors_ibfk_1 FOREIGN KEY (id) REFERENCES workers (id)
);
CREATE TABLE instructors
(
  id              INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  licence_expires DATE                                        NOT NULL,
  licence_num     VARCHAR(10)                                 NOT NULL,
  CONSTRAINT instructors_ibfk_1 FOREIGN KEY (id) REFERENCES workers (id)
);

CREATE TABLE groups
(
  id        INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  starttime DATE                                        NOT NULL
);
CREATE TABLE students
(
  id            INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  lastname      VARCHAR(25)                                 NOT NULL,
  firstname     VARCHAR(25)                                 NOT NULL,
  patronymic    VARCHAR(25)                                 NOT NULL,
  born          DATE                                        NOT NULL,
  reg_date      DATE                                        NOT NULL,
  phone         VARCHAR(10)                                 NOT NULL,
  category      VARCHAR(3)                                  NOT NULL,
  group_id      INT(10) UNSIGNED,
  passed_school BIT(1),
  passed_mreo   BIT(1),
  CONSTRAINT group_id___fk FOREIGN KEY (group_id) REFERENCES groups (id)
);

CREATE TABLE vehicles
(
  id          INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  vehicle_num CHAR(10)                                    NOT NULL,
  model       VARCHAR(20)                                 NOT NULL,
  category    VARCHAR(3)                                  NOT NULL,
  UNIQUE (vehicle_num)
);

CREATE TABLE instructorvehicle
(
  id_instructor INT(10) UNSIGNED NOT NULL,
  id_vehicle    INT(10) UNSIGNED NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (id_instructor, id_vehicle),
  CONSTRAINT instructorvehicle_ibfk_1 FOREIGN KEY (id_instructor) REFERENCES instructors (id),
  CONSTRAINT instructorvehicle_ibfk_2 FOREIGN KEY (id_vehicle) REFERENCES vehicles (id)
);
CREATE TABLE lection
(
  id           INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  lection_time TIMESTAMP                                   NOT NULL,
  theme        VARCHAR(40)                                 NOT NULL,
  lector_id    INT(10) UNSIGNED,
  group_id     INT(10) UNSIGNED,
  CONSTRAINT lection_ibfk_1 FOREIGN KEY (lector_id) REFERENCES lectors (id),
  CONSTRAINT lection_ibfk_2 FOREIGN KEY (group_id) REFERENCES groups (id)
);

CREATE TABLE trainings
(
  id            INT(10) UNSIGNED PRIMARY KEY  AUTO_INCREMENT NOT NULL,
  training_time TIMESTAMP                                    NOT NULL,
  duration      INT(1) UNSIGNED                              NOT NULL,
  mark          INT(1) UNSIGNED                              NOT NULL,
  petrol_usage  DECIMAL(4, 2)                                NOT NULL,
  instructor_id INT(10) UNSIGNED                             NOT NULL,
  vehicle_id    INT(10) UNSIGNED                             NOT NULL,
  student_id    INT(10) UNSIGNED                             NOT NULL,
  CONSTRAINT trainings_ibfk_1 FOREIGN KEY (instructor_id) REFERENCES instructors (id),
  CONSTRAINT trainings_ibfk_2 FOREIGN KEY (vehicle_id) REFERENCES vehicles (id),
  CONSTRAINT trainings_ibfk_3 FOREIGN KEY (student_id) REFERENCES students (id)
);