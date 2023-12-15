# PetFinder-Case


## About




_This repository created for development starter pack._
### Requirements: 

> environment:
> sdk: >=3.1.0 <4.0.0




## Scripts:
This project includes rps scripts.
###### First of All, You should activate rps.
```dart pub global activate rps --version 0.7.0-dev.6```
###### Then you ready for some magic 
###### -- 

```sh
scripts:
    model_build: "dart run build_runner build --delete-conflicting-outputs"
    clean_get: "flutter clean && flutter pub get"
```
###### Easily you can use that
```rps model_build```
or
```rps clean_get```


#### Oopss Dont Forget 
The Injection Container is not generated yet. You should generate it.
```rps model_build```






