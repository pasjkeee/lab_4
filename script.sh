#!/bin/bash

DIR1=1c
DIR2=auto
THIS=$(pwd) #путь до текущей директории
function1_(){
flag=0
while [ $flag != 1 ] #проверка на номер группы
do

echo Введите номер группы:
    read NUMBER
    echo ======================
    are=$(find $THIS/ -name $NUMBER-attendance) 
    if [ ${#are} -gt 4 ] #Проверка, что такая группа есть
    then
    flag=1
    F=0
    while [ $F != 3 ] && [ $F != 4 ]
    do
    echo Выберите предмет # Выбор действия
        echo 1 - $DIR1
        echo 2 - $DIR2
        echo 3 - Назад
        echo 4 - Выход
        read -p "Ввод: " F # прочитанной как подсказку те не добавляет конечную новую строку перед попыткой прочитать ввод
        echo ======================
    #Копируем исходный файл, чтобы можно было его изменять
    if [ $F == 1 ] || [ $F == 2 ]
        then
        flag_2=1
    test $F == 1 && cp $THIS/$DIR1/$NUMBER-attendance $THIS/ || cp $THIS/$DIR2/$NUMBER-attendance $THIS/ 
    min=100
    max=0
    sed -i 's/[[:space:]]/:/' $THIS/$NUMBER-attendance #Заменяем все пробелы на :
     #Считываем содержимое каждой строки в отедельную переменную в names запись фамилий в att - запись посещаемости 010101010
    while IFS=: read -r names att;
            do
                i=0
                kol=0
                while [ $i -lt ${#att} ] #Итерируемся по содержимому переменной i<длины атт
                do 
                    test ${att:i:1} == '1' && ((kol++)) #Получение элементов массива начиная с элемента с индексом s до элемента с индексом s+(n-1)
                    ((i++))
                done
                test $min -gt $kol && min=$kol # >
                test $max -lt $kol && max=$kol # <
                test $kol -le 9 && sed -i "s/.*$names.*/0$kol:&/" $THIS/$NUMBER-attendance || sed -i "s/.*$names.*/$kol:&/" $THIS/$NUMBER-attendance #Добавляем в начале каждой строки количество занятий, которые посетил студент
            done < $THIS/$NUMBER-attendance 

            sort $THIS/$NUMBER-attendance > cur.txt
            i=0
            while IFS=: read -r count names att #Вывод результата r- считывание построчно
            do
                ((i++))
                printf " %-3s %-15s %-4s\n" "$i" "$names" "$count"
            done < $THIS/cur.txt
            rm cur.txt
            echo
            echo Студенты с худшей посещаемостью:
            while IFS=: read -r count names att; 
            do
                test $count -eq $min && printf "%-15s %-5s\n" "$names" "$count"
            done < $THIS/$NUMBER-attendance
            echo
            echo Студенты с лучшей посещаемостью:
            while IFS=: read -r count names att;
            do
                test $count -eq $max && printf "%-15s %-5s\n" "$names" "$count"
            done < $THIS/$NUMBER-attendance
            rm $THIS/$NUMBER-attendance
            elif [ $F == 3 ]
            then
            echo Выбрана команда Назад.
            elif [ $F == 4 ]
            then
            echo Выход из скрипта!
            echo До свидания!
            FLAG=3
            else
            echo "Неверная цифра"
            echo "Введите цифру ещё раз"
            echo ======================
            fi
            done
        else
            echo "Неверный номер группы"
            echo "Введите номергруппы ещё раз ещё раз"
            echo ======================
    fi
done
}

#!/bin/bash
function2_(){
flag=0
flag_2=0
while [ $flag != 1 ] #проверка на номер группы
do

echo Введите номер группы:
    read NUMBER
    echo ======================
    are=$(find $THIS/ -name $NUMBER-attendance) 
    if [ ${#are} -gt 4 ] #Проверка, что такая группа есть
    then
    flag=1
    F=0
    while [ $F != 3 ] && [ $F != 4 ]
    do
    echo Выберите предмет # Выбор действия
        echo 1 - $DIR1
        echo 2 - $DIR2
        echo 3 - Назад
        echo 4 - Выход
        read -p "Ввод: " F # прочитанной как подсказку те не добавляет конечную новую строку перед попыткой прочитать ввод
        echo ======================
    #Копируем исходный файл, чтобы можно было его изменять
    if [ $F == 1 ] || [ $F == 2 ]
        then
        flag_2=1
                test $F == 1 && cp $THIS/$DIR1/$NUMBER-attendance $THIS/ || cp $THIS/$DIR2/$NUMBER-attendance $THIS/ # Копируем исходный файл с посещаемостью, чтобы знать, оценки каких студентов следует искать
                sed -i "s/[[:space:]]/:/g" $THIS/$NUMBER-attendance
                while IFS=: read -r names att
                    do
                    test $F == 1 && grep "$names" $THIS/$DIR1/tests/TEST-? | grep '[3-5]$' -o > cur.txt || grep "$names" $THIS/$DIR2/tests/TEST-? | grep '[3-5]$' -o > cur.txt # Выводим все оценки студента в отдельный файл
                    test $F == 1 && total=$(grep "$names" $THIS/$DIR1/tests/TEST-? | grep '[3-5]$' -c) || total=$(grep "$names" $THIS/$DIR2/tests/TEST-? | grep '[3-5]$' -c) # Подсчет общего числа оценок
                    test $F == 1 && grep "$names" $THIS/$DIR1/tests/TEST-? | grep '[3-5]$' -c  >> cut.txt || grep "$names" $THIS/$DIR2/tests/TEST-? | grep '[3-5]$'  -c >> cut.txt
                    sum=0
                    S=0
                    while read -r line # Считаем общий балл
                    do
                    ((sum+=$line))
                    ((S+=$line*100))
                    done < cur.txt
                    sum=$( echo "scale=2; $sum/$total" | bc -l ) # Находим средний балл -l , {- -mathlib}: определить стандартную математическую библиотеку
                    ((S/=$total))
                    sed -i "s/.*$names.*/$sum:&:$S/" $THIS/$NUMBER-attendance #i без изменений
                    done < $THIS/$NUMBER-attendance
                sort $THIS/$NUMBER-attendance > cur.txt

                readarray arr < cut.txt
                echo ${arr[0]}

                i=0
                while IFS=: read -r count names att Sum # Вывод отсортированного по среднему баллу списка студентов группы
                do
                ((i++))
                printf "%-3s %-15s %-5s\n" "$i" "$names" "$count"
                done < $THIS/cur.txt
                echo
                j=0
                u=4
                echo Студенты сдавшие с первой попытки:
                while IFS=: read -r count names att Sum
                do
                test ${arr[$j]} -eq $u && printf "%-15s %-5s\n" "$names" "${arr[$j]}"
                ((j++))
                done < $THIS/$NUMBER-attendance
                echo
                j=0
                echo Студенты не сдавшие хотя бы один предмет:
                while IFS=: read -r count names att Sum
                do
                test  ${arr[$j]} -lt $u  && printf "%-15s %-5s\n" "$names" "${arr[$j]}"
                ((j++))
                done < $THIS/$NUMBER-attendance
                rm $THIS/cur.txt # Удаляем вспомогательный файлы
                rm $THIS/$NUMBER-attendance
                rm $THIS/cut.txt
                echo
                elif [ $F == 3 ]
            then
            echo Выбрана команда Назад.
            elif [ $F == 4 ]
            then
            echo Выход из скрипта!
            echo До свидания!
            FLAG=3
            else
            echo "Неверная цифра"
            echo "Введите цифру ещё раз"
            echo ======================
            fi
            done
        else
            echo "Неверный номер группы"
            echo "Введите номергруппы ещё раз ещё раз"
            echo ======================
    fi
done
}

function3_(){
flag=0
while [ $flag != 1 ]
do
    echo Введите ФИО
    read -p "Ввод: " FIO
    echo ======================
    for num in {4..17} # Проверка
    do
        if [ $num -le 9 ]
        then
            cp $THIS/$DIR1/A-06-0$num-attendance $THIS/
            sed -i "s/[[:space:]]/:/g" $THIS/A-06-0$num-attendance 
            while IFS=: read -r name att
            do
                test $FIO == $name && flag=1 && CUR="A-06-0$num-attendance"
            done < $THIS/A-06-0$num-attendance 
            rm $THIS/A-06-0$num-attendance
        else
            cp $THIS/$DIR1/A-06-$num-attendance $THIS/ 
            sed -i "s/[[:space:]]/:/g" $THIS/A-06-$num-attendance 
            while IFS=: read -r name att
            do
                test "$FIO" == "$name" && flag=1 && CUR="A-06-$num-attendance"
            done < $THIS/A-06-$num-attendance 
            cp $THIS/$DIR1/A-09-17-attendance $THIS/ 
            sed -i "s/[[:space:]]/:/g" $THIS/A-09-17-attendance
            while IFS=: read -r name att
            do
                test "$FIO" == "$name" && flag=1 && CUR="A-09-17-attendance"
            done < $THIS/A-09-17-attendance 
            rm $THIS/A-06-$num-attendance 
            rm $THIS/A-09-17-attendance
        fi
    done
    if [ $flag == 1 ]
    then
        echo Характеристика:
        echo $(grep -ih -A2 "$FIO" -r $THIS/students/general/notes/ | grep -iv "$FIO") #-i - не учитывать регистр + v инвертировать -h не выводить имя файла в результатах поиска внутри файлов Linux; Вхождение и т строк до него -r рекурсивный поиск
        echo ======================
        cp $THIS/$DIR1/$CUR $THIS/
        sed -i 's/[[:space:]]/:/g' $THIS/$CUR #Заменяем все пробелы на :
        while IFS=: read -r fam att; #Считываем содержимое каждой строки в отедельную переменную
        do
            if [ $fam == $FIO ]
            then
                grep "$fam" $THIS/$DIR1/tests/TEST-? | grep '[3-5]$' -o > cur.txt
                total=$(grep "$fam" $THIS/$DIR1/tests/TEST-? | grep '[3-5]$' -c)
                sum=0
                while read -r line # Считаем общий балл
                do
                    ((sum+=$line))
                done < cur.txt
                sum=$( echo "scale=2; $sum/$total" | bc -l ) # Находим средний балл
                kol=0
                i=0
                while [ $i -lt ${#att} ] #Итерируемся по содержимому переменной
                do
                    test ${att:i:1} == '1' && ((kol++)) #Считаем количество посещенных занятий
                    ((i++))
                done
            fi
        done < $THIS/$CUR
        echo Количество занятий, которые посетил студент $fam: $kol
        echo ======================
        echo Средний балл за $DIR1:
        printf "%-15s %-5s\n" "$FIO" "$sum"
        rm $THIS/cur.txt # Удаляем вспомогательный файл
        rm $THIS/$CUR
        echo ======================
        cp $THIS/$DIR2/$CUR $THIS/
        sed -i 's/[[:space:]]/:/g' $THIS/$CUR #Заменяем все пробелы на :
        while IFS=: read -r fam att; #Считываем содержимое каждой строки в отедельную переменную
        do
            if [ $fam == $FIO ]
            then
                grep "$fam" $THIS/$DIR2/tests/TEST-? | grep '[3-5]$' -o > cur.txt
                total=$(grep "$fam" $THIS/$DIR2/tests/TEST-? | grep '[3-5]$' -c)
                sum=0
                while read -r line # Считаем общий балл
                do
                    ((sum+=$line))
                done < cur.txt
                sum=$( echo "scale=2; $sum/$total" | bc -l ) # Находим средний балл
                kol=0
                i=0
                while [ $i -lt ${#att} ] #Итерируемся по содержимому переменной
                do
                    test ${att:i:1} == '1' && ((kol++)) #Считаем количество посещенных занятий
                    ((i++))
                done
            fi
        done < $THIS/$CUR
        echo Количество занятий, которые посетил студент $fam: $kol
        echo ======================
        echo Средний балл за $DIR2:
        printf "%-15s %-5s\n" "$FIO" "$sum"
        rm $THIS/cur.txt # Удаляем вспомогательный файл
        rm $THIS/$CUR
        echo  ======================
        else
            echo Такого студента не существует. Попробуйте снова.
    fi
done    
}


echo Добро пожаловать в скрипт!
FLAG=0
while [ $FLAG != 4 ]
do
#-------User interface
echo
echo Введите команду
echo 1 - Посещаемость
echo 2 - Оценки
echo 3 - Инормация об ученике
echo 4 - Выход из скрипта
read -p "Ввод: " FLAG
echo --------------------
if [ $FLAG == 1 ]
then
function1_
elif [ $FLAG == 2 ]
then
function2_
elif [ $FLAG == 3 ]
then
function3_
elif [ $FLAG == 4 ]
then
echo Выход из программы!
else
echo Неверная цифра
fi
done
#--------------------
