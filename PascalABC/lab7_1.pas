program lab71;
var f:file of real;
//////
procedure make(var f:file of real); //создание файла
var s:string; c:real; code:integer;
begin
     writeln('Вводите числа в столбец');
     writeln ('Признак окончания ввода - буква/пробел');
     assign(f,'f.txt');    //связываем имя переменной с файлом
     rewrite(f);     //создаем файл
     repeat
           readln(s);   //считываем строки
           val(s,c,code);   //проверям на перевод строки в число
           if code=0 then
              write(f,c);    //если ошибки нет, то записывем
     until code<>0;   //если ошибка есть, то файл закрываем
     close(f);
     writeln('Файл сформирован');
end;
//////
procedure print(var f:file of real);   //вывод записанного
var c:real;
begin
     reset(f);   //открываем файл
     writeln('Файл содержит числа:');
     while not eof(f) do  //пока указатель не в конце файла
           begin
           read(f,c);  //выписываем число на экран
           write(c:10:2);
           end;
     writeln;
     close(f);  //закрываем файл
end;
//////
procedure find(var f:file of real);  //поиск максимального отрицательного
var c,min,rez:real;
begin
     min:=1e308;  //первоначальный минимум
     rez:=0; //результат поиска
     reset(f); //открываем файл
     if not eof(f) then
     begin
     repeat
           read (f,c); //читаем файл
           if c<0 then  //если число отрицательное
                  if (abs(c)<abs(min)) then
                  begin
                       min:=c;
                       rez:=c;
                  end;    //если он минимальный по модулю,то записываем
     until eof(f); //пока не дойдем до конца файла
     end;
     close(f); //закрываем файл
     if rez=0 then
        writeln('Отрицательных чисел нет')
     else
         Writeln('Максимальное среди отрицательных число = ',rez);
end;
begin    //основная программа
     make(f);
     reset(f);
     if eof(f) then begin close(f); writeln('Пустой файл'); end
     else begin
     print(f);
     find(f)
     end;
end.