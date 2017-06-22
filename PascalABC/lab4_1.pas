program lab42;
const lmax=15;
var a:array[1..lmax,1..lmax] of integer;
    b:array[1..lmax] of integer;
    c: array[1..lmax,1..lmax] of integer;
    max, n, m, k, d, i, j, q:integer;
    mz,nz,jz, kz,bb:real;
    flag, p: boolean;
begin
writeln('Лабораторная работа 4');
writeln('Задание 1');
max:=-maxint;
repeat
      writeln('Введите размер матрицы A (N строк, M столбцов). Размер до ',lmax,':');
      read(nz,mz);
until (nz>0) and (mz>0) and (nz<=lmax) and (mz<=lmax)and(nz=round(nz))and(mz=round(mz));
n:=round(nz);
m:=round(mz);
writeln('Введите целые элементы матрицы A (', n, ' строк,', m, ' столбцов):');
for i:=1 to n do
    for j:=1 to m do
    begin
    repeat
    read(jz);
    if jz<>round(jz) then
    writeln('дробное');
    until (jz=round(jz));
    a[i,j]:=round(jz);
    end;
writeln('Выведенная матрица A:');
for i:=1 to n do
    begin
    for j:=1 to m do
        write(a[i,j]:10);
        writeln;
    end;
repeat
      writeln('Введите длину массива B. Размер до ',lmax,':');
      read(kz);
until (kz>0) and (kz<=lmax) and (kz=round(kz));
k:=round(kz);
for i:=1 to k do
begin
repeat
    writeln('Введите ',k,' штук целых элементов массива B');
    read(bb);
    if bb<>round(bb) then
    writeln('ЦЕЛОЕ');
until (bb=round(bb));
b[i]:=round(bb);
end;

for i:=1 to k do //Максимум массива
    begin
         if b[i]>=max then
         max:=b[i];
    end;
writeln('Максимальный элемент массива:', max);
p:=false; //Не было удаления
q:=n; //счетчик строк
for i:=1 to q do //От 1 до последней строки
      begin
      flag := true; //нет макс
      j := 1;
      while (j <= m) and (flag=true) do
            if a[i, j] = max then flag := false //есть макс
            else j := j + 1;
      if flag=false then
          begin
          q:=q-1;//удаляем строку
          for j:=i to n do  //От строки с max до нового кол-ва строк
                 for k :=1 to m do //по столбикам
                 a[j,k] := a[j+1,k];
          p:= true; //Удаление было
          end
      end;
if p=false then write('нет удалений')
else if q=0 then write('полное удаление')
else
 begin
  writeln('Массив C');
  for i := 1 to q do
      begin
      for j := 1 to m do
          write(a[i, j]:10);
      writeln;
      end;
 end;
end.