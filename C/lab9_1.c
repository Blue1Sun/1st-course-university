/*Даны два одномерных массива целых чисел A и В. 
Вычислить одномерный массив С, который содержит:
Нечетные элементы массива A, присутствующие в массиве B. 
Все элементы массива C должны быть различными.

При решении задачи 1 составляется две программы. 
Алгоритмы этих программ аналогичны. В первой программе 
для форматного ввода и вывода данных используются функции 
scanf и printf , а для обращения к элементам массива - 
индексы. Во второй программе используются функции потокового 
ввода-вывода cin и cout, а для обращения к элементам 
массива используется указатель.  */
#include <stdio.h>
using namespace std; 


int main (){
	short a[10],b[10],c[10],na,nb,i,nc=0,j;
	float rwr;
	//////////ввод массива А
	printf("Happy valentine's day!\r\n");
	printf("Enter element's number of massive A\r\n");
	do
	{printf("Enter positive number>0 and <11\r\n");
	scanf("%f",&rwr);}
	while (rwr<=0||rwr>10||rwr!=(int)rwr); //проверка длины массива
	na=(int)rwr;
	printf("Enter its %d elements\r\n",na);
	for (i=0;i<na;i++)
		{do
		{scanf("%f",&rwr);
		if(rwr!=(int)rwr)
			printf("Enter integer element!\r\n"); //проверка целочисленности элементов
		}
		while (rwr!=(int)rwr);
		a[i]=(short)rwr; //приведение к типу short 
		}
	////////ввод массива B
	printf("Enter element's number of massive B\r\n");
	do
	{printf("Enter positive number>0 and <11\r\n");
	scanf("%f",&rwr);}
	while (rwr<=0||rwr>10||rwr!=(int)rwr); //проверка длины массива
	nb=(int)rwr;
	printf("Enter its %d elements\r\n",nb);
	for (i=0;i<nb;i++)
		{do
		{scanf("%f",&rwr);
		if (rwr!=(int)rwr)
			printf("Enter integer element!\r\n"); //проверка целочисленности элементов
		}
		while (rwr!=(int)rwr);
		b[i]=(short)rwr;//приведение к типу short 
		}
	//////////Вывод массивов
	printf("Massive A:\r\n");
	for (i=0;i<na;i++)
		printf("%6d",a[i]);
	printf("\r\n");
	printf("Massive B:\r\n");
	for (i=0;i<nb;i++)
		printf("%6d",b[i]);
	printf("\r\n");
	/*////////вычисление 
	Нечетные элементы массива A, присутствующие в массиве B. 
	Все элементы массива C должны быть различными.*/
	for (i=0;i<na;i++) //идем по массиву A
		if (a[i]%2!=0) //если нечетный элемент в A
		{for (j=0;j<nb&&a[i]!=b[j];j++); //проверяем присутствие его в B
			if (j<nb) //если присутствует в B, т.е. если цикл закончился раньше
				{for (j=0;j<nc&&a[i]!=c[j];j++); //проверяем отсутствие в С
					if (j==nc) //если нет повторов в C, т.е. если цикл дошел до конца
					{nc++; //увеличиваем длину C
					c[nc]=a[i]; //записываем
					}
				}
		}
	/////////Вывод вычислений
	if (nc==0) //пустой массив
		printf("Empty massive C\r\n"); 
	else
	{printf("Massive C:\r\n");
	for (i=0;i<nc;i++)
		printf("%6d",c[i]);
	printf("\r\n");
	}
	return 0;
}

