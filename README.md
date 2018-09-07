# mobius-runtime

## How to run

1. Edit config.sh
```
MYSQL_ROOT_PASSWORD=mobiustest
MYSQL_DB_HOST_PATH=$PWD/db/
```
2. Start mysql
```
./mysql.sh start
```
3. Install database
```
./mobius.sh install
```
4. Start Mobius
```
./mobius.sh start
```

