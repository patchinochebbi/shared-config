# create network
docker network create -d bridge orchestra_default --attachable

if [ -d "cms" ]; then
  docker-compose -f cms/cockpit.yml up -d
  sleep 10 #Wait 10 seconds until CMS is up to initiate the installation
  curl -IL -X GET 'http://localhost:8083/install'
  docker cp cms/cockpit/BackupAndRestore orchestracockpit:/var/www/html/addons
  docker cp cms/cockpit/CMSPlugin orchestracockpit:/var/www/html/addons
  docker cp cms/cockpit/Logger orchestracockpit:/var/www/html/addons
  docker exec orchestracockpit sh -c 'rm -rf /var/www/html/config/config.php'
  docker cp cms/cockpit/config orchestracockpit:/var/www/html

  #docker cp CloudStorage orchestracockpit:/var/www/html/addons
else
  echo "CMS directory not found"
fi