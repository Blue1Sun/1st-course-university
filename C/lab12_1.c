#include <stdio.h>
#include <string.h>
#include <cstdlib> //для atoi
#include <ctype.h> //для isdigit

using namespace std;
#define CLR while (getchar()!='\n')
//очистка входной строки

//вложенная структура (1)
struct model
{
int seriya,number;
};

//вложенная структура (2)
struct date
{
int year, month;
};

struct car
{model mod; //вложенная структура (1)
date dat; //вложенная структура (2)
char firm[20], color[20];
int price, engine;
};

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

//ввод
void read(int *kol, car cat[])
{*kol=0;
int i,prov;
    do
        {printf("Enter number of cars\r\n");
        scanf("%d",kol);
        if (*kol<0||*kol>200)
            printf("Wrong number, please repeat\r\n");
        }
    while(*kol<0||*kol>200);
    CLR;
    while (i<*kol)
        {printf("\r\nCar %d\r\n",++i);
        printf("Firm........");
        while (*gets(cat->firm)==NULL);
        printf("Model...Series.....");
        proverka(&prov);
        cat->mod.seriya=prov;
        printf("Model...Number.....");
        proverka(&prov);
        cat->mod.number=prov;
        printf("Price........");
        do
            {proverka(&prov);
            if (prov==0) 
                printf("Enter positive integer\r\n");}
        while (prov<=0);
        cat->price=prov;
        printf("Release date...Year.....");
        do
            {proverka(&prov);
            if (prov>2016||prov<1769) 
                printf("Repeat enter 1768<year<2017\r\n");}
        while (prov>2016||prov<1769);
        cat->dat.year=prov;
        printf("Release date...Month.....");
        do
            {proverka(&prov);
            if (prov<1||prov>12) 
                printf("Repeat enter 0<month<13\r\n");}
        while (prov<1||prov>12);
        cat->dat.month=prov;
        printf("Color........");
        while (*gets(cat->color)==NULL);
        printf("Engine capacity........");
        proverka(&prov);
        cat->engine=prov;
        cat++;}
}


//Модели, у которых имеется максимальное количество различных объемов двигателя.
void search(car cat[], int kol, int mod[], int *n1)
{
    int i,j,diff=0,max=0;
    *n1=-1;//изначально нет моделей
    if (kol==1)
    {*n1=0;
     mod[*n1]=0;
    }
    else
    {for(i=0;i<kol-1;i++)//высчитываем максимум разных обьемов
        {diff=0;
        for (j=1;j<kol;j++)
            {if (cat[i].mod.seriya==cat[j].mod.seriya&&cat[i].mod.number==cat[j].mod.number)//если одна модель
                if (cat[i].engine!=cat[j].engine)//если у них разные двигатели
                    diff++;//учитываем эту разность
            }
        if (diff>max) max=diff; //вычисляем максимум
        }
    for(i=0;i<kol;i++) //находим какие модели имеют этот максимум
        {diff=0;
        for (j=i+1;j<kol;j++)
            {if (cat[i].mod.seriya==cat[j].mod.seriya&&cat[i].mod.number==cat[j].mod.number)
                if (cat[i].engine!=cat[j].engine)
                    diff++;
            }
        if (diff==max)//если нашли модель, запоминаем ее
            {*n1=*n1+1;
             mod[*n1]=i;}
        }
    }
}

//вывод
void print(int n1, int mod[], car cat[])
{int c,i;
    for(i=0;i<n1+1;i++)
        {c=mod[i];
        if (cat[c].mod.seriya!=cat[c-1].mod.seriya||i==0)
            {printf("Model...Series.....%d\r\n",cat[c].mod.seriya);
            printf("Model...Number.....%d\r\n\r\n",cat[c].mod.number);
            }
        }
}

int main (){
    int kol,n1;
    car catalog[200];
    int models[20];

    read(&kol,catalog);//ввод
    search(catalog, kol, models, &n1);//поиск
    if(n1!=-1) //если модели найдены
        {printf("\r\nModels with max amount of different engine capacity:");
        print(n1, models,catalog);//вывод на экран
        }
    else
        puts("No needed cars were found");
    return 0;
}
