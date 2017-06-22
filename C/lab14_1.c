#include <stdio.h>
#include <string.h>
#include <cstdlib> //для atoi
#include <ctype.h> //для isdigit

void proverka(int *prov)
{int k;
char sprov[20],*s;
    do
    {k=0; //количество цифр
    gets(sprov); //ввод строки
    s=sprov; //указатель на строку
    while(*s) //пока существует символ
        {if (isdigit(*s)) //если это цифра, счетчик увеличивается
            k++;
        s++;}//идем дальше
    if (k!=strlen(sprov)) //если количество цифр не равно длине строки
        printf("Enter positive integer\r\n");
    }
    while (k!=strlen(sprov)); //пока количество цифр не равно длине строки вводим строку снова и снова
    *prov=atoi(sprov); //вышли из цикла, ввод верен, привели строку к типу int
}

int F(int n);
int Q(int n);

int main (){
	int n;
	do
	{	
		printf("\r\nEnter natural n: \r\n");
		proverka(&n);
	}
	while (n<1);
	printf("F(%d) = %d\r\n",n,F(n));
	printf("Q(%d) = %d\r\n",n,Q(n));
	return 0;
}

int F(int n){
	int sum;
	if (n==1) 
		return (1);
	else
	{
		sum = F(n-1) + 2*Q(n-1);
		return(sum);
	}
}

int Q(int n){
	int sum;
	if (n==1) 
		return (1);
	else
	{	
		sum = (-2)*F(n-1)+Q(n-1);
		return(sum);
	}

}