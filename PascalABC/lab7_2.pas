//упорядочить  все  цифры  по  убыванию  (например,  строка  '1c2a3b' преобразуется в строку '3c2a1b')
program lab72;
var a, k, b, z, i,j:integer; c:char; name1,name2,s:string; f1,f2:text;  flag: boolean;
begin
     repeat
           writeln('Введите имя первоначального файла');
           readln(name1);
           name1:=name1+'.txt';
           assign(f1, name1);
     until fileexists(name1);   //проверка на создание файла1
     repeat
           writeln('Введите имя конечного файла');
           readln(name2);
           name2:=name2+'.txt';
           assign(f2, name2);
     until cancreatefile(name2);    //проверка на создание файла2
     reset(f1); //открываем файл1 для чтения
     rewrite(f2); //создаем файл2
     reset(f2);//открываем файл2 для чтения
     writeln('Результат:');
     while not eof(f1) do //пока не конец первого файла1
           begin
           readln(f1,s);//считываем стороку из файла1
           repeat
                 flag:=true;   //флаг на изменение
                 for i:=1 to (length(s)-1) do
                     if(s[i]>='0') and (s[i]<='9')then   //первая цифра
                     for j:=i to (length(s)) do
                         if(s[j]>='0') and (s[j]<='9')then //вторая цифра
                         if s[j]>s[i] then  //если вторая больше первой
                            begin       //меняем местами
                            c:=s[j];
                            s[j]:=s[i];
                            s[i]:=c;
                            flag:=false  //перестановка была
                            end;
           until flag=true; //пока перестановка не произойдет
           append(f2); //дозаписываем файл2
           writeln(f2, s);
           writeln(s); //выводим на экран
           end;
     close(f1);//закрываем файл1
     close(f2);//закрываем файл2
end.
