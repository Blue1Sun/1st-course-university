program lab51;
var k:integer;k1,ff:real;
function f(k:integer):real;
begin
if k=0 then f:=1
else f:=f(k-1)*k;
end;
begin
writeln('Лабораторная работа 5');
writeln('Задание 1');
repeat
writeln('Введите целое неотрицательное k');
read(k1)
until (k1=round(k1)) and (k1>=0);
k:=round(k1);
ff:=f(2*k+1)/(exp(ln(2)*k)*f(k));
writeln('F=',ff);
end.

