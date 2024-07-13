# Elastic Stack

## 실행

```shell
docker compose \
  -f ./docker-compose.yml \
  down --rmi all -v

docker compose \
  -f ./docker-compose.yml \
  up -d --build
```
