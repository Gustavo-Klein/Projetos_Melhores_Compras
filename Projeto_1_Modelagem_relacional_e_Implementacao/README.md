# Modelagem e implementação de um banco de dados relacional
## Contextualização
- A empresa Melhores Compras foi criada por estudantes que transformaram um projeto acadêmico de sucesso em um empreendimento promissor no ramo de e-commerce. Com a missão de melhorar o bem-estar das pessoas, a empresa oferece informações relevantes sobre produtos, feedback de consumidores, e as melhores oportunidades de compra. Inicialmente, suas vendas eram por indicação, mas rapidamente cresceram devido à qualidade dos produtos e à eficiência do serviço, alcançando mais de 1.000 pedidos diários em seu primeiro ano. A empresa investiu na experiência do usuário e no atendimento ao cliente, o que atraiu grandes investidores.
## Desafio
- O principal desafio é modernizar e agilizar a organização, substituindo processos manuais e planilhas eletrônicas por soluções de TI robustas. O foco inicial é a criação de uma funcionalidade na plataforma de e-commerce que permita a exibição de vídeos explicativos sobre os produtos. O primeiro passo será criar o modelo de dados relacional baseado em [23 regras de negócio](./Regras_de_Negocio.txt), [1 Regra de negócio](./Arquivo%201_regranegocio.txt) definida pelo aluno que irá suportar o armazenamento dos dados dessa nova funcionalidade (visualização dos vídeos dos produtos) e realizar a implementação do SCRIPT de criação do projeto. 
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

Após analisar cuidadosamente as regras de negócio, foi desenvolvido o modelo lógico abaixo que consiste em refinar o modelo conceitual ao detalhar tabelas (entidades), atributos (colunas) com seus respectivos tipos de dados, chaves primárias (PK) para garantir a unicidade dos registros, e chaves estrangeiras (FK) para estabelecer relacionamentos entre tabelas. Além disso, o modelo lógico define regras de integridade, como integridade referencial, que assegura a consistência dos dados, e restrições como a de unicidade, para evitar a duplicidade de informações. Também são aplicadas regras de normalização para eliminar redundâncias e melhorar a eficiência. Esse modelo é crucial para garantir a implementação correta das regras de negócio e preparar o sistema para a fase de desenvolvimento físico, onde o banco de dados será implementado em um SGBD específico.



💻 Implementação do [Projeto Físico](./Arquivo%203_proj_fisico_bd.pdf);

🔍 [Scripts DDL](./Arquivo%204_script_bd.SQL) para criação de tabelas e estruturas, assim como comandos para exclusão das estruturas.

📕 Criação de um [Arquivo](./Arquivo%205_evidencia_implantacao_bd.docx) para evidenciar a implantação.



