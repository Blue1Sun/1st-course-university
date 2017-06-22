Program Lab1;

Const
   lmax = 20;
Type
    mass=array[1..lmax] of real;
Var
   B, D, A:mass;
   i, k, j, nmin: integer;
   x,z,x1,min: real;

begin
     writeln('Лабораторная работа 1');
     writeln('Задание 1');
     while ( ( k <= 0 ) or ( k > lmax) ) do
           begin
           writeln('Введите длину массива В от 1 до ', lmax);
           read(k);
           end;
     writeln('Введите массив В из ', k, ' элементов');
     for i:= 1 to k do
     read(b[i]);
     writeln('Введите x');
     read(x);
     while (z < x) do
           begin
           writeln('Введите z, z>x');
           read(z);
           end;
     nmin := 0;
     min := 1E308;
     for i := 1 to k do
     if (b[i] <= min) and (b[i] > x) and (b[i] < z) then
        begin
        min := b[i];
        nmin := i;
        end;
     if nmin = 0 then
        writeln('Нет минимума')
     else
         begin
         writeln('min = ', min:10:3);
         writeln('nmin = ', nmin);
         end;
     j := 0;
     for i := 2 to k do
     if b[i] <= b[i-1] then
        begin
        j := j+1;
        d[j] := -b[i];
        end;
     if (j = 0) then
        begin
        writeln('Задание 2,3');
        writeln('нет массивов D и A');
        end
     else
         begin
         writeln('Задание 2');
         writeln ('Массив D состоит из ', j, ' элементов:');
         for i := 1 to j do
         writeln(d[i]:10:3);
         writeln('Задание 3, номер 3');
         writeln('Введите значение x1');
		     readln(x1);
		     for i := 1 to j do
			   if (d[i] <= x1) then
				    a[i] := 1/(d[i]-2)
        else
				    a[i] := d[i];
	       write('Массив А состоит из ', j,'элементов');
	       for i := 1 to j do
	       write(a[i]:10:3);
         end;

end.
