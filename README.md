# rypto-web

A simple Sinatra application to expose the
[rypto](https://github.com/sortelli/rypto) API as a webservice.

## API

```
GET /solve/(postfix|infix)/:card1/:card2/:card3/:card4/:card5/:target.(json|txt)
```

Return the postfix or infix solution to a hand of Krypto in either
json or plain text format.
