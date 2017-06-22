program lab61;
const lmax=20;
type strok= array[1..lmax] of string;
nomer=array[1..lmax] of integer;
Var a,b: strok;  //b - массив подстрок
nom:nomer; //массив номеров строк, из которых выделелись подстроки
rowr:real;
i, k, k2,maxi:integer;//k2 - кол-во подстрок
////////
procedure podstroki(k:integer; var a:strok; var k2:integer; var b: strok; var nom:nomer);
var i,j,j1: integer;
begin
k2:=0; //изначально подстрок нет
for i:=1 to k do //идем по строкам
    begin
    j:=1;//номер символа
    j1:=0; //номер предыдущей точки
    while j<=length(a[i]) do //идем по символам, пока не дошли до конца строки
          if (a[i][j]='.') then //если мы нашли точку
          begin
             if (j1<>0) then  //точка уже была
                begin
                k2:=k2+1; //увеличиваем кол-во подстрок
                nom[k2]:=i; //записываем номер строки откуда нашли подстроку
                b[k2]:=copy(a[i],j1,j-j1);
                end;
             while (j<=length(a[i])) and (a[i][j]='.') do
                   j:=j+1; //движемся дальше по символу
             j1:=j; //запоминаем номер символа после точки
          end
          else j:=j+1; //если не нашли точку
    end;
end;
//////
procedure cifr(k2:integer; var b:strok; var maxi:integer);
var i,j, max, k:integer;
begin
maxi:=0;
max:=0;
k:=0;
for i:=1 to k2 do    //исследуем подстроки
    begin
    if (b[i][1]>='0') and (b[i][1]<='9') then //если начинается с цифры
         begin
         k:=1;//количество цифр
         j:=2;//номер символа
         while (b[i][j]>='0') and (b[i][j]<='9')  do  //пока цифры в начале не закончатся
            begin;
            k:=k+1;
            j:=j+1;
            end;
         end;
    if k>max then   //находим максимум количества цифр
       begin
       maxi:=i;
       max:=k;
       end;
    end;
end;
/////
procedure stars(var s:string);
var i,t:integer;
begin;
for i:=1 to length(s)do
    if (s[i]>='0')and (s[i]<='9') then
       t:=i; //номер последней цифры
    insert('***',s,t); //вставляем перед ней три звездочки
    end;
//////////
begin
repeat
      writeln('Введите количество строк < ',lmax);
      readln(rowr);
until (rowr>0) and (rowr<=lmax) and (rowr=round(rowr));
k:=round(rowr);
writeln('Введите строки:');
for i:=1 to k do
    readln(a[i]);
podstroki(k,a,k2,b,nom);
if (k2=0) then //кол-во подстрок=0
   writeln('нет подстрок')
else
    begin
    writeln('Получены подстроки');
    for i:=1 to k2 do
        writeln(b[i]);
    cifr(k2,b,maxi);
    if maxi=0 then writeln('Ни одна подстрока не начинается с цифры')
    else
        begin
        writeln('Подстрока, начинающаяся с max кол-ва цифр:');
        writeln(b[maxi]);
        writeln('Измененная строка:');
        stars(a[nom[maxi]]);
        writeln(a[nom[maxi]]);
        end;
    end;
end.