#!/usr/bin/env bash
set -eu

function dev() {
  WWW_DATA_UID=33
  RESULT=$(docker compose exec -u www-data wordpress id -u)
  COMMAND_SUCCESS=$?
  if [ $COMMAND_SUCCESS -eq 0 ]; then
    WWW_DATA_UID=$(echo $RESULT | tr -d '\r')
  fi
  echo "====initialized to wp-content================="
  sudo chown -R $WWW_DATA_UID:$USER ./wp-content
  sudo find ./wp-content -type d -exec chmod 775 {} \;
  sudo find ./wp-content -type f -exec chmod 664 {} \;
  echo "===============ending========================="
}

function prod() {
  docker compose exec -T -u root wordpress chown -R www-data:www-data /var/www/html
}

case ${1-} in
development)
  dev
  ;;
production)
  prod
  ;;
*)
  echo "changes permission file wp-content"
  ;;
esac
