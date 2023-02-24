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

**BURAYA EKLENECEK**

Burada login olan her client için bir clientkey yaratılacak. Daha sonra bu clientKey'in karşısına account_id yazılacak.
Böylelikle doğrudan openresty üzerinden ilgili clientkey'e ait account'u bulup ardından o account'un broadcast mesajlarına
erişim sağlanacak. Böylelikle müşteri sadece ilgili key e erişebilecek.

Burada güvenlik amaçlı her request'te takip edilmesi gereken clientkey'i değiştirebiliriz. Böylelikle man in the middle 
saldırısının da önüne geçmiş oluruz.
```
//Burada 1 saat sonra expire olacak bir anahtar yaratıyoruz;
SET key{key} {account_id} EX 3600
```
**BURAYA EKLENECEK**:

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

## Sample clients
Clients can be many things; web applications, mobile application, backend applications like api. That is why sending
heartbeat for all clients will be very important. 