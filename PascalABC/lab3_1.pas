Program Lab31;
Var
   x, z, raz, eps, s, chx: real;
   i: integer;
begin
z:=1;
i:=1;
s:=z;
writeln('Лабораторная работа 3');
writeln('Задание 1');
writeln('Введите x');
read(x);
repeat
begin
writeln('Введите Eps>0');
read(eps);
end;
until eps>0;
repeat
      begin
      z:=(z*x*x)/((2*i-1)*2*i);
      s:=z+s;
      i:=i+1;
      end;
until (abs(z)<=eps);
writeln('сумма= ',s:3:2);
chx:=(Exp(x)+Exp(-x))/2;
raz:=abs(s-chx);
writeln('точное значение= ',chx:3:2);
writeln('разность суммы и точного значения= ',raz:3:2);
end.
