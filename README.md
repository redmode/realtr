# README

### Test UI:
`http://ec2-52-40-254-226.us-west-2.compute.amazonaws.com/ocpu/test/`


### Sample calls:

```
curl -X POST http://ec2-52-40-254-226.us-west-2.compute.amazonaws.com/ocpu/library/realtr/R/predict_price/json
```

```
curl -H 'Content-Type: application/json' -X POST -d '{"square":80, "square_useful":60}' http://ec2-52-40-254-226.us-west-2.compute.amazonaws.com/ocpu/library/realtr/R/predict_price/json
```

```
curl -H 'Content-Type: application/json' -X POST -d '{"square":80, "square_useful":60, "district":"Центральный р-н"}' http://ec2-52-40-254-226.us-west-2.compute.amazonaws.com/ocpu/library/realtr/R/predict_price/json
```

### Default parameters

```
predict_price <- function(city = "Минск",
                          district = "Заводской р-н",
                          rooms = 2,
                          floor = 3,
                          total_floors = 8,
                          square = 45,
                          square_useful = 28,
                          kitchen = 6.5,
                          type = "панельный") {
...                          
}
```

### Possible values for character fields

```
$city
[1] "Минск"

$district
[1] "Заводской р-н"    "Ленинский р-н"    "Московский р-н"   "Октябрьский р-н"  "Партизанский р-н" "Первомайский р-н"
[7] "Советский р-н"    "Фрунзенский р-н"  "Центральный р-н" 

$type
[1] "каркасно-блочный" "кирпичный"        "монолитный"       "панельный" 
```
