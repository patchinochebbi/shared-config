# create network
docker network create -d bridge orchestra_default --attachable

if [ -d "registry" ]; then
  docker-compose -f registry/jhipster-registry.yml up -d
  sleep 10
else
  echo "registry directory not found"
fi

if [ -d "caseservice" ]; then
  docker-compose -f caseservice/caseservice.yml up -d
  sleep 10
  docker cp keycloak.json case-service:/app/resources/
else
  echo "caseservice directory not found"
fi


if [ -d "dataservice" ]; then
  docker-compose -f dataservice/dataservice.yml up -d
  sleep 20
  docker cp cmis.yml dataservice:/app/resources/
else
  echo "dataservice directory not found"
fi


if [ -d "gateway" ]; then
  docker-compose -f gateway/gateway.yml up -d
else
  echo "gateway directory not found"
fi

if [ -d "orchestra" ]; then
  docker-compose -f orchestra/orchestra.yml up -d
else
  echo "orchestra directory not found"
fi

if [ -d "workflow" ]; then
  docker-compose -f workflow/workflow.yml up -d
  sleep 10
  docker cp cmis.yml workflow-service:/app/resources/
  docker cp keycloak.json workflow-service:/app/resources/
else
  echo "workflow directory not found"
fi
