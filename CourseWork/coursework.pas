program MKR;
uses crt;
label mainmenu,learning,teoria,praktika,perevod,10,z,ending;

var 
sn,nuser,result,s1,s2:string;
ss,cel,regim,code,n1,j:integer;
n,ost,resultuser,rresult:real;
minus:boolean;

const
    abc:string[16]='0123456789ABCDEF';//возможные символы для систем счисления

//////////проверка ввода перед переходом между метками
    function enter_label(n:integer):integer;
    var prov:string;
    code,r:integer;
    begin
        if (n=3) then
            repeat
                readln(prov);
                if (prov<>'1')and(prov<>'2')and(prov<>'3') then  
                    writeln('Неизвестная команда! Повторите ввод.');
            until (prov='1')or(prov='2')or(prov='3');
        if (n=2) then
            repeat
                readln(prov);
                if (prov<>'1')and(prov<>'2') then 
                    writeln('Неизвестная команда! Повторите ввод.');
            until (prov='1')or(prov='2');
        val(prov,r,code);//перевод строки в число
        enter_label:=r
    end;

//////////чтение файла
    procedure read_file(filename:string);
    var theory:text;
    s:char;
    begin
        assign(theory,filename);
        reset(theory);
        while not Eof(theory) do 
            begin
            read(theory, s);     
            write(s) 
            end;
        close(theory);
        readln()
    end;

//////////проверка системы счисления
    procedure check_ss(var ss:integer);
    var prov:string;
    code:integer;
    begin
        repeat
            readln(prov);
            val(prov,ss,code);
            if (code<>0)or(ss<2)or(ss>16) then //проверка ввода основания сс
                writeln('Неверная система счисления.');
        until (code=0)and(ss>=2)and(ss<=16)
    end;

//////////проверка числа
    procedure check_n(var n:real);
    var prov:string;
    code:integer;
    begin
        repeat
            readln(prov);
            code:=pos(',',prov);
            if code<>0 then //если пользователь ввел запятую в дробном числе
                begin
                delete(prov,code,1);
                insert('.',prov,code)//вставляем вместо запятой точку
                end;
            val(prov,n,code); //переводим строку в число
            if (code<>0) then //если строка после замены не преобразуется - неверный ввод
                writeln('Неверный ввод, повторите.');
        until (code=0)
    end;

//////////деление, дробное и целое
    procedure part(n:real; var ost:real; var cel:integer);
    begin
    if (n=trunc(n)) then //число равно целой его части
        cel:=round(n) //запоминаем
    else //если есть дробная часть
        begin
        cel:=trunc(n); //берем целую
        ost:=frac(n);//берем остаток
        if (n<0) then //если отрицательное
            ost:=ost*(-1)
        end
    end;

///////////целое число из 10 в любую
    function fract(cel, ss:integer):string;
    var s:string;
    begin
        s:='';//пустая строка
        if (cel<0) then //если отрицательная целая часть
            cel:=cel*(-1); //делаем ее положительной
        repeat
            s:=abc[(cel mod ss)+1]+s;//добавляем в начало имеющейся строки остаток от деления целой части на основание сс, переведенный, в соответствии с "алфавитом"
            cel:=cel div ss;//новое целое, которое мы будем делить - целая часть от деления
        until cel=0;//пока целое не станет нулем
        if n<0 then //если число отрицательное
            s:=concat('-',s);//добавляем в начале минус
        fract:=s//результат перевода
    end;

//////////остаток из 10 в любую
    function whole(ost:real; ss:integer):string;
    var s:string;
    k:real;
    begin
        s:='';//пустая строка
        repeat
            k:=ost*ss;//остаток умножаем на систему счисления
            s:=s+abc[trunc(k)+1];//добавляем в конец строки целую часть того, что вышло
            ost:=frac(k);//новый остаток - остаток получившегося k без целой части
        until(frac(ost)=0)or(length(s)>4); //пока остаток не станет нулем или длина ответа не станет слишком большой
        whole:=s//результат перевода
    end;

//////////проверка числа
    procedure check_sn(var sn: string; var minus:boolean;ss:integer);
    var kol,t,j,i:integer;
    f:boolean;
    begin
        repeat 
            readln(sn);//ввод строки
        	minus:=false;
            if (sn[1]='-') then //если в начале минус
                begin
                minus:=true;//изменяем значение
                delete(sn,1,1) //удаляем минус
                end;
            kol:=0;//количество символов
            t:=0;//количество точек/запятых      
            for j:=1 to length(sn) do //идем по строке
                begin
                if ((sn[j]='.')or (sn[j]=',')) then  //если встречаем точку или запятую
                    begin
                    inc(t); //количество точек увеличиваем
                    inc(kol) //количество символов увеличиваем
                    end;        
                for i:=1 to ss do 
                    if (sn[j]=abc[i]) then //сравниваем с "алфавитом"
                        inc(kol)//если соответствует, то учитываем символ
                end;
            if (kol=length(sn)) and (t<2) then //если все введенные символы верны и точка/запятая только одна или нет
                f:=true
            else 
                f:=false;
            if not f then //неверный ввод
                writeln('Неверное число. Повторите ввод.');
        until f
    end;

