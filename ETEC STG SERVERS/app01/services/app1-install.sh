# create network
docker network create -d bridge orchestra_default --attachable

if [ -d "requestmanagement" ]; then
  docker-compose -f requestmanagement/requestmanagement.yml up -d
else
  echo "requestmanagement directory not found"
fi

if [ -d "referencedata" ]; then
  docker-compose -f referencedata/referencedata.yml up -d
else
  echo "referencedata directory not found"
fi


if [ -d "notification" ]; then
  docker-compose -f notification/notification.yml up -d
  sleep 20
  docker cp notification/cmis.yml notification:/app/resources/
else
  echo "notification directory not found"
fi
