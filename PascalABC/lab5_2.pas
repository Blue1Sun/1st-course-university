program lab52;
const lmax=15;
var n,m,j,g,i:integer; b:array [1..lmax,1..lmax] of integer; h,m1,n1,b1:real;
    function z(n,m:integer;var b:array [1..lmax,1..lmax] of integer):integer;
    var min,max,i,j:integer;
    begin
    min:=maxint;
    for j:=1 to m do
        begin
        max:=b[1,j];
        for i:=2 to n do
        if abs(b[i,j])>abs(max) then
        max:=b[i,j];
        if max<min then
        min:=max;
        end;
    z:=min;
    end;
begin
writeln('Лабораторная работа 5');
writeln('Задание 2');
repeat
writeln('Введите длину матрицы B. Размер до ', lmax);
read(n1,m1);
until (n1>0) and (m1>0) and (n1<lmax) and (n1<lmax) and (n1=round(n1)) and (m1=round(m1));
m:=round(m1);
n:=round(n1);
writeln('Введите целые элементы матрицы B ',n,' строк ',m,' столбцов:');
for i:=1 to n do
    for j:=1 to m do
    begin
    repeat
            read(b1);
            if (b1<>round(b1)) then writeln('ВВЕДИТЕ ЦЕЛОЕ!');
    until (b1=round(b1));
    b[i,j]:=round(b1);
    end;
writeln('Выведенная матрица B:');
for i:=1 to n do
    begin
    for j:=1 to m  do
    write(b[i,j]:10);
    writeln;
    end;
h:=z(n,m,b);
writeln('H=',h);
end.