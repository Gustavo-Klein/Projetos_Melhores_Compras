-- Gerado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   em:        2023-03-16 23:59:55 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



DROP TABLE t_sgv_cat_chamado CASCADE CONSTRAINTS;

DROP TABLE t_sgv_cat_produto CASCADE CONSTRAINTS;

DROP TABLE t_sgv_cat_video CASCADE CONSTRAINTS;

DROP TABLE t_sgv_chamado CASCADE CONSTRAINTS;

DROP TABLE t_sgv_cliente CASCADE CONSTRAINTS;

DROP TABLE t_sgv_cliente_fisico CASCADE CONSTRAINTS;

DROP TABLE t_sgv_cliente_juridico CASCADE CONSTRAINTS;

DROP TABLE t_sgv_funcionario CASCADE CONSTRAINTS;

DROP TABLE t_sgv_item_pedido CASCADE CONSTRAINTS;

DROP TABLE t_sgv_pedido CASCADE CONSTRAINTS;

DROP TABLE t_sgv_produto CASCADE CONSTRAINTS;

DROP TABLE t_sgv_video_produto CASCADE CONSTRAINTS;

DROP TABLE t_sgv_visu_video CASCADE CONSTRAINTS;

DROP SEQUENCE sq_sgv_cat_produto;

DROP SEQUENCE sq_sgv_produto;

DROP SEQUENCE sq_sgv_chamado;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_sgv_cat_chamado (
    cd_categoria_cham NUMBER(1) NOT NULL,
    ds_chamado        VARCHAR2(10) NOT NULL
);

ALTER TABLE t_sgv_cat_chamado ADD CONSTRAINT pk_t_sgv_cat_chamado PRIMARY KEY ( cd_categoria_cham );

CREATE SEQUENCE sq_sgv_cat_produto
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999999999
	NOCACHE
	NOCYCLE;

CREATE TABLE t_sgv_cat_produto (
    cd_categoria NUMBER(10) DEFAULT sq_sgv_cat_produto.NEXTVAL NOT NULL,
    ds_categoria VARCHAR2(40) NOT NULL,
    st_categoria CHAR(1) NOT NULL,
    dt_inicio    DATE NOT NULL,
    dt_termino   DATE
);

COMMENT ON COLUMN t_sgv_cat_produto.st_categoria IS
    'Uma categoria possui status de “A” (ativo) e “I” (inativo) e somente as categorias ativas são exibidas na plataforma para serem visualizadas.'
    ;

ALTER TABLE t_sgv_cat_produto
    ADD CONSTRAINT ck_sgv_cat_prod_st CHECK ( st_categoria = 'A'
                                              OR st_categoria = 'I' );

ALTER TABLE t_sgv_cat_produto ADD CONSTRAINT pk_t_sgv_cat_produto PRIMARY KEY ( cd_categoria );

ALTER TABLE t_sgv_cat_produto ADD CONSTRAINT un_sgv_cat_prod_dscat UNIQUE ( ds_categoria );

CREATE TABLE t_sgv_cat_video (
    cd_categoria_vid NUMBER(10) NOT NULL,
    ds_categoria_vid VARCHAR2(40) NOT NULL
);

ALTER TABLE t_sgv_cat_video ADD CONSTRAINT pk_t_sgv_cat_video PRIMARY KEY ( cd_categoria_vid );

CREATE SEQUENCE sq_sgv_chamado
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999999999
	NOCACHE
	NOCYCLE;

CREATE TABLE t_sgv_chamado (
    cd_chamado        NUMBER(10) DEFAULT sq_sgv_chamado.NEXTVAL NOT NULL,
    cd_categoria_cham NUMBER(1) NOT NULL,
    cd_cliente        NUMBER(10) NOT NULL,
    cd_funcionario    NUMBER(10) NOT NULL,
    cd_produto        NUMBER(10) NOT NULL,
    ds_chamado        VARCHAR2(4000) NOT NULL,
    dt_abertura       DATE NOT NULL,
    dt_atendimento    DATE,
    st_chamado        CHAR(1) NOT NULL,
    tempo_atend       NUMBER(4),
    indice_satisf     NUMBER(2)
);

