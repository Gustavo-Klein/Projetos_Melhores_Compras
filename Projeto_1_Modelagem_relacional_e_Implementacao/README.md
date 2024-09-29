# Modelagem e implementação de um banco de dados relacional
## Contextualização
- A empresa Melhores Compras foi criada por estudantes que transformaram um projeto acadêmico de sucesso em um empreendimento promissor no ramo de e-commerce. Com a missão de melhorar o bem-estar das pessoas, a empresa oferece informações relevantes sobre produtos, feedback de consumidores, e as melhores oportunidades de compra. Inicialmente, suas vendas eram por indicação, mas rapidamente cresceram devido à qualidade dos produtos e à eficiência do serviço, alcançando mais de 1.000 pedidos diários em seu primeiro ano. A empresa investiu na experiência do usuário e no atendimento ao cliente, o que atraiu grandes investidores.
## Desafio
- O principal desafio é modernizar e agilizar a organização, substituindo processos manuais e planilhas eletrônicas por soluções de TI robustas. O foco inicial é a criação de uma funcionalidade na plataforma de e-commerce que permita a exibição de vídeos explicativos sobre os produtos. O primeiro passo será criar o modelo de dados relacional baseado em 23 regras de negócio e a criação de 1 Regra de negócio extra definida pelo aluno, que irá suportar o armazenamento dos dados dessa nova funcionalidade (visualização dos vídeos dos produtos), por último, realizar a implementação do SCRIPT de criação do projeto. 
## Ferramentas utilizadas
- 	🔨 Oracle SQL Data Modeler
- 	🔨 Oracle SQL Developer
## Passos para solução
### 📕 Criação de uma nova regra de negócio:
Durante a reunião com o time de negócios foram definidas 23 regras para o desenvolvimento do modelo relacional.