//////////перевод из любой в 10
    function fromssto10(var sn:string; ss:integer; minus:boolean):real;
    var sum:real;
    num,i,j:integer;
    begin
        sum:=0;//сумма, результат перевода
        num:=length(sn)+1;//считаем, что точка стоит после строки, то есть число целое
        for i:=1 to length(sn) do //идем по строке
            if (sn[i]='.')or(sn[i]=',') then //если встретили точку или запятую
                num:=i;//запомнили позицию
        i:=num-2;//степень первого числа=позиция точки-2
        j:=1;//счетчик позиции
        while (i>=0) and (j<=(num-1)) do //пока степень>=0 и счетчик не дошел до последнего числа целой части
            begin
            sum:=sum+((pos(sn[j], abc)-1)*(exp(ln(ss)*i))); //прибавляем в сумму соответствующее значение цифры(буквы)по алфавиту*систему счисления в степени i
            dec(i);//увеличиваем счетчики
            inc(j)
            end;
        if (num<(length(sn)+1)) then //если число оказалось дробным
            begin
            i:=1;//степень
            j:=num+1;//счетчик позиции
            while (i<=(length(sn)-num)) and (j<=length(sn)) do //пока степень<=длина всего числа-позиция точки и счетчик не дошел до конца
                begin
                    i:=i*(-1);//делаем i отрицательным
                    sum:=sum+((pos(sn[j], abc)-1)*(exp(ln(ss)*i)));//аналогичные вычисления с тем, что было выше
                    i:=i*(-1);//делаем снова положительным
                    inc(i);//прибавляем счетчики позиции и степени
                    inc(j)
                end
            end;
        if minus then //если отрицательное
            sum:=sum*(-1);//делаем из получившейся суммы отрицательное
        fromssto10:=sum
    end;


//////////ОСНОВНАЯ ПРОГРАММА
begin
textbackground (1);//цвет фона
clrscr;//очистить экран
textcolor (15);//цвет шрифта
writeln('Здравствуйте!');
writeln('');
writeln('Добро пожаловать в обучающую программу по системам счисления!');
writeln('Данная программа имеет режим обучения, а так же калькулятор перевода чисел');
writeln('из десятичной системы счисления в любую и наоборот.');
writeln('');
//////////ГЛАВНОЕ МЕНЮ//////////
mainmenu:
writeln('Вы находитесь в главном меню.');
writeln('');
writeln('Выберете нужный вам режим:');
writeln('');
writeln('Введите 1, если хотите войти в режим обучения.');
writeln('Введите 2, если хотите совершить перевод.');
writeln('Введите 3, если хотите выйти из программы.');
case enter_label(3) of
1: goto learning;
2: goto perevod;
3: goto ending
end;
//////////ОБУЧЕНИЕ//////////
learning:
clrscr;
writeln('Вы в режиме обучения.');
writeln('');
writeln('Хотите ли вы узнать о методе перевода, или же приступим сразу к практике?');
writeln('');
writeln('Введите 1, если хотите узнать теорию.');
writeln('Введите 2, если хотите попрактиковаться.');
writeln('Введите 3, если хотите выйти в главное меню.');
case enter_label(3) of
1: goto teoria;
2: goto praktika;
3: begin 
    clrscr; //перед переходом в главное меню необходимо очистить экран, так как в самой метке это сделать нельзя в визуальных целях
    goto mainmenu 
    end
end;
//////////ТЕОРИЯ//////////
teoria:
clrscr;
writeln('Вы выбрали режим теории.');
writeln('');
read_file('theory1.txt');
read_file('theory2.txt');
read_file('theory3.txt');
writeln('');
writeln('Желаете ли вы попрактиковаться в полученных знаниях,');
writeln('еще раз прочесть теорию, или выйти в главное меню?');
writeln('');
writeln('Введите 1, если готовы приступить к заданиям.');
writeln('Введите 2, если хотите еще раз ознакомиться с теорией.');
writeln('Введите 3, если хотите выйти в главное меню.');
case enter_label(3) of
1: goto praktika;
2: goto teoria;
3: begin 
    clrscr; 
    goto mainmenu
    end
end;
//////////ПРАКТИКА//////////
praktika:
writeln('');
randomize;
repeat    
    ss:=random(17);//рандомизирование сс
