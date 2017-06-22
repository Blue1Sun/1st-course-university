program lab8;
type RecDyn = ^node;//ссылочный тип
     node = record
     next:RecDyn;
     info:integer;
     end;
var
queue1: RecDyn; //очередь
phase,el,el1,itog: integer;  //фаза процедур, наличие четного эл-та, пустота списка
//////////////
procedure queue(var first:RecDyn);
//создание очереди
Var
code, N:integer;
s:string;
Last, Curr: RecDyn;
begin
writeln('Введите целые числа:');
repeat
read(s); //ввод первого числа
val(s,N,code);   //проверям на перевод строки в число
if code<>0 then writeln('Введите целое число');
if code=0 then
begin
 if N = 0 then
   First:= NIL //занесение признака пустой очереди
 else
    begin
    New(Curr);//выделение памяти для первой записи
    First:=Curr; //запоминание адреса первой записи очереди
    repeat //цикл ввода и запоминания чисел
          Last:=Curr; //запоминание адреса последней записи
          New(Curr); //выделение памяти для следующей записи
          Last^.next:=curr; //занесение в поле указателя последней записи очереди адреса следующей записи, которой может и не быть
          Last^.Info := N; //занесение введенного числа в информационное поле последней записи
          repeat     //проверям на перевод строки в число
          read(s);
          val(s,N,code);
          if code<>0 then writeln('Введите целое число');
          if code=0 then
          until code=0;
    until N = 0; //формирование очереди заканчивается при вводе 0
    Last^.next:= NIL; //занесение в поле указателя последней записи признака конца очереди
    Dispose(Curr);  //освобождение памяти для неиспользованной записи
    end;
end;
until code=0;
end;
//////////////
procedure print(first:RecDyn;var itog:integer);
//вывод списка на экран
var curr:RecDyn;
begin
if first=nil then
   begin
   writeln('Список пуст');
   itog:=0;
   end
else
    begin
    case (phase) of
    0:writeln('Исходный список:');
    1:writeln('Полученный список(вставить заданное число после каждого элемента с нечетным номером):');
    2:writeln('Финальный список(упорядочить по возрастанию пузырьком до первого четного элемента):');
    end;
    curr:=first;
    while curr<>nil do
          begin
          write(curr^.info:8); //вывод поля данных
          curr:=curr^.next; //переход к следующей записи списка
          end;
    writeln;
    end;
end;
//////////////
procedure vstavka(var first:RecDyn);
var curr, ra1, lel,next:RecDyn;
a1, i, code:integer;
s: string;
//вставить заданное целое число A1 после каждого элемента с нечетным номером
//ПЕРВАЯ ПРОЦЕДУРА
begin
phase:=1; //сменяем фазу для вывода
curr:=first; //берем первый элемент как текущий
lel:=first; //первый - нечетный, начинаем с него
writeln('Введите целое число А1');
repeat   //проверка
     read(s);
     val(s,a1,code);
     if code<>0 then writeln('Введите целое число');
     until (code=0);
i:=1; //счетчик четности
while (curr<>NIL) do  //пока не дошли до конца
      begin
      if i=1 then
       begin
       New(ra1);
       ra1^.info:=a1;   //записываем A1
       lel:=curr;    //нечетный - текущий
       curr:=curr^.next; //переходим на следующий
       ra1^.next:=lel^.next;   //впихиваем после четного число
       lel^.next:=ra1;
       i:=0; //нечетный
       end else begin
       curr:=curr^.next; //переходим на следующий после следующего
       i:=1; //он будет четным
       end;
      end;
end;
/////////////
procedure bubblesort(var first:RecDyn; var el:integer; var el1:integer);
//ВТОРАЯ ПРОЦЕДУРА
var curr,next:RecDyn;
flag:boolean; //признак завершения сортировки
c:integer; //переменная для перестановки значений
begin
phase:=2; //фаза для вывода
repeat
curr:=first; //берем первый текущим
flag:=true;
if (curr^.info mod 2 = 0) then
   el1:=1;
while (curr^.next<>nil) and (curr^.info mod 2<>0) do //пока не дошли до конца и не встретили четный
      begin
      next:=curr^.next;
      if (next^.info mod 2 = 0) or (curr^.info mod 2 = 0) then
         el:=1;   //четное число встречено
      if (curr^.info>next^.info) and (next^.info mod 2<>0) then  //если нужно произвести сортировку и впереди не четный
         begin
         c:=curr^.info;
         curr^.info:=next^.info;  //перестановка
         next^.info:=c;
         flag:=false;
         end;
      curr:=next; //переход к следующей записи
      end;
until flag; //пока сортировка не закончится
end;
////////////////
begin
phase:=0;  //изначальная фаза
itog:=1;  //изначальное наличие списка
el:=0;   //изначальное отсутсвие четного
el1:=0;  //изначальная нечетность первого элемента
queue(queue1);
print(queue1,itog);
if itog<>0 then   //если список не пуст
   begin
   vstavka(queue1);
   print(queue1,itog);
   bubblesort(queue1,el,el1);
   if (el=0) and (el1<>1) then
      writeln('Нет четных элементов')
   else
   if (el1=1) then
      writeln('Первый элемент четный')
   else
       print(queue1,itog);
end;
//2 7 5 3 1 2 4 7 3 1 4 0
end.