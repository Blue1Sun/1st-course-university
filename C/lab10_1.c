/*В заданной целочисленной прямоугольной матрице поменять местами следующие два элемента:
Первый положительный и последний четный.\
Обращение к элементам матрицы происходит при помощи индекса. 
Все вычисления, ввод и вывод происходят в главной функции*/

#include <stdio.h>
using namespace std; 

int main (){
	short a[10][10], n, m, i, j, c, i1=-1, j1=-1, i2=-1, j2=-1;
	float rowr;
	printf("\r\nHello, my dear friend!\r\n");
	////ВВОД ДЛИНЫ
	printf("Please, enter size of NxM matrix, 0<N<11, 0<M<11\r\n");
	do
	{
		scanf("%f",&rowr);
		if (rowr!=(short)rowr||rowr<=0||rowr>10)
			printf("Enter integer number 0<N<11\r\n");
	}
	while (rowr!=(short)rowr||rowr<=0||rowr>10); //проверка
	n=(short)rowr;
	do
	{
		scanf("%f",&rowr);
		if (rowr!=(short)rowr||rowr<=0||rowr>10)
			printf("Enter integer number 0<M<11\r\n");
	}
	while (rowr!=(short)rowr||rowr<=0||rowr>10); //проверка
	m=(short)rowr;
	////ВВОД МАТРИЦЫ
	printf("Enter integer element of matrix %dx%d\r\n",n,m);	
	for (i=0;i<n;i++)
		for (j=0;j<m;j++)
			{do
				{scanf("%f",&rowr);
				if(rowr!=(short)rowr)
					printf("Print integer element!\r\n");
				}
			while(rowr!=(short)rowr); //проверка
			a[i][j]=(short)rowr;
			}
	////ВЫВОД МАТРИЦЫ
	printf("Your martix:\r\n");
	for (i=0;i<n;i++)
		{for (j=0;j<m;j++)
			printf("%4d",a[i][j]);
		printf("\r\n");
		}
	////ВЫЧИСЛЕНИЯ
	for (i=0;i<n;i++)
		for (j=0;j<m&&i1==-1;j++) //идем по циклу пока не нашли первый
			if(a[i][j]>0) //нашли первый положительный
				{i1=i;
				j1=j;
				}
	for (i=0;i<n;i++)
		for (j=0;j<m;j++)
			if(!(a[i][j]%2)) //нашли последний четный
			{i2=i;
			j2=j;
			} 
	if (i1!=-1&&i2!=-1) //если оба найдены производится перестановка
	{c=a[i1][j1];
	a[i1][j1]=a[i2][j2];
	a[i2][j2]=c;}
	////ВЫВОД МАТРИЦЫ
	if (i1<0)
		printf("Positive element NOT FOUND\r\n"); //положительный не найден
	if (i2<0)
		printf("Even element NOT FOUND\r\n"); //четный не найден
	if ((i1==i2&&j1==j2&&i1!=-1)||(a[i1][j1]==a[i2][j2]&&i1!=-1))
		printf("First positive element = last even element\r\n"); //первый положительный он же последний четный
	else
		if (i1!=-1&&i2!=-1)
	{	
	printf("Your new martix:\r\n");
	for (i=0;i<n;i++)
		{for (j=0;j<m;j++)
			printf("%4d",a[i][j]);
		printf("\r\n");
		}
	}
	return 0;
}