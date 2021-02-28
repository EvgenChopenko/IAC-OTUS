# IAC-OTUS
## LESSON-1 
```



```
### /LESSON-2

## LESSON-2
```
 Развернуть при помощи Terraform тестовую среду, включающую в себя хосты для front-end, back-end и базы данных.
 Цель: Развернуть при помощи Terraform тестовую среду, включающую в себя хосты для front-end, back-end и базы данных.
  Для разворачивания используться облоко YACLOUD. 
```
### /LESSON-2
##### RESOURCE
    <https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html>
  
Необходимо добавить файл provider.tf 
```

provider "yandex" {
   token     = "your token"
   cloud_id  = "your token cloud id"
   folder_id = "your folder id "
  zone      = "ru-central1-a"
}

```


