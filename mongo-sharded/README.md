# MongoDB

## URL

```
mongodb://homestead:homestead@localhost:27017/public?readPreference=primary&replicaSet=default&authSource=admin&directConnection=true
```

실행하기

```shell
docker-compose \
  -f docker-compose.yml \
  -f docker-compose.config.yml \
  -f docker-compose.shard.yml \
  -f docker-compose.mongos.yml \
  up -d mongos
```
