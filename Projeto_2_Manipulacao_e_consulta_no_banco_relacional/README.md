# Manipulando banco de dados relacionais com instruções SQL
## Contextualização
- Após a bem-sucedida implementação de um banco de dados relacional, é possível gravar vários vídeos para um produto e associá-lo a uma categoria. Tanto clientes logados quanto anônimos terão seus acessos aos vídeos registrados, permitindo análises sobre os produtos mais visualizados e a comparação com vendas. Além disso, os clientes podem abrir chamados pelo SAC, e agora os funcionários da Melhores Compras podem atendê-los diretamente. Agora, vamos inserir alguns dados, realizar alterações nesses dados e criar consultas para testar e validar a eficiencia do modelo.
## Desafio
- Na primeira fase do desafio, serão aplicados comandos DML (Data Manipulation Language), incluindo a instrução SELECT, para cadastrar e manipular grandes volumes de dados no projeto das Melhores Compras LTDA, visando futuras análises pelas áreas de negócio. Na segunda fase, o foco será nos comandos DQL (Data Query Language), especialmente na instrução SELECT, que permite exibir dados úteis para auxiliar os usuários na análise e tomada de decisões, alinhando a organização com práticas data driven. 
## Ferramentas utilizadas
- 	🔨 Oracle SQL Developer
## Passos para solução
### 📕 Instruções DML e SELECT:
Aplicar instruções DML e instrução SELECT no projeto das Melhores Compras LTDA, cadastrando centenas de informações importantes para posterior uso das áreas de negócio da organização. .

a) Para essa etapa de instruções DML: Popular a tabela DEPARTAMENTO:

```sql
INSERT INTO MC_DEPTO (cd_depto,nm_depto,st_depto) VALUES(SQ_MC_DEPTO.NEXTVAL,'PRESIDÊNCIA','A');
INSERT INTO MC_DEPTO (cd_depto,nm_depto,st_depto) VALUES(SQ_MC_DEPTO.NEXTVAL,'COMERCIAL','A');
INSERT INTO MC_DEPTO (cd_depto,nm_depto,st_depto) VALUES(SQ_MC_DEPTO.NEXTVAL,'CONTABLIDADE','A');
INSERT INTO MC_DEPTO (cd_depto,nm_depto,st_depto) VALUES(SQ_MC_DEPTO.NEXTVAL,'ESTOQUE','A');
INSERT INTO MC_DEPTO (cd_depto,nm_depto,st_depto) VALUES(SQ_MC_DEPTO.NEXTVAL,'FINANCEIRO','A');
INSERT INTO MC_DEPTO (cd_depto,nm_depto,st_depto) VALUES(SQ_MC_DEPTO.NEXTVAL,'SAC','A');
INSERT INTO MC_DEPTO (cd_depto,nm_depto,st_depto) VALUES(SQ_MC_DEPTO.NEXTVAL,'RECURSOS HUMANOS','A');
INSERT INTO MC_DEPTO (cd_depto,nm_depto,st_depto) VALUES(SQ_MC_DEPTO.NEXTVAL,'LOGISTICA','A');
INSERT INTO MC_DEPTO (cd_depto,nm_depto,st_depto) VALUES(SQ_MC_DEPTO.NEXTVAL,'T.I.','A');
```


b) Popular a tabela FUNCIONARIO, inserindo no mínimo 3 (três) funcionários para cada departamento criado.
```sql

```


c) Popular todos os ESTADOS do Brasil. Selecione 5 Estados a seu critério e associe no mínimo 2 cidades para cada Estado. Para cada cidade, associe no mínimo 1 bairro e para cada bairro, associe 2 endereços. Utilize nomes significativos e coerentes, de acordo com a base do Correio. Uma sugestão de link para acesso seria: https://buscacepinter.correios.com.br/app/endereco/index.php
```sql

```


