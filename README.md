# lab_4
Состав бригады:

🚀 1) Рыбкин Павел - Full Stack Middle Developer

👻 2) Матвеев Денис - Project Manager dungeon master

🚽  3) Чаколья Даниель - trainee QA Engineer 


====================================================

1. В качестве предметной области и исходных данных выступает Файловая Система Преподавателя из Лабораторной работы №3.
✔️ 

Загрузил на git исходные данные 

====================================================

2. Базовое решение для успешной сдачи лабораторной работы должно предоставлять следующие возможности по заданному пользователем номеру группы:

 🍕 вывод имени студента с наихудшей посещаемостью и количество посещенных им занятий; ✔️

 🍔 вывод имени студента с наилучшей посещаемостью и количество посещенных им занятий;✔️

 📄 вывод списка группы, упорядоченного по посещаемости. ✔️

Все протестировано. Все работает.

====================================================

3. Для получения Отличной оценки также необходимо в рамках решения по заданному пользователем номеру группы реализовать:

 🍑 вывод списка студентов, сдавших все тесты с первой попытки; ✔️

 🍈 вывод списка студентов, не сдавших хотя бы один из тестов; ✔️

 🆎 вывод списка группы, упорядоченного по успеваемости. ✔️
 
 ====================================================
 
 4. Реализовать возможность вывода по фамилии студента: 
 
  📚 средней оценки по всем тестам ✔️
 
  :octocat: количество попыток сдачи ✔️
 
  ⚠️ досье ✔️



____


# Документация

## Общие положения


Скрипт представляет собой код на языке shell. 

Он состоит из одного файла `script.sh`

Скрипт должен находится в корневой папке с проектом (далее -  `$THIS`)

____


В директории могут содержаться 3 формы фалов:

+ Файл с посещаемостью: `$NUMBER-attendance`, где (и далее) `$NUMBER` - номер группы в формате A-06-17

  Он должен находится в директории: `THIS/$DIR1/$NUMBER-attendance` либо `THIS/$DIR2/$NUMBER-attendance`

  `$DIR1` и `$DIR2` (далее `$DIR`) конфигурируются в 3 и 4 строке кода соответственно.

+ Файл с результатами теста: `$TEST-` в формате `$TEST-N` где `N` любой симовол 

  Он должен находится в директории: `$THIS/$DIR/tests/$TEST-`
  
 + Файл с досье `notes`
  Он должен находится в директории: `$THIS/students/general/notes/`
  
  ____

При запуске скрипта появляется менб взаимодействия с пользователем:

```Shell
 Введите команду
 1 - Посещаемость
 2 - Оценки
 3 - Инормация об ученике
 4 - Выход из скрипта
 "Ввод:
```

Необходимо ввести числа от 1 до 4 для продолжения работы.

При вводе любого другово значения выведется оповещение: `Неверная цифра`

____


Скрипт состоит из 3х функций:

+ `function1_` Вывод:

  + Список студентов группы `$NUMBER`, упорядоченные по посещаемости в порядке возрастания и количество посещенных ими занятий
  
  + Студент из группы `$NUMBER` с лучшей посещаемостью и колличество посещенных им занятий
  
  + Студент из группы `$NUMBER` с худшей посещаемостьюи колличество посещенных им занятий 
  
+ `function2_`  Вывод:

  + Список студентов группы `$NUMBER`, упорядоченные по успеваемости в порядке возрастания и средний балл каждого ученика
  
  + Список студентов группы `$NUMBER`, сдавших все тесты с первого раза и количество сданных ими тестов
  
  + Список студентов группы `$NUMBER`, не сдавших хотя бы один тест и количество сданных ими тестов
  
+ `function3_`  Вывод:

  + Досье выбранного `студента` (далее `$FIO`) 
  
  + Средний балл выбранного `студента` по предемету `$DIR1` и количество попыток сдачи данного предмета
  
  + Средний балл выбранного `студента` по предемету `$DIR2` и количество попыток сдачи данного предмета
  

 ____
 
 ## Работа с функциями
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
