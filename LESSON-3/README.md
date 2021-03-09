## Lesson-3 
```
Написать тесты для тестирования кода Terraform из ДЗ1


 Для разворачивания используться облоко YACLOUD. 


```
# NOTE 

В качестве сервиса выбран elk одномодовый кластер. 

Необходимо добавить файл provider.tf 
```
    provider "yandex" {
    token     = "your token"
    cloud_id  = "your token cloud id"
    folder_id = "your folder id "
    zone      = "ru-central1-a"
    }
```
Необходимо добавить файл backend.hlc 
```
bucket="yaour backet by terraform "
region="eu-west-3"
endpoint   = "storage.yandexcloud.net"
skip_region_validation      = true
skip_credentials_validation = true

```

### Deploy/Run 

Необходимо устоновить ansible, выпустить ssh key 
```
для Windows использовать wsl2 ** 
```


```
 terraform init -backend-config=backend.hcl
 terraform apply
```


## Getting a list of public images
```
yc compute image list --folder-id standard-images
```

# RESOURCE
<https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html>
