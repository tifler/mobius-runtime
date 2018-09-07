# mobius-runtime

## How to run

1. Edit config.sh
```
MYSQL_ROOT_PASSWORD=mobiustest
MYSQL_DB_HOST_PATH=$PWD/db/
```
1. Start mysql
```
./mysql.sh start
```
1. Install database
```
./mobius.sh install
```
1. Start Mobius
```
./mobius.sh start
```

