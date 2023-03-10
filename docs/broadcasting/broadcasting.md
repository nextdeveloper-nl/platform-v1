# Broadcasting

In our standart of broadcasting is storing the last N event that happened until the last request as json object in redis.
The key of redis will be "bcast:{client}{account_id}". Which can be converted to such;

- bcast:{appname}{account_id}
- bcast:wp123456
- bcast:api123456
- bcast:app123456

## Requesting the broadcasts


## Lifespan of broadcasts
All broadcast messages are stored in redis with EXPIRE directive. Which will be 10 mins. After that the broadcast message
will be deleted automatically.

Also we add timestamp as afield in ZADD command so that the client can use the most relevant broadcast message they want.

To get the broadcast messages, the request will be done with the accesstoken and account_id. This account_id is actually
a temporary ID which will be changed every 15 mins for security reasons. Since in redis we store with temporary_account_ids
we need to move all broadcast messages from old id to new id and return back the broadcast messages.

For increased security we need to change the client codes every N minutes, which is stated in the configuration file.
In each N minutes the client code will be changed and the calculation for client code is;
```php
$account    = redis_get("access_token");

$isTrue = (
           $clientCode == 
           md5(
                $account->id
                 . 'private-key'
                 . (now() - (now() % ($timeout*60)))    //  This will give us the same number in each timeout windows. 
              )
          );

return [
    'data'  =>  redis_get('bcast:wp1');
    'clientCode'    =>  $clientCode
]
```

If we want to prevent man in the middle attacks we need to create new clientCode for each request. The problem with this
feature is that if there are two clients which is connected to the same broadcast, they may steal their session and only one
will get the latest broadcast message.

Also in average use of an API or broadcast messages, we think like 15 mins. After 15 mins we think that the latest broadcast 
message is not needed anymore. That is why we are putting an expiration time in broadcast messages. You can set if you
want to enable or disable ExpireAt functionality from the config file.

So it will be something like;
```
Sample:

ZADD bcast:wp1 {timestamp} {data}
EXPIREAT bcast:wp1 {timestamp}  //  We are using this because we only want to store X minutes of data.

Example:
ZADD bcast:wp123456 1677257981 {data1} 
EXPIREAT bcast:wp1 1677258000
ZADD bcast:wp123456 1677257982 {data2} 
EXPIREAT bcast:wp1 1677258000
ZADD bcast:wp123456 1677257983 {data3} 
EXPIREAT bcast:wp1 1677258000
ZADD bcast:wp123456 1677257985 {data5} 
EXPIREAT bcast:wp1 1677258000
ZADD bcast:wp123456 1677257984 {data4} 
EXPIREAT bcast:wp1 1677258000
```

```
Result:
ZRANGE bcast:wp123456 0 -1 WITHSCORES

 1) "{data}"
 2) "1677257981"
 3) "{data2}"
 4) "1677257982"
 5) "{data3}"
 6) "1677257983"
 7) "{data4}"
 8) "1677257984"
 9) "{data5}"
10) "1677257985"
```

## Config Parameters;

- enable_expireat = true
- expireat_ttl = now() + '3600'
- should_generate_unique_code = false

## Sample clients
Clients can be many things; web applications, mobile application, backend applications like api. That is why sending
heartbeat for all clients will be very important. 