| Número | Descrição da Regra de Negócio (RN) |
|--------|------------------------------------|
| RN01   | Um produto pode ter nenhum ou vários vídeos associados e cada vídeo somente pode ser exibido caso seu status esteja em “A” (ativo). O status do vídeo pode receber apenas os seguintes conteúdos: A(tivo) ou I(nativo). Para essa coluna status do produto, crie uma restrição do tipo check constraint, permitindo apenas o conteúdo A ou I. |
| RN02   | O código de identificação do produto deve ser um número sequencial para ser utilizado como SEQUENCE ou IDENTITY e crescente, de acordo com novos produtos que forem sendo cadastrados. |
| RN03   | A descrição normal do produto, sua descrição completa, e o preço unitário são obrigatórios. Já o código de barras padrão EAN13 ou correspondente deve ser opcional. A descrição normal do produto deve ser única e a sugestão aqui é criar uma constraint do tipo UNIQUE para essa coluna. |
| RN04   | Uma categoria de produto pode estar associada a nenhum ou a vários produtos e um produto somente pode estar associado a uma categoria. |
| RN05   | O código da categoria deve ser um número sequencial para ser utilizado como SEQUENCE ou IDENTITY e crescente, de acordo com novas categorias que forem sendo cadastradas. |
| RN06   | A descrição da categoria, o status e a data de início devem ter conteúdos obrigatoriamente. Já a data de término deve ser opcional, determinando que a categoria está com status “A” (ativo) e operante. Data de término preenchida identifica uma categoria desativada. A descrição da categoria do produto deve ser única e a sugestão aqui é criar uma constraint do tipo UNIQUE para essa coluna. |
| RN07   | Existe a necessidade de se armazenar a data, hora, minutos e segundos da visualização do vídeo. Sendo assim, um vídeo pode ter nenhuma ou várias visualizações e uma visualização pertence a um único vídeo. Vídeos que estão inativos não podem ser visualizados. |
| RN08   | Se o usuário estiver conectado (logado como cliente) é necessário armazenar essa informação. Caso seja um usuário anônimo (não tem login na plataforma), não é necessário armazenar informação. |
| RN09   | A data e hora da visualização são informações obrigatórias, bem como o código do produto visualizado. |
| RN10   | Cada vídeo deve ser classificado. A seguir temos alguns exemplos dessas classificações: Vídeo de instalação do produto; Uso no cotidiano; Comercial com personalidade; entre outros. Existem centenas de tipos de vídeos, sendo assim, sugerimos fortemente uma Entidade aqui. |
| RN11   | Somente o usuário logado (cliente) pode abrir nenhum ou vários chamados de Dúvidas e Sugestões e cada chamado desses deve ser associado a um único cliente. |
| RN12   | Os chamados de dúvidas e sugestões devem conter uma chave única, do tipo numérica com tamanho máximo de 10 números e que possa ser utilizada como SEQUENCE ou IDENTITY. |
| RN13   | Os chamados de dúvidas e sugestões devem conter uma data e hora de abertura do chamado e é uma informação obrigatória. Já a data e hora de atendimento do chamado devem ser opcionais, ou seja, preenchida somente quando um funcionário da Melhores Compras atender. |
| RN14   | Todo chamado tem que ter o código do funcionário associado em algum momento, pois é a partir dele que sabemos quem está realizando o atendimento. Nesse nosso projeto, vamos assumir que o chamado deve ser associado somente a um funcionário e um funcionário pode atender nenhum ou vários chamados. |
| RN15   | Todo chamado tem um status, que permite saber em que situação ele se encontra. Os principais status são: “A” (aberto), o primeiro status criado no início; “E” (em atendimento); “C” (cancelado)”; “F” (fechado com sucesso); “X” (fechado com insatisfação do cliente), conforme for evoluindo o atendimento. Sendo assim esse status é informação obrigatória. |
| RN16   | Todo chamado deve ter o tempo total de atendimento computado desde a abertura até a conclusão dele. A unidade de medida é horas, ou seja, em quantas horas o chamado foi concluído desde a sua abertura. |
| RN17   | Todo chamado dever ter um índice de satisfação, computado como um valor simples de 1 a 10, onde 1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito. Esse índice de satisfação é opcional e informado pelo cliente ao final do atendimento. |
| RN18   | Todo chamado deve ser classificado em 2 tipos: Tipo 1: Sugestão e Tipo 2: Reclamação. Essa informação é obrigatória. |
| RN19   | Todo chamado deve ser associado a um produto. Então um produto pode possuir nenhum ou vários chamados e um chamado pertence a um único produto. |
| RN20   | Todo chamado pode receber um texto escrito pelo cliente internauta contendo no máximo 4.000 caracteres e seu conteúdo é obrigatório. Essa preciosa informação será analisada posteriormente pelo funcionário da Melhores Compras. |
| RN21   | As principais informações do funcionário que trabalha na Melhores Compras são: código do funcionário (PK); nome do funcionário, CPF, data de nascimento, telefone com DDD, e-mail, cargo e nome do departamento em que trabalha. Todas essas informações são obrigatórias. O número do CPF do funcionário deve ser único e a sugestão aqui é criar uma constraint do tipo UNIQUE para essa coluna. |
| RN22   | Para os clientes pessoas físicas que abrem chamado, as principais informações são: código do cliente (PK); nome do cliente (conteúdo obrigatório), quantidade de estrelas (conteúdo opcional), status do cliente (ativo ou inativo) com conteúdo obrigatório, número do telefone (conteúdo opcional), login e senha (conteúdo obrigatório). Não podemos esquecer também o número do CPF (conteúdo obrigatório), data de nascimento (conteúdo obrigatório), sexo biológico (conteúdo obrigatório) e gênero de nascimento (conteúdo opcional). |
| RN23   | Para os clientes pessoas jurídicas que abrem chamado, as principais informações são: código do cliente (PK); nome do cliente (conteúdo obrigatório), quantidade de estrelas (conteúdo opcional), status do cliente (ativo ou inativo) com conteúdo obrigatório, número do telefone (conteúdo opcional), login e senha (conteúdo obrigatório). Não podemos esquecer também a data de fundação (conteúdo opcional), o número no CNPJ (conteúdo opcional) e o número de inscrição estadual (conteúdo opcional). |

O primeiro passo do projeto será definir uma nova regra:

