#!/bin/bash
BUILD_DIR=/opt/jboss/src

if [ ! -d  $DATA_DIR/.niogit ]; then
    cp -a /opt/jboss/repositorio-local-niogit $DATA_DIR/.niogit 
fi

if [ $DATA_DIR/.niogit ] && [ ! -d  $DATA_DIR/.niogit/local.git ]; then
    rm -rf $DATA_DIR/.niogit
    cp -Rf /opt/jboss/repositorio-local-niogit $DATA_DIR/.niogit/
fi

cd /opt/jboss/src/sin-bpm
git remote add bc-host ../../data/.niogit/local.git
git remote add bc-container /opt/jboss/data/.niogit/local.git
cd /opt/jboss

CLEAN_REPO_SIZE="`du -sb /opt/jboss/repositorio-local-niogit/local.git | cut -f1`"
DATA_REPO_SIZE="`du -sb /opt/jboss/data/.niogit/local.git | cut -f1`"
if [ "$DATA_REPO_SIZE" -le "$CLEAN_REPO_SIZE" ] ; then
    cd /opt/jboss/src/sin-bpm
    git push -f -u bc-container `git rev-parse --abbrev-ref HEAD`:master 
    cd /opt/jboss/
fi

mvn install -DskipTests -f $BUILD_DIR/sin-bpm/pom.xml

$JBOSS_HOME/bin/standalone.sh -b 0.0.0.0 -c standalone-full-jbpm.xml  -bmanagement 0.0.0.0