COMMENT ON COLUMN t_sgv_chamado.st_chamado IS
    '“A” (aberto), o primeiro status criado no início; “E” (em atendimento); “C” (cancelado)”; “F” (fechado com sucesso); “X” (fechado com insatisfação do cliente), conforme for evoluindo o atendimento.'
    ;

COMMENT ON COLUMN t_sgv_chamado.indice_satisf IS
    '1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito.';

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT ck_sgv_cham_st CHECK ( st_chamado = 'A'
                                          OR st_chamado = 'E'
                                          OR st_chamado = 'C'
                                          OR st_chamado = 'F'
                                          OR st_chamado = 'X' );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT ck_sgv_cham_is CHECK (indice_satisf > 0 AND indice_satifs < 11);

ALTER TABLE t_sgv_chamado ADD CONSTRAINT pk_t_sgv_chamado PRIMARY KEY ( cd_chamado );

CREATE TABLE t_sgv_cliente (
    cd_cliente       NUMBER(10) NOT NULL,
    tp_pessoa        VARCHAR2(10) NOT NULL,
    nm_cliente       VARCHAR2(50) NOT NULL,
    qt_estrelas      NUMBER(1),
    st_cliente       CHAR(1) NOT NULL,
    nr_telefone      VARCHAR2(13),
    email_cliente    VARCHAR2(25),
    cep              VARCHAR2(10),
    endereco_cliente VARCHAR2(100),
    login_cliente    VARCHAR2(10) NOT NULL,
    senha_cliente    VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN t_sgv_cliente.endereco_cliente IS
    'Endereço do cliente no seguinte formato: Tipo de logradouro  Nome do logradouro, numero da residência ou estabelecimento, bairro, cidade - estado'
    ;

ALTER TABLE t_sgv_cliente ADD CONSTRAINT pk_t_sgv_cliente PRIMARY KEY ( cd_cliente );

CREATE TABLE t_sgv_cliente_fisico (
    cd_cliente        NUMBER(10) NOT NULL,
    rg                VARCHAR2(11) NOT NULL,
    cpf               VARCHAR2(15) NOT NULL,
    dt_nascimento     DATE NOT NULL,
    sexo              CHAR(1) NOT NULL,
    genero_nascimento CHAR(1)
);

COMMENT ON COLUMN t_sgv_cliente_fisico.genero_nascimento IS
    'Gênero biologico do cliente, caso o mesmo não se identifique como CIS.';

ALTER TABLE t_sgv_cliente_fisico ADD CONSTRAINT pk_t_sgv_cliente_fisico PRIMARY KEY ( cd_cliente );

ALTER TABLE t_sgv_cliente_fisico ADD CONSTRAINT un_sgv_cli_fis_cpf UNIQUE ( cpf );

ALTER TABLE t_sgv_cliente_fisico ADD CONSTRAINT un_sgv_cli_fis_rg UNIQUE ( cpf,
                                                                           rg );

CREATE TABLE t_sgv_cliente_juridico (
    cd_cliente    NUMBER(10) NOT NULL,
    cnpj          VARCHAR2(20) NOT NULL,
    dt_fundacao   DATE,
    insc_estadual VARCHAR2(11)
);

ALTER TABLE t_sgv_cliente_juridico ADD CONSTRAINT pk_t_sgv_cliente_juridico PRIMARY KEY ( cd_cliente );

ALTER TABLE t_sgv_cliente_juridico ADD CONSTRAINT un_sgv_cli_jurid_cnpj UNIQUE ( cnpj );

ALTER TABLE t_sgv_cliente_juridico ADD CONSTRAINT un_sgv_cli_jurid_ie UNIQUE ( insc_estadual );

CREATE TABLE t_sgv_funcionario (
    cd_funcionario    NUMBER(10) NOT NULL,
    nm_funcionario    VARCHAR2(50) NOT NULL,
    cpf               VARCHAR2(15) NOT NULL,
    dt_nascimento     DATE NOT NULL,
    nr_telefone       VARCHAR2(13) NOT NULL,
    email_funcionario VARCHAR2(25) NOT NULL,
    cargo             VARCHAR2(20) NOT NULL,
    departamento      VARCHAR2(30) NOT NULL
);

ALTER TABLE t_sgv_funcionario ADD CONSTRAINT pk_t_sgv_funcionario PRIMARY KEY ( cd_funcionario );

ALTER TABLE t_sgv_funcionario ADD CONSTRAINT un_sgv_func_cpf UNIQUE ( cpf );

CREATE TABLE t_sgv_item_pedido (
    cd_item    NUMBER(10) NOT NULL,
    cd_pedido  NUMBER(10) NOT NULL,
    cd_produto NUMBER(10) NOT NULL,
    qtd_itens  INTEGER NOT NULL
);

ALTER TABLE t_sgv_item_pedido ADD CONSTRAINT pk_t_sgv_item_pedido PRIMARY KEY ( cd_pedido,
                                                                                cd_item );

CREATE TABLE t_sgv_pedido (
    cd_pedido  NUMBER(10) NOT NULL,
    cd_cliente NUMBER(10) NOT NULL,
    dt_pedido  DATE NOT NULL
);

ALTER TABLE t_sgv_pedido ADD CONSTRAINT pk_t_sgv_pedido PRIMARY KEY ( cd_pedido );

CREATE SEQUENCE sq_sgv_produto
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999999999
	NOCACHE
	NOCYCLE;

CREATE TABLE t_sgv_produto (
    cd_produto      NUMBER(10) DEFAULT sq_sgv_produto.NEXTVAL NOT NULL,
    cd_categoria    NUMBER(10) NOT NULL,
    ds_produto      VARCHAR2(40) NOT NULL,
    ds_comp_produto VARCHAR2(60) NOT NULL,
    cd_barras       NUMBER(13),
    preco_unit      NUMBER(7, 2) NOT NULL,
    st_produto      CHAR(1) DEFAULT 'A' NOT NULL
);

COMMENT ON COLUMN t_sgv_produto.st_produto IS
    'É necessário que o status esteja com a sigla “A” de ativo, pois existem situações em que o produto não deve ser visualizado pelos clientes e que podem estar com outros status como: “I” (inativo) ou “P” (prospecção).'
    ;

ALTER TABLE t_sgv_produto
    ADD CONSTRAINT ck_sgv_prod_st CHECK ( st_produto = 'A'
                                          OR st_produto = 'I'
                                          OR st_produto = 'P' );

ALTER TABLE t_sgv_produto ADD CONSTRAINT pk_t_sgv_produto PRIMARY KEY ( cd_produto );

ALTER TABLE t_sgv_produto ADD CONSTRAINT un_sgv_prod_dsprod UNIQUE ( ds_produto );

CREATE TABLE t_sgv_video_produto (
    cd_video         NUMBER(10) NOT NULL,
    cd_produto       NUMBER(10) NOT NULL,
    cd_categoria_vid NUMBER(10) NOT NULL,
    st_video         CHAR(1) NOT NULL,
    dt_cadastro       DATE
);

COMMENT ON COLUMN t_sgv_video_produto.st_video IS
    'Um vídeo possui status de “A” (ativo) e “I” (inativo) e somente os vídeos com status ativo estão disponíveis para serem exibidos na plataforma. Vídeos com status inativo ou em prospecção compõem o restante desses dados.
';

ALTER TABLE t_sgv_video_produto
    ADD CONSTRAINT ck_sgv_vid_produto_st CHECK ( st_video = 'A'
                                                 OR st_video = 'I'
                                                 OR st_video = 'P' );

ALTER TABLE t_sgv_video_produto ADD CONSTRAINT pk_t_sgv_video_produto PRIMARY KEY ( cd_video );

CREATE TABLE t_sgv_visu_video (
    cd_visualizacao NUMBER(10) NOT NULL,
    cd_video        NUMBER(10) NOT NULL,
    cd_produto      NUMBER(10) NOT NULL,
    dt_visualizacao DATE NOT NULL,
    login_cliente   VARCHAR2(10) DEFAULT NULL
);

ALTER TABLE t_sgv_visu_video ADD CONSTRAINT pk_t_sgv_visu_video PRIMARY KEY ( cd_visualizacao,
                                                                              cd_video );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT fk_sgv_cham_cat_cham FOREIGN KEY ( cd_categoria_cham )
        REFERENCES t_sgv_cat_chamado ( cd_categoria_cham );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT fk_sgv_cham_cli FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT fk_sgv_cham_func FOREIGN KEY ( cd_funcionario )
        REFERENCES t_sgv_funcionario ( cd_funcionario );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT fk_sgv_cham_prod FOREIGN KEY ( cd_produto )
        REFERENCES t_sgv_produto ( cd_produto );

ALTER TABLE t_sgv_cliente_fisico
    ADD CONSTRAINT fk_sgv_cli_fis_cli FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_cliente_juridico
    ADD CONSTRAINT fk_sgv_cli_jurid_cli FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_item_pedido
    ADD CONSTRAINT fk_sgv_item_ped_ped FOREIGN KEY ( cd_pedido )
        REFERENCES t_sgv_pedido ( cd_pedido );

ALTER TABLE t_sgv_item_pedido
    ADD CONSTRAINT fk_sgv_item_ped_prod FOREIGN KEY ( cd_produto )
        REFERENCES t_sgv_produto ( cd_produto );

ALTER TABLE t_sgv_pedido
    ADD CONSTRAINT fk_sgv_ped_cli FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_produto
    ADD CONSTRAINT fk_sgv_prod_cat_prod FOREIGN KEY ( cd_categoria )
        REFERENCES t_sgv_cat_produto ( cd_categoria );

ALTER TABLE t_sgv_video_produto
    ADD CONSTRAINT fk_sgv_vid_prod_cat_vid FOREIGN KEY ( cd_categoria_vid )
        REFERENCES t_sgv_cat_video ( cd_categoria_vid );

ALTER TABLE t_sgv_video_produto
    ADD CONSTRAINT fk_sgv_vid_prod_prod FOREIGN KEY ( cd_produto )
        REFERENCES t_sgv_produto ( cd_produto );

ALTER TABLE t_sgv_visu_video
    ADD CONSTRAINT fk_sgv_visu_vid_prod FOREIGN KEY ( cd_produto )
        REFERENCES t_sgv_produto ( cd_produto );

ALTER TABLE t_sgv_visu_video
    ADD CONSTRAINT fk_sgv_visu_vid_vid_prod FOREIGN KEY ( cd_video )
        REFERENCES t_sgv_video_produto ( cd_video );

CREATE OR REPLACE TRIGGER arc_her_t_sgv_cliente_juridico BEFORE
    INSERT OR UPDATE OF cd_cliente ON t_sgv_cliente_juridico
    FOR EACH ROW
DECLARE
    d VARCHAR2(10);
BEGIN
    SELECT
        a.tp_pessoa
    INTO d
    FROM
        t_sgv_cliente a
    WHERE
        a.cd_cliente = :new.cd_cliente;

    IF ( d IS NULL OR d <> 'Juridica' ) THEN
        raise_application_error(
                               -20223,
                               'FK FK_SGV_CLI_JURID_CLI in Table T_SGV_CLIENTE_JURIDICO violates Arc constraint on Table T_SGV_CLIENTE - discriminator column tp_pessoa doesn''t have value ''Juridica'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_heran_t_sgv_cliente_fisico BEFORE
    INSERT OR UPDATE OF cd_cliente ON t_sgv_cliente_fisico
    FOR EACH ROW
DECLARE
    d VARCHAR2(10);
BEGIN
    SELECT
        a.tp_pessoa
    INTO d
    FROM
        t_sgv_cliente a
    WHERE
        a.cd_cliente = :new.cd_cliente;

    IF ( d IS NULL OR d <> 'Fisica' ) THEN
        raise_application_error(
                               -20223,
                               'FK FK_SGV_CLI_FIS_CLI in Table T_SGV_CLIENTE_FISICO violates Arc constraint on Table T_SGV_CLIENTE - discriminator column tp_pessoa doesn''t have value ''Fisica'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            13
-- CREATE INDEX                             0
-- ALTER TABLE                             39
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0