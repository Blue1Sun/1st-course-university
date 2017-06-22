program lab32;
const lmax=15;
var a:array[1..lmax,1..lmax] of integer;
    x:integer;
    n,i,j,k,max,min,sum:integer;
begin
writeln('Лабораторная работа 3');
writeln('Задание 2');
repeat
writeln('Размер матрицы от 1 до ',lmax);
readln(n);
until (n>0) and (n<=lmax);
writeln('Введите матрицу размера ',n,' на ',n);
for i:=1 to n do
  for j:=1 to n do
  read(a[i,j]);
writeln('Выведенная матрица:');
for i:=1 to n do
begin
  for j:=1 to n do
    write(a[i,j]:10);
    writeln;
end;
for i:=1 to n-1 do
for j:=i+1 to n do
if abs(a[i,1])>abs(a[j,1])then
 begin
  x:=a[i,1];
  a[i,1]:=a[j,1];
  a[j,1]:=x
 end;
if n<3 then
writeln('матрица слишком мала')
else
begin
writeln('3 минимальных по модулю элемента первого столбца');
for i:=1 to 3 do
write(a[i,1]:10);
end;
writeln;
writeln('Задание 3');
max:=A[n,1];
min:=A[n,1];
writeln('Получившаяся матрица');
     for i:=1 to n do
     begin
          for j:=1 to n do
              write(A[i,j]:10);
              writeln;
          end;
     j:=1;
     for i:=n downto 1 do
         begin
         if a[i,j]>max then max:=a[i,j];
         j:=j+1;
         end;
         j:=1;
     for i:=n downto 1 do
         begin
         if a[i,j]<min then min:=a[i,j];
         j:=j+1;
         end;
         writeln('Максимальный элемент = ',max);
         writeln('Минимальный элемент = ',min);
         sum:=max+min;
         writeln('Сумма = ',sum);
end.
