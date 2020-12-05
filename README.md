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

При запуске скрипта появляется **основное меню** взаимодействия с пользователем:

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
  

Работа функций происходит через создание дополнительных файлов в директории `$THIS` для записи в них переменных значений, и далее их удаления.

 ____
 
 ## Работа с функциями
 
 ### `function1_`
 
 При запуске в основном меню пункта 1 вызывается функция `function1_`
 
 При этом функция вызывает запрос на ввод:

 ```Shell
 Введите номер группы:
 ```
 
 Необходимо ввести строку фомата `$NUMBER` (описанного выше)
 
 При вводе любого другово значения выведется оповещение:

 ```Shell
Неверный номер группы
Введите номергруппы ещё раз
 ```
 
 При уcпешном нахождении группы функция вызывает подменю:
 
 ```Shell
 Выберите предмет 
     1 - $DIR1
     2 - $DIR2
     3 - Назад
     4 - Выход
       Ввод: 
```
 
 Необходимо ввести числа от 1 до 4 для продолжения работы.

 При вводе любого другого значения выведется оповещение: 
 
 ```Shell
 Неверная цифра
 Введите цифру ещё раз
  ```
 Пример взаимодействия со скриптом: 
  
   ```Shell
   Введите номер группы:
A-06-17
======================
Выберите предмет
1 - 1c
2 - auto
3 - Назад
4 - Выход
Ввод: 1
======================
 1   MatveevDY       08
 2   AlayevMA        12
 3   BosakovskyDV    12
 4   ChakolyadenisE  12
 5   KardanevAA      12
 6   KuzhaniazovAO   12
 7   KlimenkoAVal    13
 8   NazhmetdinovMA  13
 9   AvilovDS        14
 10  BogodukhovYD    14
 11  ZadorinSA       14
 12  KostinaMarA     15
 13  RybkinPV        16
 14  DubovetsGV      17

Студенты с худшей посещаемостью:
MatveevDY       08

Студенты с лучшей посещаемостью:
DubovetsGV      17
```

Далее программа выходит в подменю.

Далее можно выйти как в основное меню, так и вывести снова результат по одному из предметов
 
 ____
 
 
 ### `function2_`
 
 
 При запуске в основном меню пункта 2 вызывается функция `function2_`
 
 При этом функция вызывает запрос на ввод:

 ```Shell
 Введите номер группы:
 ```
 
 Необходимо ввести строку фомата `$NUMBER` (описанного выше)
 
 При вводе любого другово значения выведется оповещение:

 ```Shell
Неверный номер группы
Введите номергруппы ещё раз
 ```
 
 Пример взаимодействия:
 
 
 
 При уcпешном нахождении группы функция вызывает подменю:
 
  
 ```Shell
 Выберите предмет 
     1 - $DIR1
     2 - $DIR2
     3 - Назад
     4 - Выход
       Ввод: 
```
 
 Необходимо ввести числа от 1 до 4 для продолжения работы.

 При вводе любого другого значения выведется оповещение: 
 
 ```Shell
 Неверная цифра
 Введите цифру ещё раз
  ```
  
   Пример взаимодействия со скриптом: 
   
```Shell
Введите номер группы:
A-06-17
======================
Выберите предмет
1 - 1c
2 - auto
3 - Назад
4 - Выход
Ввод: 1
======================
1   AlayevMA        2.42
2   ZadorinSA       2.46
3   AvilovDS        2.50
4   BosakovskyDV    2.54
5   KuzhaniazovAO   2.75
6   DubovetsGV      2.85
7   MatveevDY       3.00
8   BogodukhovYD    3.60
9   KlimenkoAVal    3.66
10  KostinaMarA     3.75
11  ChakolyadenisE  4.00
12  NazhmetdinovMA  4.00
13  KardanevAA      4.75
14  RybkinPV        5.00

Студенты сдавшие с первой попытки:
KardanevAA      4

KostinaMarA     4

NazhmetdinovMA  4

ChakolyadenisE  4


Студенты не сдавшие хотя бы один предмет:
AvilovDS        1

AlayevMA        3

```
      
Далее программа выходит в подменю.

Далее можно выйти как в основное меню, так и вывести снова результат по одному из предметов
  ### `function2_3`
 
 
 При запуске в основном меню пункта 3 вызывается функция `function3_`
 
 При этом функция вызывает запрос на ввод:

 ```Shell
 Введите Введите ФИО:
 Ввод:
 ```
 
 ФИО необходимо вводить полностью с инициалами
 
 Если функция не находит данную фамилию, то выведется оповещение:

 ```Shell
Такого студента не существует. Попробуйте снова.
 ```
 
 Пример взаимодействия со скриптом:
 
  ```Shell
  Введите команду
1 - Посещаемость
2 - Оценки
3 - Инормация об ученике
4 - Выход из скрипта
Ввод: 3
--------------------
Введите ФИО
Ввод: RybkinPV
======================
Характеристика:
Отличник! Занимается спортом, работает, делает все вовремя!
======================
Количество занятий, которые посетил студент : 16
======================
Средний балл за 1c:
RybkinPV        5.00
======================
Количество занятий, которые посетил студент : 18
======================
Средний балл за auto:
RybkinPV        5.00
======================
  ```
 
 
 