until (ss>=2)and(ss<=16)and(ss<>10);
regim:=random(2);//рандомизирование куда переводить
if (regim=0) then//из десятичной
    begin
    cel:=random(1001);//рандомизирование целого
    ost:=random(1001);//рандомизирование дробного
    repeat
        ost:=ost/10;//приведение дробного к дробному
    until (trunc(ost)=0);
    n:=ost+cel;//создание числа
    writeln('Совершите перевод числа ',n,' из десятичной системы счисления в ',ss,'-чную');
    writeln('Введите результат перевода, 5 знаков после запятой/точки');
    minus:=false; //изначально число не отрицательно
    check_sn(nuser,minus,ss);//проверка ввода nuser
    code:=pos(',',nuser);
    if code<>0 then //если пользователь ввел запятую в дробном числе
        begin
        delete(nuser,code,1);
        insert('.',nuser,code)//вставляем вместо запятой точку
        end;
    if (n=trunc(n)) then  //если целое число вызываем соответствующую функцию
        if (nuser=fract(cel,ss)) then
            writeln('Отличный и верный результат, МОЛОДЕЦ!')
        else
            writeln('Неверно! Правильный ответ: ',fract(cel,ss))
    else
        begin
        s1:=fract(cel,ss);
        s2:=whole(ost,ss);
        result:=concat(s1,'.',s2);//склеиваем строки
        if (nuser=result) then
            writeln('Отличный и верный результат, МОЛОДЕЦ!')
        else
            writeln('Неверно! Правильный ответ: ',result)
        end;
    end;
if (regim=1) then//в десятичную
    begin
    sn:='         ';
    j:=1;
    repeat
        repeat
            n1:=random(ss+1);
        until (n1<>0);
        sn[j]:=abc[n1];
        inc(j);
    until (j=5);
    sn[j]:='.';
    inc(j);
    repeat
        repeat
            n1:=random(ss+1);
        until (n1<>0);
        sn[j]:=abc[n1];
        inc(j);
    until (j=10);
    writeln('Совершите перевод числа ',sn,' из ',ss,'-чной системы счисления в десятичную');
    writeln('Введите результат перевода, 5 знаков после запятой/точки');
    check_n(resultuser);
    minus:=false;
    str(fromssto10(sn, ss, minus),s1);    
    code:=pos('.',s1);
    if ((length(s1)-code)>5) then
        setlength(s1,code+5);//обрубаем после пяти цифр после запятой,если там цифр больше чем пять
    val(s1,rresult,code);
    if (resultuser=rresult) then
        writeln('Отличный и верный результат, МОЛОДЕЦ!')
    else
        writeln('Неверно! Правильный ответ: ',rresult)
    end;
writeln('');
writeln('Хотите еще порешать, прочитать теорию или выйти в главное меню?');
writeln('');
writeln('Введите 1, если хотите еще попрактиковаться.');
writeln('Введите 2, если хотите еще раз ознакомиться с теорией.');
writeln('Введите 3, чтобы попасть в главное меню.');
case enter_label(3) of
1: goto praktika;
2: goto teoria;
3: begin 
    clrscr; 
    goto mainmenu 
    end
end;
//////////ПЕРЕВОД//////////
perevod:
clrscr;
writeln('Вы в режиме перевода.');
writeln('');
writeln('Выберете тип перевода:');
writeln('');
writeln('Введите 1, если перевод из десятичной в заданную.');
writeln('Введите 2, если перевод из заданной в десятичную.');
case enter_label(2) of
    1: goto 10;
    2: goto z
end;
//////////ИЗ 10 В ЗАДАННУЮ//////////
10:
clrscr;
writeln('Перевод из десятичной системы счисления в заданную.');
writeln('');
writeln('Введите систему счисления, в какую будет проводиться перевод(от 2 до 16):');
check_ss(ss);
writeln('Введите число десятичной системы счисления.');
check_n(n);
writeln('');
//ВЫЧИСЛЕНИЯ
part(n,ost,cel); //высчитываем целую и дробную часть
if (n=trunc(n)) then  //если целое число вызываем соответствующую функцию
    writeln('Перевод десятичного числа ',n,' в ',ss,'-чную сс = ',fract(cel,ss)) 
else
    writeln('Перевод десятичного числа ',n,' в ',ss,'-чную сс = ',fract(cel,ss),'.',whole(ost,ss));
writeln('');
writeln('Хотите повторить или выйти в главное меню?');
writeln('');
writeln('Введите 1, чтобы открыть выбор типа перевода.');
writeln('Введите 2, для выхода в главное меню.');
case enter_label(2) of
    1: goto perevod;
    2: begin 
        clrscr; 
        goto mainmenu 
        end
end;
//////////ИЗ ЗАДАННОЙ В 10//////////
z:
clrscr;
writeln('Перевод из заданной системы счисления в десятичную.');
writeln('');
writeln('Введите систему счисления, из которой будет проводиться перевод(от 2 до 16):');
check_ss(ss);
writeln('Введите число ',ss,'-чной системы счисления.');
minus:=false; //изначально число не отрицательно
check_sn(sn,minus,ss);
writeln('');
//ВЫЧИСЛЕНИЯ
if minus then
    writeln('Перевод числа -',sn,' ',ss,'-чной сс = ',fromssto10(sn, ss, minus))
else
    writeln('Перевод числа ',sn,' ',ss,'-чной сс = ',fromssto10(sn, ss, minus));
writeln('');
writeln('Хотите повторить или выйти в главное меню?');
writeln('');
writeln('Введите 1, чтобы открыть выбор типа перевода.');
writeln('Введите 2, для выхода в главное меню.');
case enter_label(2) of
    1: goto perevod;
    2: begin 
        clrscr; 
        goto mainmenu 
        end
end;
//////////КОНЕЦ//////////
ending:
clrscr
end.