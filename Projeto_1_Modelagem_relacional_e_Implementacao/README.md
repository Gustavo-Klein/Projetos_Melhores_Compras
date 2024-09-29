# Modelagem e implementação de um banco de dados relacional
## Contextualização
- A empresa Melhores Compras foi criada por estudantes que transformaram um projeto acadêmico de sucesso em um empreendimento promissor no ramo de e-commerce. Com a missão de melhorar o bem-estar das pessoas, a empresa oferece informações relevantes sobre produtos, feedback de consumidores, e as melhores oportunidades de compra. Inicialmente, suas vendas eram por indicação, mas rapidamente cresceram devido à qualidade dos produtos e à eficiência do serviço, alcançando mais de 1.000 pedidos diários em seu primeiro ano. A empresa investiu na experiência do usuário e no atendimento ao cliente, o que atraiu grandes investidores.
## Desafio
- O principal desafio é modernizar e agilizar a organização, substituindo processos manuais e planilhas eletrônicas por soluções de TI robustas. O foco inicial é a criação de uma funcionalidade na plataforma de e-commerce que permita a exibição de vídeos explicativos sobre os produtos. O primeiro passo será criar o modelo de dados relacional baseado em [23 regras de negócio](./Regras_de_Negocio.txt), [1 Regra de negócio](./Arquivo%201_regranegocio.txt) definida pelo aluno que irá suportar o armazenamento dos dados dessa nova funcionalidade (visualização dos vídeos dos produtos) e realizar a implementação do SCRIPT de criação do projeto. 
## Ferramentas utilizadas
- 	🔨 Oracle SQL Data Modeler
- 	🔨 Oracle SQL Developer
## Passos para solução
### 📕 Criação de uma nova [Regra de negócio](./Arquivo%201_regranegocio.txt):
Durante a reunião com o time de negócios foram definidas 23 regras para o desenvolvimento do modelo relacional.

| Número | Descrição da Regra de Negócio (RN) |
|--------|------------------------------------|
| RN01   | Um produto pode ter nenhum ou vários vídeos associados e cada vídeo somente pode ser exibido caso seu status esteja em “A” (ativo). O status do vídeo pode receber apenas os seguintes conteúdos: A(tivo) ou I(nativo). Para essa coluna status do produto, crie uma restrição do tipo check constraint, permitindo apenas o conteúdo A ou I. |
| RN02   | O código de identificação do produto deve ser um número sequencial para ser utilizado como SEQUENCE ou IDENTITY e crescente, de acordo com novos produtos que forem sendo cadastrados. |


📊 Desenvolvimento do [Projeto Lógico](./Arquivo%202_proj_logico_bd.pdf);

💻 Implementação do [Projeto Físico](./Arquivo%203_proj_fisico_bd.pdf);

🔍 [Scripts DDL](./Arquivo%204_script_bd.SQL) para criação de tabelas e estruturas, assim como comandos para exclusão das estruturas.

📕 Criação de um [Arquivo](./Arquivo%205_evidencia_implantacao_bd.docx) para evidenciar a implantação.



