Program Lab1;

Const
   lmax = 20;
Type
    mass=array[1..lmax] of real;
Var
   B, D, A:mass;
   i, k, j, nmax: integer;
   x,z,x1,max: real;

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
     nmax := 0;
     max := -1E308;
     for i := 1 to k do
     if (b[i] >= max) and (b[i] > x) and (b[i] < z) then
        begin
        max := b[i];
        nmax := i;
        end;
     if nmax = 0 then
        writeln('Нет максимума')
     else
         begin
         writeln('max = ', max:10:3);
         writeln('nmax = ', nmax);
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
         writeln('Задание 3');
         writeln('Введите значение x1');
		     readln(x1);
		     for i := 1 to j do
			   if (d[i] <= x1) and (d[i] < 0) then
            begin
            a[i] :=0;
            writeln('элемент ',i,' не определен');
            end
            else
                if (d[i] <= x1) then
				        a[i] := (1/2)*sqrt(d[i])
        else
				    a[i] := d[i];
	       write('Массив А состоит из ', j,'элементов');
	       for i := 1 to j do
	       write(a[i]:10:3);
         end;

end.
