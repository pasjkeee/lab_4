# задаём переменные
DIR1=1c 
DIR2=auto
THIS=$(pwd) #путь до текущей директории

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
    while [ $flag_2 != 1 ] #проверка на цифру
    do
    echo Выберите предмет # Выбор действия
        echo 1 - $DIR1
        echo 2 - $DIR2
        read -p "Ввод: " F # прочитанной как подсказку те не добавляет конечную новую строку перед попыткой прочитать ввод
        echo ======================
    #Копируем исходный файл, чтобы можно было его изменять
    if [ $F == 1 ] || [ $F == 2 ]
        then
        flag_2=1
                test $F == 1 && cp $THIS/$DIR1/$NUMBER-attendance $THIS/ || cp $THIS/$DIR2/$NUMBER-attendance $THIS/ # Копируем исходный файл с посещаемостью, чтобы знать, оценки каких студентов следует искать
                sed -i "s/[[:space:]]/:/g" $THIS/$NUMBER-attendance
                min=500
                max=0
                while IFS=: read -r names att
                    do
                    test $F == 1 && grep "$names" $THIS/$DIR1/tests/TEST-? | grep '[3-5]$' -o > cur.txt || grep "$names" $THIS/$DIR2/tests/TEST-? | grep '[3-5]$' -o > cur.txt # Выводим все оценки студента в отдельный файл
                    test $F == 1 && total=$(grep "$names" $THIS/$DIR1/tests/TEST-? | grep '[3-5]$' -c) || total=$(grep "$names" $THIS/$DIR2/tests/TEST-? | grep '[3-5]$' -c) # Подсчет общего числа оценок
                    sum=0
                    S=0
                    while read -r line # Считаем общий балл
                    do
                    ((sum+=$line))
                    ((S+=$line*100))
                    done < cur.txt
                    sum=$( echo "scale=2; $sum/$total" | bc -l ) # Находим средний балл
                    ((S/=$total))
                    sed -i "s/.*$names.*/$sum:&:$S/" $THIS/$NUMBER-attendance
                    test $min -gt $S && min=$S # Запоминаем минимальный и максимальный средний балл
                    test $max -lt $S && max=$S
                    done < $THIS/$NUMBER-attendance
                sort $THIS/$NUMBER-attendance > cur.txt
                i=0
                while IFS=: read -r count names att Sum # Вывод отсортированного по среднему баллу списка студентов группы
                do
                ((i++))
                printf "%-3s %-15s %-5s\n" "$i" "$names" "$count"
                done < $THIS/cur.txt
                echo
                echo Студенты с худшим средним баллом:
                while IFS=: read -r count names att Sum
                do
                test $Sum -eq $min && printf "%-15s %-5s\n" "$names" "$count"
                done < $THIS/$NUMBER-attendance
                echo
                echo Студенты с лучшим средним баллом:
                while IFS=: read -r count names att Sum
                do
                test $Sum -eq $max && printf "%-15s %-5s\n" "$names" "$count"
                done < $THIS/$NUMBER-attendance
                rm $THIS/cur.txt # Удаляем вспомогательный файлы
                rm $THIS/$NUMBER-attendance
                echo
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
    $SHELL