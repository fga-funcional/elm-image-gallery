# Relatório

**Alunos:** Ícaro Pires de Souza Aragão (15/0129815) e Vinicius Ferreira Bernardo de Lima (15/0151331)

Backend: [backend](https://github.com/fga-funcional/haskell-image-gallery)

## Desenvolvimento técnico

### Mecanismo de persistência
Foi utilizado o banco de dados Postgres, integrado através da biblioteca [postgresql-simple](https://hackage.haskell.org/package/postgresql-simple) . Dessa biblioteca também foi utilizado o recurso de migrations para que a tabela no banco fosse criada automaticamente.

### Recursos avançados das linguagens
Se se encaixar na categoria, no haskell foram utilizadas várias mônadas para lidar com o IO e blocos utilizando `do`.

### Rotas, tasks e subscribers
Não foram utilizados rotas e tasks porque não achamos necessário para a natureza da aplicação. Já os subscribers foram usados para lidar com os atalhos de teclado e com as ações de clique e arraste.

### Union Types
Basicamente só a mensagem do update no elm. Poderiam ter sido utilizados em outros lugares, provavelmente para definir melhor o estado em que a visualização se encontra (tela cheia ou não, tamanho real ou não, imagem apliada ou não, etc)

### Instanciação de classe em Haskell
Foram definidos os tipos Imagem e ModelConfig (referente ao arquivo de configuração) que derivam de Show e Generic e foram instanciadas as classes ToJSON e FromJSON para o tipo Image.

## Qualidade do Produto

## Implementa recursos básicos esperados além da aparência?
Sim. No front-end o usuário consegue visualizar a lista de imagens, visualizar a imagem em tela cheia, zoom in, zoom out, arrastar, visualizar em tamanho real ou ajustada e navegar entre as imagens em tela cheia. No back-end a API funciona da forma esperada para as ações básicas (listar, criar, atualizar, obter e apagar imagens).

## Interações de forma eficiente
O usuário pode navegar na aplicação através ícones específicos de fácil visualização e também através de vários atalhos de teclado. Na verdade, o usuário consegue realizar todas as ações da aplicação que conseguiri com o mouse através do teclado (menos arrastar a imagem).

## Conseguiu polir a aplicação?
Sim, foi tomado o cuidado de adicionar transições on hover, evitar cores que se misturassem com a imagem muito frequentemente, adicionar divs com cores diferentes atrás dos ícones, não permitir arrastar a imagem quando ela estiver em tamanho real ou menor, o zoom in e out possuem limites, não permitir troca de imagem quando não em tela cheia, dentre outros detalhes.

## Pronto para produção?
Quase. O back-end está integrado com o docker mas eu não o colocaria em produção sem autenticação nas rotas e sem definir melhor algumas questões de timeout em requisições e outros mecanismos de proteção. Já o front-end não está integrado com nenhum servidor, mas com relação ao código fonte, ele já poderia ser utilizado normalmente, alterando apenas a rota da qual ela obteria as imagens.

## Integração front + back 
### Front usa backend como mecanismo de persistência?
Sim, mas como a intenção da galeria era apenas de visualização, no frontend só foram implementadas funcionalidades que utilizam o método HTTP GET. As imagens são cadastradas na API através de outros mecanismos.

### Conseguiu conectar os dois sistemas adequadamente?
Sim, as rotas são expostas pelo backend de forma que o front-end só precisa realizar requisições HTTP. Porém não foram implementadas autenticações e nem soluções de produção relativas ao CORS, por exemplo.

### Consegue rodar mais de uma instâcia (discriminada por URL, por exemplo)
Sim, uma vez que o backend está dockerizado, para adicionar instâncias, necessário apenas subir outra instância com host ou porta diferente. Já o front-end não está integrado a um servidor, mas no código fonte também não há nenhum impedimento nesse sentido.

## Método
### Possui sistema de build?
Sim, no repositório do frontend existe o script [compile.sh](https://github.com/fga-funcional/elm-image-gallery/blob/master/compile.sh) que compila o SASS para CSS e o Elm para JS, que já estão adicionados num arquivo em HTML (mais detalhes no README). Já o backend está dockerizado, então seria só subir o docker-compose.

### Testes unitários e boas práticas?
Não foram implementados testes, até porque os compiladores já dão garantias consideráveis. Apesar disso, outras boas práticas foram adotadas, como a separação do código fonte em arquivos separados, a adoção de bons nomes para funções, funções atômicas e a tentativa de escrever código idiomático.

### Implantou em algum lugar?
Não.
