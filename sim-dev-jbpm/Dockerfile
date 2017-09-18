FROM ancine/jbpm

ARG SRC_GIT_REPO=http://gitlab.ancine.gov.br/ancine/sin-bpm.git
ARG SRC_GIT_BRANCH=develop

ENV SRC_DIR=/opt/jboss/src
ENV DATA_DIR /opt/jboss/data

USER jboss
RUN mkdir -p $SRC_DIR $DATA_DIR

COPY support/start.sh /opt/jboss/
COPY support/standalone-full-jbpm.xml $JBOSS_HOME/standalone/configuration/
COPY support/repositorio-local-niogit /opt/jboss/repositorio-local-niogit

USER root
RUN yum install -y git \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && curl -sSL http://archive.apache.org/dist/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz | tar xzf - -C /usr/share \
    && mv /usr/share/apache-maven-3.2.5 /usr/share/maven \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
    && mkdir /opt/jboss/.m2 \
    && chown -R jboss:jboss $JBOSS_HOME/standalone/configuration/standalone-full-jbpm.xml \
    /opt/jboss/.m2 \
    /opt/jboss/repositorio-local-niogit \
    /opt/jboss/start.sh \
    $DATA_DIR \
    && chmod +x /opt/jboss/start.sh
USER jboss

RUN $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u admin -p ancine1! -ro analyst,admin,user,manager,kiemgmt,kie-server,rest-all,SIM_PROPONENTE,SIM_COORD_TRIAGEM,SIM_COORD_ANALISE_DIREITOS,SIM_COORD_ANALISE_TECNICA,SIM_SUP_FOMENTO --silent \
    && $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u kiecontrolleruser -p kiecontrolleruser1! -ro kie-server,rest-all --silent \
    && $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u proponente.user.1 -p ancine1! -ro SIM_PROPONENTE,user --silent \
    && $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u proponente.user.2 -p ancine1! -ro SIM_PROPONENTE,user --silent \
    && $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u coord.triagem.1 -p ancine1! -ro SIM_COORD_TRIAGEM,user,manager --silent \
    && $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u coord.triagem.2 -p ancine1! -ro SIM_COORD_TRIAGEM,user,manager --silent \
    && $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u coord.analise.direitos.1 -p ancine1! -ro SIM_COORD_ANALISE_DIREITOS,user,manager --silent \
    && $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u coord.analise.direitos.2 -p ancine1! -ro SIM_COORD_ANALISE_DIREITOS,user,manager --silent \
    && $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u coord.analise.tecnica.1 -p ancine1! -ro SIM_COORD_ANALISE_TECNICA,user,manager --silent \
    && $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u coord.analise.tecnica.2 -p ancine1! -ro SIM_COORD_ANALISE_TECNICA,user,manager --silent \
    && $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u sup.fomento -p ancine1! -ro SIM_SUP_FOMENTO,user,manager --silent

RUN git clone $SRC_GIT_REPO --single-branch -b $SRC_GIT_BRANCH $SRC_DIR/sin-bpm ; exit 0

VOLUME $DATA_DIR
VOLUME /opt/jboss/.m2

CMD ["/opt/jboss/start.sh"]
