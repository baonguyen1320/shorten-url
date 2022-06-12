# README
This project help to shorten URL. It allows we are create account and manage them. Beside that support for API integration.

# Installation
### Ruby version: ruby 3.1

### Rails version: 7.0

### Database: Postgresql



#API Guideline

### Let prepare HOST and API_KEY firstly
```
$HOST    = 'shorten-url-demo.herokuapp.com'
$API_KEY = 'USER_API_KEY'
```

### Get all links
``` 
curl -XGET "$HOST/api/v1/links" \
     --header "Authorization: Token $APU_KEY"
```

### Get all links filter by page params
``` 
curl -XGET "$HOST/api/v1/links?page=2" \
     --header "Authorization: Token $APU_KEY"
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

### Update link
``` 
curl  -XPUT "$HOST/api/v1/links/10" \
      --header "Authorization: Token $API_TOKEN" \
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
curl  -XDELETE "$HOST/api/v1/links/10" \
      --header "Authorization: Token $API_TOKEN"
```
