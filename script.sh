# задаём переменные
DIR1=1c 
DIR2=auto
THIS=$(pwd) #путь до текущей директории

echo Введите номер группы:
    read NUMBER
    echo ======================
    are=$(find $THIS/ -name $NUMBER-attendance) 

    echo Выберите предмет # Выбор действия
        echo 1 - $DIR1
        echo 2 - $DIR2
        read -p "Ввод: " F # прочитанной как подсказку те не добавляет конечную новую строку перед попыткой прочитать ввод
        echo ======================
    #Копируем исходный файл, чтобы можно было его изменять
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
            while IFS=: read -r count names att #Вывод результата
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
    $SHELL