Program Lab2;
Const
lmax = 20;
Type
mass=array[1..lmax] of real;
Var
R:mass;
n, k, i, j, notr, nmin, c: integer;
a, h, x, sum, sr: real;
begin
writeln('Лабораторная работа 2');

writeln('Задание 1');
while ( ( n <= 0 ) or ( n > lmax) ) do
begin
writeln('Введите длину массива R от 1 до ', lmax);
read(n);
end;
writeln('Введите x');
read(x);
writeln('Введите h');
read(h);
writeln('Введите a');
read(a);
for i:= 1 to n do
	begin
		R[i]:= 0.8*cos(8*a*x-i*h);
		end;
	writeln('Массив R состоит из ',n,' элементов');
	for i := 1 to n do
write(R[i]:10:3);
writeln(' ');
writeln('Задание 2');
	k:=0;
	for i:=1 to n do
	if (R[i]<=0) or (R[i]>= i/3) and (R[i]>0) then
		begin
		k:=k+1;
		R[k]:=R[i];
		end;
if k=n then
	writeln('нет удалений')
	else
		if k=0 then
			writeln('все элементы удалены')
		else
			begin
			writeln('Новая длина массива R - ', k);
			for i:= 1 to k do
			write(R[i]:10:3);
			end;
	writeln(' ');
	writeln('Задание 3');
nmin:=1;
notr:=0;
for i:=1 to k do
	begin
	if R[i]<0 then
notr:=I;
		if abs(R[nmin])>abs(R[i]) then
nmin:=I;
		end;
	if notr=0 then
		writeln('необходим отрицательный элемент')
	else
		begin
if notr>nmin then
begin
			c:=notr;
notr:=nmin;
 			nmin:=c;
			end;
		sum:=0;
		if nmin-notr>1 then
			begin
			for i:=notr to nmin do
			Sum:=sum+R[i];
		sr:=sum/(nmin-notr+1);
		writeln('Среднее арифметическое= ',sr:10:3);
		end
		else
			writeln('элементы для расчета отсутствуют')

	end;
end.
