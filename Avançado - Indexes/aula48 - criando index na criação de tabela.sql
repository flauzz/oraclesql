--criando index durante criação de tabela
--na definição da pk ou uk já é criado um index para cada
--primeira alternativa:
CREATE TABLE projects
(project_id    NUMBER(6)    NOT NULL 
CONSTRAINT project_id_pk PRIMARY KEY, --o index criado terá o mesmo nome dessa constrait por default e será um unique index
project_code  VARCHAR2(10) NOT NULL,
project_name  VARCHAR2(100) NOT NULL,
CREATION_DATE DATE DEFAULT sysdate NOT NULL,
START_DATE    DATE,
END_DATE      DATE,
STATUS        VARCHAR2(20) NOT NULL,
PRIORITY      VARCHAR2(10) NOT NULL,
BUDGET        NUMBER(11,2) NOT NULL,
DESCRIPTION   VARCHAR2(400) NOT NULL);

--segunda alternativa:
CREATE TABLE projects
(project_id    NUMBER(6)    NOT NULL 
CONSTRAINT project_id_pk PRIMARY KEY 
USING INDEX (CREATE INDEX project_id_idx ON projects (project_id)), --dessa maneira é dado um nome específico para o index
project_code  VARCHAR2(10) NOT NULL,
project_name  VARCHAR2(100) NOT NULL,
CREATION_DATE DATE DEFAULT sysdate NOT NULL,
START_DATE    DATE,
END_DATE      DATE,
STATUS        VARCHAR2(20) NOT NULL,
PRIORITY      VARCHAR2(10) NOT NULL,
BUDGET        NUMBER(11,2) NOT NULL,
DESCRIPTION   VARCHAR2(400) NOT NULL);

--terceira alternativa:
CREATE TABLE projects
(project_id    NUMBER(6)    NOT NULL 
CONSTRAINT project_id_pk PRIMARY KEY 
USING INDEX (CREATE INDEX project_id_idx ON projects (project_id) TABLESPACE USERS), --dessa maneira é dado um nome e prpriedades específicas
project_code  VARCHAR2(10) NOT NULL,
project_name  VARCHAR2(100) NOT NULL,
CREATION_DATE DATE DEFAULT sysdate NOT NULL,
START_DATE    DATE,
END_DATE      DATE,
STATUS        VARCHAR2(20) NOT NULL,
PRIORITY      VARCHAR2(10) NOT NULL,
BUDGET        NUMBER(11,2) NOT NULL,
DESCRIPTION   VARCHAR2(400) NOT NULL);
--por default era utilizada a tablespace sysaux