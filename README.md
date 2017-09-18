# Ambiente para desenvolvimento de processos e regras de negócios

Esse ambiente possui um container rodando:

* Jbpm-console http://localhost:8080/jbpm-console
* Kie-server http://localhost:8080/kie-server
* Dashboard http://localhost:8080/dashboard

![esquema disposição containers](esquema.png)


### Pré-requisitos
* Acesso ao código fonte de projeto sin-bpm.
* [docker](https://docs.docker.com/engine/installation/) - Ferramenta para rodar containers. (>=17.06)
* [docker-compose](https://docs.docker.com/compose/install/) - Ferramenta para rodar aplicações multi-container (>= 1.14.0)
* [git](https://git-scm.com/downloads) - Gerenciador de versões (>= 2.13.2)
* [git-flow](https://github.com/nvie/gitflow/wiki/Installation) - Ferramenta para auxiliar a criação de branches de desenvolvimento (=> 0.4.1). 


### Para rodar ambiente com código fonte (opção 1)
Configure os argumentos SRC_GIT_REPO e SRC_GIT_BRANCH no arquivo docker-compose.yml e reconstrua a imagem ancine/sim-dev-bpm, comente a linha que mapeia o volume da pasta ./src. O repositório do business-central já será inicializado com o código do projeto.
``` 
docker-compose.yml
...
  bpm:
    build: 
      context: ./sim-dev-bpm
      args: 
        - SRC_GIT_REPO=http://usuárioXYZ:senhaXYZ@gitlab.ancine.gov.br/ancine/sin-bpm.git
        - SRC_GIT_BRANCH=feature/regra-planilha-hierarquia-solicitacoes
...
      volumes:
        #- /src:/opt/jboss/src
...
```

```
$ docker-compose up --build
```
    

### Para rodar ambiente com código fonte (opção 2)
Clone o repositório sin-bpm na pasta ./src e configure o mapeamento de volumes dessa pasta no arquivo docker-compose.yml. Durante execução do container será adicionado um git remote bc-host apontando para o repositório interno do business-central e que poderá ser utilizado para .
```
docker-compose.yml
...
    volumes:
      - ./src:/opt/jboss/src
...
``` 

```
Exemplo clone repositório
$ mkdir -p src
$ cd src
$ git clone http:/gitlab.ancine.gov.br/ancine/sin-bpm.git -b feature/regra-hierarquia-solicitacoes
$ cd ..
$ docker-composer up
``` 

### Para rodar ambiente sem nenhum código

```
$ docker-compose up
```

### Para copiar conteúdo do business-central e enviar para repositório do projeto

O repositório interno do business-central pode ser acessado utilizando o git remote bc-host criado na pasta ./src/sin-bpm.

De forma alternativa o código pode ser baixado no business-central. Vá em Authoring -> Project Explorer -> ícone engrenagem -> Download repository para baixar repositório interno do business-central. Cópie o arquivos que foram alterados/adicionados para o repositório no host e submeta código utilizando git flow.

Para informações sobre o esquema de submissão de código do business-central para o repositório central, ler [artigo](http://www.opensourcerers.org/demystifying-business-central-repository/). 


