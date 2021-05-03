-- criando constraints durante cria��o de tabelas. s�o regras de integridade n�o viol�veis
-- tipos: not null, unique, primary key, foreign key, check
-- ao criar uma d�-se um nome ou deixa o default: SYS_Cn
-- normalmente constraints not null deixa-se o nome default
-- cria no momento de cria��o de uma tabela ou depois
-- cria��o a nivel de coluna: ao especificar uma coluna j� inserir as constraints onde quer
-- cria��o a n�vel de tabela: especificar todas as colunas e ao final inserir as constraints
-- not null: garante que n�o seja permitido null na coluna. ao definir primary key automaticamente ser� not null
-- primary key: melhor identificador da tabela. imp�e not null e s�o �nicas para cada linha. um �ndice �nico � criado automaticamente
-- unique: � um identificador da tabela. especifica que aquela coluna ter� valores �nicos para cada linha. permite null. �ltimo item anterior
-- foreign key: estabelece a rela��o com outra tabela. garante integridade referencial. n�o � criado �ndice �nico automaticamente

-- definindo constraint not null a nivel de coluna:
DROP TABLE projects;

SELECT *
FROM projects;

CREATE TABLE projects
(project_id     NUMBER(6)            NOT NULL,
project_code    VARCHAR2(10)         NOT NULL,
project_name    VARCHAR2(100)        NOT NULL,
creation_date   DATE DEFAULT sysdate NOT NULL,
start_date      DATE,
end_date        DATE,
status          VARCHAR2(20)         NOT NULL,
priority        VARCHAR2(10)         NOT NULL,
budget          NUMBER(11,2)         NOT NULL,
description     VARCHAR2(400)        NOT NULL);

-- definindo constraint primary key a nivel de coluna:
DROP TABLE projects;

SELECT *
FROM projects;
-- um padr�o de nome para primary key � nomedatabela_nomedacoluna_pk
CREATE TABLE projects
(project_id     NUMBER(6)            NOT NULL
CONSTRAINT projects_project_id_pk    PRIMARY KEY,
project_code    VARCHAR2(10)         NOT NULL,
project_name    VARCHAR2(100)        NOT NULL,
creation_date   DATE DEFAULT sysdate NOT NULL,
start_date      DATE,
end_date        DATE,
status          VARCHAR2(20)         NOT NULL,
priority        VARCHAR2(10)         NOT NULL,
budget          NUMBER(11,2)         NOT NULL,
description     VARCHAR2(400)        NOT NULL);

-- definindo constraint primary key a nivel de tabela:
DROP TABLE projects;

SELECT *
FROM projects;
-- um padr�o de nome para primary key � nomedatabela_nomedacoluna_pk
CREATE TABLE projects
(project_id     NUMBER(6)            NOT NULL,
project_code    VARCHAR2(10)         NOT NULL,
project_name    VARCHAR2(100)        NOT NULL,
creation_date   DATE DEFAULT sysdate NOT NULL,
start_date      DATE,
end_date        DATE,
status          VARCHAR2(20)         NOT NULL,
priority        VARCHAR2(10)         NOT NULL,
budget          NUMBER(11,2)         NOT NULL,
description     VARCHAR2(400)        NOT NULL,
CONSTRAINT projects_project_id_pk    PRIMARY KEY(project_id));

-- definindo constraint unique a nivel de coluna:
DROP TABLE projects;

SELECT *
FROM projects;
-- um padr�o de nome para unique � nomedatabela_nomedacoluna_uk
CREATE TABLE projects
(project_id     NUMBER(6)            NOT NULL
CONSTRAINT projects_project_id_pk    PRIMARY KEY,
project_code    VARCHAR2(10)         NOT NULL
CONSTRAINT projects_project_code_uk  UNIQUE,
project_name    VARCHAR2(100)        NOT NULL,
creation_date   DATE DEFAULT sysdate NOT NULL,
start_date      DATE,
end_date        DATE,
status          VARCHAR2(20)         NOT NULL,
priority        VARCHAR2(10)         NOT NULL,
budget          NUMBER(11,2)         NOT NULL,
description     VARCHAR2(400)        NOT NULL);

-- definindo constraint unique a nivel de tabela:
DROP TABLE projects;

SELECT *
FROM projects;
-- um padr�o de nome para unique � nomedatabela_nomedacoluna_uk
CREATE TABLE projects
(project_id     NUMBER(6)            NOT NULL,
project_code    VARCHAR2(10)         NOT NULL,
project_name    VARCHAR2(100)        NOT NULL,
creation_date   DATE DEFAULT sysdate NOT NULL,
start_date      DATE,
end_date        DATE,
status          VARCHAR2(20)         NOT NULL,
priority        VARCHAR2(10)         NOT NULL,
budget          NUMBER(11,2)         NOT NULL,
description     VARCHAR2(400)        NOT NULL,
CONSTRAINT projects_project_id_pk    PRIMARY KEY(project_id),
CONSTRAINT projects_project_code_uk  UNIQUE(project_code));

