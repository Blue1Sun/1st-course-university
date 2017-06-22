program lab73;
const lmax=50;
type tv = record
     name:string;   //имя
     izg: record         //изготовитель
         gor,zav:string;               //город, завод
         end;
     par: record        //параметры
          god,price:integer;       //год, цена
          h: string;               //размер экрана
          end;
     end;
var
nabor: array [1..lmax] of tv;   //массив записей
n,i1,i,k,max,min:integer;  //количество записей, номер найденной записи,для счета, число прочитанных записей,макс.год,мин.цена
fname:string;   //строка с именем файла
f:text;  //переменная текстового файла
t:tv;   //текущий набор
////////////проверка
procedure petr(var t:integer);
var s: string; code: integer;
begin
     repeat
     read(s);
     val(s,t,code);
     if code<>0 then writeln('Введите целое число');   //если будет ошибка
     if t<0 then writeln('Число отрицательно, повторите ввод');
     until (code=0) and (t>0);
end;
////////////////
begin
     repeat
           writeln('Введите имя файла');
           readln(fname);
           fname:=fname+'.txt';
           assign(f, fname);
     until cancreatefile(fname);         //проверка на возможность создания файла
     rewrite(f);   //открытие файла для записи
     repeat
           writeln('Введите количество ТВ до ',lmax);
           petr(k);
     until (k>0) and (k<=lmax);    //проверка
     for i:=1 to k do     //записывание
         with t do
         begin
              write('Название ',i,' телевизора '); readln(name); writeln(f,name);
              writeln('Город, завод изготовитель'); readln(izg.gor, izg.zav); writeln(f, izg.gor:20, izg.zav:20);
              writeln('Год выпуска, цена, размер экрана'); petr(par.god);petr(par.price); readln(par.h); writeln(f, par.god:10, par.price:10, par.h:10);
         end;
     close(f);
     reset(f); //чтение
     i:=0;
     while not eof(f) do
     begin
           i:=i+1;
           with nabor[i] do
           begin
                readln(f, name);
                readln(f, izg.gor, izg.zav);
                readln(f, par.god, par.price, par.h);
           end;
     end;
     k:=i;
     close(f);
     max:=0;
     min:=2147483647;
     for i:=1 to k do
         with nabor[i] do
              if (par.god>max) then          //поиск макс.года
                 max:=par.god;
     for i:=1 to k do
         with nabor[i] do
              if (par.god=max)  and (par.price<min) then     //поиск мин. для него цены
                 begin
                 min:=par.price;
                 i1:=i;
                 end;
     if i1=0 then writeln('Набор не найден')
     else
     begin
     writeln('Номер набора с максимальным годом и минимальной для этого года ценой - ',i1);
     writeln ('Название : ',nabor[i1].name);
     writeln ('Город, завод изготовитель :',nabor[i1].izg.gor, nabor[i1].izg.zav);
     writeln ('Год выпуска, цена, размер экрана :',nabor[i1].par.god:10, nabor[i1].par.price:10, nabor[i1].par.h:10);
     end;
end.