| Número | Nova Descrição da Regra de Negócio (RN) |
|--------|-----------------------------------------|
| RN24   | Um cliente pode fazer varios pedidos, porém um pedido está associado a somente um cliente. É importante que seja armazenado a data do pedido e que cada pedido tenha o seu código próprio, ambas as exigências são obrigatórias. |

### 📊 Desenvolvimento do projeto lógico:

Após analisar cuidadosamente as regras de negócio, foi desenvolvido o modelo lógico abaixo que consiste em refinar o modelo conceitual ao detalhar tabelas (entidades), atributos (colunas) com seus respectivos tipos de dados, chaves primárias (PK) para garantir a unicidade dos registros, e chaves estrangeiras (FK) para estabelecer relacionamentos entre tabelas. Além disso, o modelo lógico define regras de integridade, como integridade referencial, que assegura a consistência dos dados, e restrições como a de unicidade, para evitar a duplicidade de informações. Também são aplicadas regras de normalização para eliminar redundâncias e melhorar a eficiência. [Projeto Lógico PDF](./Arquivo%202_proj_logico_bd.pdf)

![modelologico](https://github.com/user-attachments/assets/ac53a23e-5d43-4f23-82c3-68a5131ca651)

### 💻 Implementação do projeto físico:

Finalizando o projeto lógico podemos seguir com a criação do modelo físico. O modelo físico de dados é a fase final da modelagem de banco de dados, onde o modelo lógico é traduzido em uma implementação real em um Sistema de Gerenciamento de Banco de Dados (SGBD). Nessa etapa, são definidos detalhes técnicos, como a estrutura das tabelas, os tipos de dados exatos (inteiro, varchar, datetime, etc.) compatíveis com o SGBD, bem como as chaves primárias e estrangeiras. Além disso, são aplicadas otimizações de desempenho, como a criação de índices para acelerar consultas e particionamento de tabelas quando necessário. O modelo físico também define as restrições de integridade, como constraints de unicidade, regras de integridade referencial, triggers e procedimentos armazenados que garantem a consistência dos dados. [Projeto Físico PDF](./Arquivo%203_proj_fisico_bd.pdf)

![modelofisico](https://github.com/user-attachments/assets/b929fd3e-9638-4354-8e4e-2c9cc7c1b87a)

### 🔍 Scripts DDL para criação de tabelas e estruturas, assim como comandos para exclusão das estruturas. [Scripts DDL completo](./Arquivo%204_script_bd.SQL)

Criando as tabelas do nosso banco de dados relacional:

```sql
CREATE TABLE t_sgv_cat_chamado (
    cd_categoria_cham NUMBER(1) NOT NULL,
    ds_chamado        VARCHAR2(10) NOT NULL
);

CREATE TABLE t_sgv_cat_produto (
    cd_categoria NUMBER(10) DEFAULT sq_sgv_cat_produto.NEXTVAL NOT NULL,
    ds_categoria VARCHAR2(40) NOT NULL,
    st_categoria CHAR(1) NOT NULL,
    dt_inicio    DATE NOT NULL,
    dt_termino   DATE
);

CREATE TABLE t_sgv_cat_video (
    cd_categoria_vid NUMBER(10) NOT NULL,
    ds_categoria_vid VARCHAR2(40) NOT NULL
);

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

CREATE TABLE t_sgv_cliente_fisico (
    cd_cliente        NUMBER(10) NOT NULL,
    rg                VARCHAR2(11) NOT NULL,
    cpf               VARCHAR2(15) NOT NULL,
    dt_nascimento     DATE NOT NULL,
    sexo              CHAR(1) NOT NULL,
    genero_nascimento CHAR(1)
);

CREATE TABLE t_sgv_cliente_juridico (
    cd_cliente    NUMBER(10) NOT NULL,
    cnpj          VARCHAR2(20) NOT NULL,
    dt_fundacao   DATE,
    insc_estadual VARCHAR2(11)
);

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

CREATE TABLE t_sgv_item_pedido (
    cd_item    NUMBER(10) NOT NULL,
    cd_pedido  NUMBER(10) NOT NULL,
    cd_produto NUMBER(10) NOT NULL,
    qtd_itens  INTEGER NOT NULL
);

CREATE TABLE t_sgv_pedido (
    cd_pedido  NUMBER(10) NOT NULL,
    cd_cliente NUMBER(10) NOT NULL,
    dt_pedido  DATE NOT NULL
);

CREATE TABLE t_sgv_produto (
    cd_produto      NUMBER(10) DEFAULT sq_sgv_produto.NEXTVAL NOT NULL,
    cd_categoria    NUMBER(10) NOT NULL,
    ds_produto      VARCHAR2(40) NOT NULL,
    ds_comp_produto VARCHAR2(60) NOT NULL,
    cd_barras       NUMBER(13),
    preco_unit      NUMBER(7, 2) NOT NULL,
    st_produto      CHAR(1) DEFAULT 'A' NOT NULL
);

CREATE TABLE t_sgv_video_produto (
    cd_video         NUMBER(10) NOT NULL,
    cd_produto       NUMBER(10) NOT NULL,
    cd_categoria_vid NUMBER(10) NOT NULL,
    st_video         CHAR(1) NOT NULL,
    dt_cadastro      DATE
);

CREATE TABLE t_sgv_visu_video (
    cd_visualizacao NUMBER(10) NOT NULL,
    cd_video        NUMBER(10) NOT NULL,
    cd_produto      NUMBER(10) NOT NULL,
    dt_visualizacao DATE NOT NULL,
    login_cliente   VARCHAR2(10) DEFAULT NULL
);
```
Realizando alteração das tabelas:

```sql
ALTER TABLE t_sgv_cat_chamado ADD CONSTRAINT pk_t_sgv_cat_chamado PRIMARY KEY ( cd_categoria_cham );

ALTER TABLE t_sgv_cat_produto
    ADD CONSTRAINT ck_sgv_cat_prod_st CHECK ( st_categoria = 'A' OR st_categoria = 'I' );
ALTER TABLE t_sgv_cat_produto ADD CONSTRAINT pk_t_sgv_cat_produto PRIMARY KEY ( cd_categoria );
ALTER TABLE t_sgv_cat_produto ADD CONSTRAINT un_sgv_cat_prod_dscat UNIQUE ( ds_categoria );

ALTER TABLE t_sgv_cat_video ADD CONSTRAINT pk_t_sgv_cat_video PRIMARY KEY ( cd_categoria_vid );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT ck_sgv_cham_st CHECK ( st_chamado IN ('A', 'E', 'C', 'F', 'X') );
ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT ck_sgv_cham_is CHECK (indice_satisf > 0 AND indice_satisf < 11);
ALTER TABLE t_sgv_chamado ADD CONSTRAINT pk_t_sgv_chamado PRIMARY KEY ( cd_chamado );

ALTER TABLE t_sgv_cliente ADD CONSTRAINT pk_t_sgv_cliente PRIMARY KEY ( cd_cliente );

ALTER TABLE t_sgv_cliente_fisico ADD CONSTRAINT pk_t_sgv_cliente_fisico PRIMARY KEY ( cd_cliente );
ALTER TABLE t_sgv_cliente_fisico ADD CONSTRAINT un_sgv_cli_fis_cpf UNIQUE ( cpf );
ALTER TABLE t_sgv_cliente_fisico ADD CONSTRAINT un_sgv_cli_fis_rg UNIQUE ( cpf, rg );

ALTER TABLE t_sgv_cliente_juridico ADD CONSTRAINT pk_t_sgv_cliente_juridico PRIMARY KEY ( cd_cliente );
ALTER TABLE t_sgv_cliente_juridico ADD CONSTRAINT un_sgv_cli_jurid_cnpj UNIQUE ( cnpj );
ALTER TABLE t_sgv_cliente_juridico ADD CONSTRAINT un_sgv_cli_jurid_ie UNIQUE ( insc_estadual );

ALTER TABLE t_sgv_funcionario ADD CONSTRAINT pk_t_sgv_funcionario PRIMARY KEY ( cd_funcionario );
ALTER TABLE t_sgv_funcionario ADD CONSTRAINT un_sgv_func_cpf UNIQUE ( cpf );

ALTER TABLE t_sgv_item_pedido ADD CONSTRAINT pk_t_sgv_item_pedido PRIMARY KEY ( cd_pedido, cd_item );

ALTER TABLE t_sgv_pedido ADD CONSTRAINT pk_t_sgv_pedido PRIMARY KEY ( cd_pedido );

ALTER TABLE t_sgv_produto
    ADD CONSTRAINT ck_sgv_prod_st CHECK ( st_produto IN ('A', 'I', 'P') );
ALTER TABLE t_sgv_produto ADD CONSTRAINT pk_t_sgv_produto PRIMARY KEY ( cd_produto );
ALTER TABLE t_sgv_produto ADD CONSTRAINT un_sgv_prod_dsprod UNIQUE ( ds_produto );

ALTER TABLE t_sgv_video_produto
    ADD CONSTRAINT ck_sgv_vid_produto_st CHECK ( st_video IN ('A', 'I', 'P') );
ALTER TABLE t_sgv_video_produto ADD CONSTRAINT pk_t_sgv_video_produto PRIMARY KEY ( cd_video );

ALTER TABLE t_sgv_visu_video ADD CONSTRAINT pk_t_sgv_visu_video PRIMARY KEY ( cd_visualizacao, cd_video );
```
Criando as sequências:
```sql
CREATE SEQUENCE sq_sgv_cat_produto
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999999999
	NOCACHE
	NOCYCLE;

CREATE SEQUENCE sq_sgv_chamado
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999999999
	NOCACHE
	NOCYCLE;

CREATE SEQUENCE sq_sgv_produto
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999999999
	NOCACHE
	NOCYCLE;
```
Adicionando comentarios para melhor entendimento das colunas:
```sql
COMMENT ON COLUMN t_sgv_cat_produto.st_categoria IS
    'Uma categoria possui status de “A” (ativo) e “I” (inativo) e somente as categorias ativas são exibidas na plataforma para serem visualizadas.';

COMMENT ON COLUMN t_sgv_chamado.st_chamado IS
    '“A” (aberto), “E” (em atendimento), “C” (cancelado), “F” (fechado com sucesso), “X” (fechado com insatisfação do cliente).';
COMMENT ON COLUMN t_sgv_chamado.indice_satisf IS
    '1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito.';

COMMENT ON COLUMN t_sgv_cliente.endereco_cliente IS
    'Endereço do cliente no seguinte formato: Tipo de logradouro  Nome do logradouro, numero da residência ou estabelecimento, bairro, cidade - estado.';

COMMENT ON COLUMN t_sgv_cliente.qt_estrelas IS
    'Número de estrelas que o cliente atribuiu a plataforma, variando de 1 a 5, onde 1 é a menor nota e 5 a maior.';

COMMENT ON COLUMN t_sgv_produto.st_produto IS
    'Uma categoria possui status de “A” (ativo), “I” (inativo) e “P” (produto em promoção) e somente os produtos ativos e em promoção são exibidos na plataforma para serem visualizados.';

COMMENT ON COLUMN t_sgv_video_produto.st_video IS
    'Um vídeo possui status de “A” (ativo), “I” (inativo) e “P” (em promoção) e somente os vídeos ativos são exibidos na plataforma para serem visualizados.';
```
Criação dos gatilhos:
```sql
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
```
Criação das restrições:
```sql
ALTER TABLE t_sgv_cat_chamado ADD CONSTRAINT pk_t_sgv_cat_chamado PRIMARY KEY ( cd_categoria_cham );

ALTER TABLE t_sgv_cat_produto
    ADD CONSTRAINT ck_sgv_cat_prod_st CHECK ( st_categoria = 'A' OR st_categoria = 'I' );
ALTER TABLE t_sgv_cat_produto ADD CONSTRAINT pk_t_sgv_cat_produto PRIMARY KEY ( cd_categoria );
ALTER TABLE t_sgv_cat_produto ADD CONSTRAINT un_sgv_cat_prod_dscat UNIQUE ( ds_categoria );

ALTER TABLE t_sgv_cat_video ADD CONSTRAINT pk_t_sgv_cat_video PRIMARY KEY ( cd_categoria_vid );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT ck_sgv_cham_st CHECK ( st_chamado IN ('A', 'E', 'C', 'F', 'X') );
ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT ck_sgv_cham_is CHECK (indice_satisf > 0 AND indice_satisf < 11);
ALTER TABLE t_sgv_chamado ADD CONSTRAINT pk_t_sgv_chamado PRIMARY KEY ( cd_chamado );

ALTER TABLE t_sgv_cliente ADD CONSTRAINT pk_t_sgv_cliente PRIMARY KEY ( cd_cliente );

ALTER TABLE t_sgv_cliente_fisico ADD CONSTRAINT pk_t_sgv_cliente_fisico PRIMARY KEY ( cd_cliente );
ALTER TABLE t_sgv_cliente_fisico ADD CONSTRAINT un_sgv_cli_fis_cpf UNIQUE ( cpf );
ALTER TABLE t_sgv_cliente_fisico ADD CONSTRAINT un_sgv_cli_fis_rg UNIQUE ( cpf, rg );

ALTER TABLE t_sgv_cliente_juridico ADD CONSTRAINT pk_t_sgv_cliente_juridico PRIMARY KEY ( cd_cliente );
ALTER TABLE t_sgv_cliente_juridico ADD CONSTRAINT un_sgv_cli_jurid_cnpj UNIQUE ( cnpj );
ALTER TABLE t_sgv_cliente_juridico ADD CONSTRAINT un_sgv_cli_jurid_ie UNIQUE ( insc_estadual );

ALTER TABLE t_sgv_funcionario ADD CONSTRAINT pk_t_sgv_funcionario PRIMARY KEY ( cd_funcionario );
ALTER TABLE t_sgv_funcionario ADD CONSTRAINT un_sgv_func_cpf UNIQUE ( cpf );

ALTER TABLE t_sgv_item_pedido ADD CONSTRAINT pk_t_sgv_item_pedido PRIMARY KEY ( cd_pedido, cd_item );

ALTER TABLE t_sgv_pedido ADD CONSTRAINT pk_t_sgv_pedido PRIMARY KEY ( cd_pedido );

ALTER TABLE t_sgv_produto
    ADD CONSTRAINT ck_sgv_prod_st CHECK ( st_produto IN ('A', 'I', 'P') );
ALTER TABLE t_sgv_produto ADD CONSTRAINT pk_t_sgv_produto PRIMARY KEY ( cd_produto );
ALTER TABLE t_sgv_produto ADD CONSTRAINT un_sgv_prod_dsprod UNIQUE ( ds_produto );

ALTER TABLE t_sgv_video_produto
    ADD CONSTRAINT ck_sgv_vid_produto_st CHECK ( st_video IN ('A', 'I', 'P') );
ALTER TABLE t_sgv_video_produto ADD CONSTRAINT pk_t_sgv_video_produto PRIMARY KEY ( cd_video );

ALTER TABLE t_sgv_visu_video ADD CONSTRAINT pk_t_sgv_visu_video PRIMARY KEY ( cd_visualizacao, cd_video );
```

### 📕 Criação de um documento Word para evidenciar a implantação.

Você pode conferir a documentação da implementação no arquivo a seguir: [Arquivo de implementação](./Arquivo%205_evidencia_implantacao_bd.docx) 

## Conclusão
- O desenvolvimento de um projeto de modelagem de dados destaca a importância de uma estrutura de dados bem definida para otimizar a análise e a tomada de decisões dentro da organização. Através da implementação de um modelo relacional, conseguimos identificar e organizar as principais entidades e suas relações, garantindo a integridade e a eficiência no acesso às informações. Os resultados obtidos não apenas melhoraram a performance das consultas, mas também facilitaram a visualização e armazenamento dos dados, proporcionando uma base sólida para futuras expansões e análises mais profundas, alinhadas aos objetivos estratégicos da empresa.