d) Por fim, cadastre na tabela de ENDERECO FUNCIONARIO todos os funcionários com no mínimo 1 endereço para cada um. Escolha vários estados do Brasil, ou seja, um funcionário pode residir em mais de uma localidade, dado que a empresa Melhores Compras incentiva o trabalho em formato home office.
```sql

```

e) Cadastre no mínimo 10 CLIENTES PESSOAS FÍSICAS e 5 CLIENTES PESSOA JÚRIDICA e associe no mínimo 1 endereço para cada cliente. Utilize nomes significativos e relevantes.
```sql

```

f) Cadastre um novo cliente que já tenha um mesmo login já criado. (*Exiba a instrução SQL executada para realizar a tarefa e apresente o resultado dessa execução). Foi possível incluir esse novo cliente? Explique?
```sql

```
Não foi possível incluir esse cliente, devia a uma constraint unique no coluna login, onde só pode haver um login por cliente.

g) Cadastre as seguintes categorias para os produtos: Artesanato; Áudio; Brinquedos; Celular e Smartphone; Colchões; Esporte e Lazer; Ferramentas; Games; Informática; Livros; Pet Shop; TV e Utilidades Domésticas.
```sql

```

h) Cadastre as seguintes categorias para os vídeos: Instalação do produto; Uso no cotidiano; Comercial com personalidade; entre outros.
```sql

```

i) Cadastre 20 produtos e associe as categorias adequadas ao produto.
```sql

```

j) Cadastre 2 vídeos de produtos na tabela MC_SGV_PRODUTO_VIDEO e associe esses 2 vídeos em um único produto já cadastrado. Associe também as categorias adequadas ao vídeo.
```sql

```

k) Por fim, cadastre 5 visualizações de vídeos de produtos na tabela MC_SGV_VISUALIZACAO_VIDEO e associe a um cliente a seu critério.
```sql

```

l) Confirme todas as transações pendentes (muito importante).
```sql

```

m) Cadastre uma categoria de produto com status I(nativo).
```sql

```

n) Cadastre um produto com status I(nativo).
```sql

```

o) Selecione um específico funcionário e atualize o Cargo e aplique 12% de aumento de salário.
```sql

```

p) Atualize a descrição de uma categoria de produto a seu critério.
```sql

```

q) Atualize o nome de um departamento a sua escolha, utilizando como filtro o nome do departamento antes de ser atualizado.
```sql

```

r) Atualize a data de nascimento de um cliente pessoa física. Defina a nova data como sendo 18/05/2002.
```sql

```

s) Atualize a descrição de uma categoria de vídeo a seu critério.
```sql

```

t) Desative um funcionário colocando o status como I(nativo) e também a data de desligamento como sendo a data de hoje (sysdate).
```sql

```

u) Cadastre um atendimento SAC na tabela MC_SGV_SAC. Após isso, utilize outro comando DML para atualizar a descrição detalhada de retorno do SAC feito pelo funcionário. Insira um conteúdo significativo. Não se esqueça de atualizar também a data e hora de atendimento e também acrescendo o número total de horas do atendimento SAC.
```sql

```

v) Selecione um endereço de cliente e coloque o status como I(nativo) e preencha a data de término como sendo a data de ontem. Utilize a função to_date para registrar esse novo valor da data.
```sql

```

w) Selecione um endereço de funcionário e coloque o status como I(nativo) e preencha a data de término como sendo a data de ontem. Utilize a função to_date para registrar esse novo valor da data.
```sql

```

x) Tente eliminar um estado que tenha uma cidade Cadastrada. Isso foi possível? Justifique o motivo?
```sql

```
Não foi possível, devido ao estado em questão estar vinculado a outra tabela, através de uma chave estrangeira, no caso a tabela MC_CIDADE.

y) Selecione um produto e tente atualizar o status do produto com o status X. Isso foi possível? Justifique o motivo?
```sql

```
Não é possível, devido a check constraint na coluna, que permite apenas as letras “A” e “I” como opção de registro, para representar ativo ou inativo repectivamente.

z) Confirme todas as transações pendentes.
```sql

```