-- definindo constraint foreign key a nivel de coluna:
DROP TABLE projects;

DESC departments;

SELECT *
FROM projects;
-- um padr�o de nome para foreign key � nomedatabela_nomedacoluna_fk
CREATE TABLE projects
(project_id     NUMBER(6)            NOT NULL
CONSTRAINT projects_project_id_pk    PRIMARY KEY,
project_code    VARCHAR2(10)         NOT NULL
CONSTRAINT projects_project_code_uk  UNIQUE,
project_name    VARCHAR2(100)        NOT NULL,
department_id   NUMBER(4)            NOT NULL
CONSTRAINT projects_department_id_fk REFERENCES departments(department_id), --o departamento inserido tem que existir na tabela departments
creation_date   DATE DEFAULT sysdate NOT NULL,
start_date      DATE,
end_date        DATE,
status          VARCHAR2(20)         NOT NULL,
priority        VARCHAR2(10)         NOT NULL,
budget          NUMBER(11,2)         NOT NULL,
description     VARCHAR2(400)        NOT NULL);

-- definindo constraint foreign key a nivel de tabela:
DROP TABLE projects;

DESC departments;

SELECT *
FROM projects;
-- um padr�o de nome para foreign key � nomedatabela_nomedacoluna_fk
CREATE TABLE projects
(project_id     NUMBER(6)            NOT NULL,
project_code    VARCHAR2(10)         NOT NULL,
project_name    VARCHAR2(100)        NOT NULL,
department_id   NUMBER(4)            NOT NULL,
creation_date   DATE DEFAULT sysdate NOT NULL,
start_date      DATE,
end_date        DATE,
status          VARCHAR2(20)         NOT NULL,
priority        VARCHAR2(10)         NOT NULL,
budget          NUMBER(11,2)         NOT NULL,
description     VARCHAR2(400)        NOT NULL,
CONSTRAINT projects_project_id_pk    PRIMARY KEY(project_id),
CONSTRAINT projects_project_code_uk  UNIQUE(project_code),
CONSTRAINT projects_department_id_fk FOREIGN KEY(department_id)
REFERENCES departments(department_id)); --references pode ser pela primary key ou pela unique em teoria, na pr�tica nunca

-- foreign key dele��o(usar/drop delete): no action, on delete cascade, on delete set null
-- no action: � default
-- on delete cascade: delete m�e e filhas
-- on delete set null: converte dependentes para null

--no action:
DROP TABLE teams;

CREATE TABLE teams
(project_id NUMBER(6)           NOT NULL,
employee_id NUMBER(6)           NOT NULL,
CONSTRAINT teams_project_id_fk  FOREIGN KEY(project_id)
REFERENCES projects(project_id),
CONSTRAINT teams_employee_id_fk FOREIGN KEY(employee_id)
REFERENCES employees(employee_id));
--ao tentar deletar um projeto da tabela projects dar� erro, por padr�o no action n�o permite qlqr a��o. op��o mais comum

--on delete cascade:
DROP TABLE teams;

CREATE TABLE teams
(project_id NUMBER(6)           NOT NULL,
employee_id NUMBER(6)           NOT NULL,
CONSTRAINT teams_project_id_fk  FOREIGN KEY(project_id)
REFERENCES projects(project_id) ON DELETE CASCADE,
CONSTRAINT teams_employee_id_fk FOREIGN KEY(employee_id)
REFERENCES employees(employee_id));
--ao tentar deletar um projeto da tabela projects ser� deletada todas as depend�ncias em cascata (os times tbm ser�o deletados). pouco usada

--on delete set null:
DROP TABLE teams;

CREATE TABLE teams
(project_id NUMBER(6), --tira-se o not null para que o tipo de dele��o possa funcionar
employee_id NUMBER(6)           NOT NULL,
CONSTRAINT teams_project_id_fk  FOREIGN KEY(project_id)
REFERENCES projects(project_id) ON DELETE SET NULL,
CONSTRAINT teams_employee_id_fk FOREIGN KEY(employee_id)
REFERENCES employees(employee_id));
--ao tentar deletar um projeto da tabela projects, as depend�ncias ser�o vertidas em null. raramente usada

