# README

Необходимо реализовать сервис со следующим функционалом на Ruby on Rails.
В базе данных (желательно применить Postgresql) должна быть таблица currency c колонками:
id — первичный ключ
name — название валюты
rate — курс валюты к рублю

И соответсвующая модель.

Должна быть Rake таска для обновления данных в таблице currency. Данные по курсам валют можно взять отсюда: http://www.cbr.ru/scripts/XML_daily.asp

Реализовать 2 REST API метода:
GET /currencies — должен возвращать список курсов валют с возможность пагинации
GET /currencies/:id — должен возвращать курс валюты для переданного id
Ответ должен быть в формате JSON.

Наличие тестов обязательно.
API должно быть закрыто bearer авторизацией.
