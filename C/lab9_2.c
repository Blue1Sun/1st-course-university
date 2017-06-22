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
#include <iostream>
using namespace std; 

int main (){
	short a[10],b[10],c[10],nb,na,nc=0,*ua,*ub,*uc,i,j;
	float rwr;
	//////////ввод массива А
	cout <<"Happy valentine's day!"<<endl;
	cout<<"Enter element's number of massive A"<<endl;
	do
	{cout<<"Enter positive number>0 and <11"<<endl;
	cin>>rwr;}
	while (rwr<=0||rwr>10||rwr!=(int)rwr); //проверка длины массива
	na=(int)rwr;
	cout<<"Enter its "<<na<<" elements"<<endl;
	for (ua=a;ua<a+na;ua++)
		{do
		{cin>>rwr;
		if(rwr!=(int)rwr)
			cout<<"Enter integer element!"<<endl; //проверка целочисленности элементов
		}
		while (rwr!=(int)rwr);
		*ua=(short)rwr; //приведение к типу short
	}
	////////ввод массива B
	cout<<"Enter element's number of massive B"<<endl;
	do
	{cout<<"Enter positive number>0 and <11"<<endl;
	cin>>rwr;}
	while (rwr<=0||rwr>10||rwr!=(int)rwr); //проверка длины массива
	nb=(int)rwr;
	cout<<"Enter its "<<nb<<" elements"<<endl; //проверка целочисленности элементов
	for (ub=b;ub<b+nb;ub++)
		{do
		{cin>>rwr;
		if (rwr!=(int)rwr)
			cout<<"Enter integer element!"<<endl;
		}
		while (rwr!=(int)rwr);
		*ub=(short)rwr; //приведение к типу short
	}
	//////////Вывод массивов
	cout<<"Massive A:"<<endl;
	for (ua=a;ua<a+na;ua++)
		cout<<"  "<<*ua;
	cout<<""<<endl ;
	cout<<"Massive B:"<<endl;
	for (ub=b;ub<b+nb;ub++)
		cout<<"  "<<*ub;
	cout<<""<<endl ;
	/*////////вычисление 
	Нечетные элементы массива A, присутствующие в массиве B. 
	Все элементы массива C должны быть различными.*/
	for (ua=a;ua<a+na;ua++) //идем по массиву A
		if (*ua%2!=0) //если нечетный элемент в A
		{for (ub=b;ub<b+nb&&*ua!=*ub;ub++); //проверяем присутствие его в B
			if (ub<b+nb) //если присутствует в B, т.е. если цикл закончился раньше
				{for (uc=c;uc<c+nc&&*ua!=*uc;uc++); //проверяем отсутствие в С
					if (uc==c+nc) //если нет повторов в C, т.е. если цикл дошел до конца
					{nc++; //увеличиваем длину C
					*uc++=*ua; //записываем
					}
				}
		}
	/////////Вывод вычислений
	if (nc==0) //пустой массив
		cout<<"Empty massive C"<<endl;
	else
	{cout<<"Massive C:"<<endl;
	for (uc=c;uc<c+nc;uc++)
		cout<<"  "<<*uc;
	cout<<endl;
	}
	return 0;
}

