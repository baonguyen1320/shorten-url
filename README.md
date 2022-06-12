# README
This project help to shorten URL. It allows we are create account and manage them. Beside that support for API integration.

# Live Demo

[https://shorten-url-demo.herokuapp.com](https://shorten-url-demo.herokuapp.com)


# Installation
#### Ruby version: ruby 3.1

#### Rails version: 7.0

#### Database: Postgresql

# Run Unit test
```
rspec
```

# API Guideline

### Let prepare HOST and API_KEY firstly
```
$HOST    = 'YOUR_HOST'
$API_KEY = 'USER_API_KEY'
```

* Example
```
$HOST    = 'shorten-url-demo.herokuapp.com'
$API_KEY = '07e5e2a495ef923c1312fb0803a09f59'
```

### Get all links
``` 
curl -XGET "$HOST/api/v1/links" \
     --header "Authorization: Token $API_KEY"
```
* Example
```
curl -XGET "shorten-url-demo.herokuapp.com/api/v1/links" \
     --header "Authorization: Token 07e5e2a495ef923c1312fb0803a09f59"
```


### Get all links filter by page params
``` 
curl -XGET "$HOST/api/v1/links?page=[page]" \
     --header "Authorization: Token $API_KEY"
```

* Example
```
curl -XGET "shorten-url-demo.herokuapp.com/api/v1/links?page=2" \
     --header "Authorization: Token 07e5e2a495ef923c1312fb0803a09f59"
```

### Create new link
``` 
curl  -XPOST “$HOST/api/v1/links" \
      --header "Authorization: Token $API_TOKEN" \
      --header 'Content-Type: application/json' \
      --data-raw '{
          "link": {
            "url": "https://www.youtube.com/watch?v=HZi4eJXWZU0"
          }
      }' 
```

* Example
```
curl  -XPOST "shorten-url-demo.herokuapp.com/api/v1/links" \
      --header "Authorization: Token 07e5e2a495ef923c1312fb0803a09f59" \
      --header 'Content-Type: application/json' \
      --data-raw '{
          "link": {
            "url": "https://www.youtube.com/watch?v=HZi4eJXWZU0"
          }
      }'
```
### Update link
``` 
curl  -XPUT "$HOST/api/v1/links/:id" \
      --header "Authorization: Token $API_TOKEN" \
      --header 'Content-Type: application/json' \
      --data-raw '{
          "link": {
            "shorten_code": "abcd1234",
            "url": "https://www.youtube.com/watch?v=HZi4eJXWZU0"
          }
      }'
```

* Example
```
curl  -XPUT "shorten-url-demo.herokuapp.com/api/v1/links/2" \
      --header "Authorization: Token 07e5e2a495ef923c1312fb0803a09f59" \
      --header 'Content-Type: application/json' \
      --data-raw '{
          "link": {
            "shorten_code": "abcd1234",
            "url": "https://www.youtube.com/watch?v=HZi4eJXWZU0"
          }
      }'
```
### Delete link
``` 
curl  -XDELETE "$HOST/api/v1/links/:id" \
      --header "Authorization: Token $API_TOKEN"
```

* Example
```
curl  -XDELETE "shorten-url-demo.herokuapp.com/api/v1/links/2" \
      --header "Authorization: Token 07e5e2a495ef923c1312fb0803a09f59"
```