--constraint check. faz uma valida��o colocada entre par�nteses
--s� n�o pode: referenciar pseudo-colunas(currval, nextval, level, rownum), chamar fun��es(sysdate, uid, user, userenv)
--e referenciar colunas de outras tabelas ou outras linhas da mesma tabela

--visualizando o retorno das fun��es que n�o podem ser chamadas no check:
SELECT uid, user, userenv('language'), sysdate
FROM dual;

--visualizando pseudo-colunas que n�o podem ser chamadas no check:
SELECT employee_id, first_name, rownum
FROM employees
ORDER BY employee_id;

-- definindo constraint check a nivel de coluna:
DROP TABLE projects; --como existe refer�ncias a essa tabela n�o � poss�vel apag�-la dessa forma
DROP TABLE projects CASCADE CONSTRAINTS; --remove a tabela e as constraints de foreign keys que apontam pra ela

SELECT *
FROM projects;
-- um padr�o de nome para check � nomedatabela_nomedacoluna_ck
CREATE TABLE projects
(project_id     NUMBER(6)            NOT NULL
CONSTRAINT projects_project_id_pk    PRIMARY KEY,
project_code    VARCHAR2(10)         NOT NULL
CONSTRAINT projects_project_code_uk  UNIQUE,
project_name    VARCHAR2(100)        NOT NULL,
department_id   NUMBER(4)            NOT NULL
CONSTRAINT projects_department_id_fk REFERENCES departments(department_id),
creation_date   DATE DEFAULT sysdate NOT NULL,
start_date      DATE,
end_date        DATE,
status          VARCHAR2(20)         NOT NULL,
priority        VARCHAR2(10)         NOT NULL,
budget          NUMBER(11,2)         NOT NULL
CONSTRAINT projects_budget_ck        CHECK(budget>0), --express�o de valida��o ap�s o check
description     VARCHAR2(400)        NOT NULL);
--ao tentar inserir um projeto com budget zero ou negativo d� erro

-- definindo constraint check a nivel de tabela:
DROP TABLE projects;

SELECT *
FROM projects;
-- um padr�o de nome para check � nomedatabela_nomedacoluna_ck
CREATE TABLE projects
(project_id     NUMBER(6)            NOT NULL,
project_code    VARCHAR2(10)         NOT NULL,
project_name    VARCHAR2(100)        NOT NULL,
department_id   NUMBER(4)            NOT NULL,
creation_date   DATE DEFAULT sysdate NOT NULL,
start_date      DATE,
end_date        DATE,
status          VARCHAR2(20)         NOT NULL,
priority        VARCHAR2(10)         NOT NULL,
budget          NUMBER(11,2)         NOT NULL,
description     VARCHAR2(400)        NOT NULL,
CONSTRAINT projects_project_id_pk    PRIMARY KEY(project_id),
CONSTRAINT projects_project_code_uk  UNIQUE(project_code),
CONSTRAINT projects_department_id_fk FOREIGN KEY(department_id)
REFERENCES departments(department_id),
CONSTRAINT projects_budget_ck        CHECK(budget>0));

--tentando executar um insert violando uma constraint:
INSERT INTO projects(
    project_id, project_code, project_name, department_id, creation_date, start_date,
    end_date, status, priority, budget, description)
VALUES (
    1, 'ERPIMP', 'ERP Implementation', 77, sysdate, NULL, NULL, 'Aproved',
    'HIGH', 1000000.00, 'Oracle ERP Implementation');
--o departamento 77 � inexistente na tabela m�e/de refer�ncia(departments)
--corrigindo o erro anterior (informando um c�digo de departamento que existe):
INSERT INTO projects(
    project_id, project_code, project_name, department_id, creation_date, start_date,
    end_date, status, priority, budget, description)
VALUES (
    1, 'ERPIMP', 'ERP Implementation', 60, sysdate, NULL, NULL, 'Aproved',
    'HIGH', 1000000.00, 'Oracle ERP Implementation');
    
COMMIT; --efetivar o comando dml(insert), a transa��o

--consultando constraints pelo dicion�rio de dados:
DESC user_constraints; --view informa��es sobre constraints

DESC user_cons_columns; --view informa��es sobre as colunas que comp�e uma constraint

--view das constraints de determinada tabela(projects)
SELECT co.constraint_name, co.constraint_type, co.search_condition, co.r_constraint_name, co.delete_rule,
       cc.column_name, cc.position, co.status
FROM user_constraints co
JOIN user_cons_columns cc ON (co.constraint_name = cc.constraint_name)
                          AND (co.table_name = cc.table_name)
WHERE co.table_name = 'PROJECTS' --consultar as constraints da tabela projects. case sensitive
ORDER BY co.constraint_name, cc.position;