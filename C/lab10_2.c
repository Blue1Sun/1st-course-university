/*В заданной целочисленной прямоугольной матрице поменять местами следующие два элемента:
Первый положительный и последний четный.\
Обращение к элементам матрицы происходит по указателю 
Ввод данных, вывод результата и вычисления оформляются как три отдельных функции.*/
#include <stdio.h>
using namespace std; 

////ВВОД
void vvod (short a[][10],short *n,short *m){
	short i,*uj;
	float rowr;
	printf("Please, enter size of NxM matrix, 0<N<11, 0<M<11\r\n");
	do
	{
		scanf("%f",&rowr);
		if (rowr!=(short)rowr||rowr<=0||rowr>10)
			printf("Enter integer number 0<N<11\r\n");
	}
	while (rowr!=(short)rowr||rowr<=0||rowr>10); //проверка
	*n=(short)rowr;
	do
	{
		scanf("%f",&rowr);
		if (rowr!=(short)rowr||rowr<=0||rowr>10)
			printf("Enter integer number 0<M<11\r\n");
	}
	while (rowr!=(short)rowr||rowr<=0||rowr>10); //проверка
	*m=(short)rowr;
	printf("Enter integer element of matrix %dx%d\r\n",*n,*m);	
	for (i=0;i<*n;i++)
		for (uj=a[i];uj<a[i]+*m;uj++)
			{do
				{scanf("%f",&rowr);
				if(rowr!=(short)rowr)
					printf("Print integer element!\r\n");
				}
			while(rowr!=(short)rowr); //проверка
			*uj=(short)rowr;
			}
}

////ВЫВОД
void vivod (short a[][10],short n,short m){
	short i,*uj;
	for (i=0;i<n;i++) //строки
		{for (uj=a[i];uj<a[i]+m;uj++)
			printf("%4d",*uj);
		printf("\r\n");
		}
}

////ВЫЧИСЛЕНИЯ
void count (short a[][10],short n,short m, short **u1, short **u2){
	short i,*j;
	*u1=*u2=NULL;
	for (i=0;i<n;i++)
		for (j=a[i];j<a[i]+m&&*u1==NULL;j++) //идем по циклу пока не нашли первый
			if (*j>0) //нашли первый положительный
				*u1=j;
	for (i=0;i<n;i++)
		for (j=a[i];j<a[i]+m;j++)
			if (!(*j%2)) //нашли последний четный
				*u2=j;	
}

////ПЕРЕСТАНОВКА
void perest (short *u1, short *u2){
	short c;
	c=*u1;
	*u1=*u2;
	*u2=c;
}	

////ГЛАВНАЯ ПРОГРАММА
int main (){
	short a[10][10],n,m,*u1,*u2;
	printf("\r\nHello, my dear friend!\r\n");
	vvod(a,&n,&m);
	printf("Your martix:\r\n");
	vivod(a,n,m);
	count(a,n,m,&u1,&u2);
	if(u1&&u2&&*u1!=*u2) //если указатели существуют и это не одно и то же число
		{perest(u1,u2);
		printf("Your new martix:\r\n");
		vivod(a,n,m);
		}
	if (u1==NULL)
		printf("Positive element NOT FOUND\r\n");
	else
		if (u2==NULL)
		printf("Even element NOT FOUND\r\n");
		else
			if (*u1==*u2)
			printf("First positive element = last even element\r\n");	
	return 0;
}