docker-compose -f services.yml up -d > /dev/null
docker-compose -f apps.yml up -d > /dev/null
docker exec -it websocket bash -c "sh /var/SiteBuilderWebsocket/startProcess.sh app"
docker exec -it api bash -c "sh /var/siteBuilderAPI/startProcess.sh app"
docker exec -it processor bash -c "sh /var/SiteBuilderProcessor/startProcess.sh app"
docker exec -it preview bash -c " mv -v /var/www/siteBuilderBuilder/.git /var/www/ && sh /var/www/env.sh"
docker exec -it front sh -c "cd /usr/share/nginx/html && sh getenv.sh"