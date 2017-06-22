#include <stdio.h>
#include <string.h>
#include <ctype.h> //для isdigit

using namespace std;
#define FCLR while (getc(fin)!='\n')
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

//замена в строке символа '\n' на '\0'
void deln(char *s)
{ for (; *s && *s!='\n'; s++);
    *s='\0';
}


//ввод
void read(int *kol, car cat[], char *filename)
{FILE *fin;
car *ucar;
*kol=0;
if (!(fin=fopen(filename, "r")))
        printf("File %s does not exist\n",filename);
    else
    {
        //во входном файле нет пустых строк и каждый пункт занимает новую строку
        for (ucar=cat; !feof(fin); (*kol)++, ucar++)
            if(fgets(ucar->firm,20,fin))
            {
                deln(ucar->firm);
                fscanf(fin,"%d", &(ucar->mod.seriya));
                fscanf(fin,"%d", &(ucar->mod.number));
                fscanf(fin,"%d", &(ucar->price));
                fscanf(fin,"%d", &(ucar->dat.year));
                fscanf(fin,"%d", &(ucar->dat.month));
                if (!feof(fin)) FCLR;
                fgets(ucar->color, 20, fin);
                deln(ucar->color);
                fscanf(fin,"%d", &(ucar->engine));
                //Очистка входного потока
                if (!feof(fin)) FCLR;
            }
        fclose(fin);
    }
}


//Модели, у которых имеется максимальное количество различных объемов двигателя.
void search(car cat[], int kol, int mod[], int *n1)
{car *iukaz,*jukaz;
    int i,c,diff=0,max=0;
    *n1=-1;//изначально нет моделей
    if (kol==1)
    {*n1=0;
     mod[*n1]=0;
    }
    else
    {for(iukaz=cat;iukaz<cat+kol-1;iukaz++)//высчитываем максимум разных обьемов
        {diff=0;
        for (jukaz=cat;jukaz<cat+kol;jukaz++)
            {if (iukaz->mod.seriya==jukaz->mod.seriya&&iukaz->mod.number==jukaz->mod.number)//если одна модель
                if (iukaz->engine!=jukaz->engine)//если у них разные двигатели
                    diff++;//учитываем эту разность
            }
        if (diff>max) max=diff; //вычисляем максимум
        }
    for(iukaz=cat,i=0;iukaz<cat+kol;iukaz++,i++) //находим какие модели имеют этот максимум
        {diff=0;
        for (jukaz=iukaz;jukaz<cat+kol;jukaz++)
            {if (iukaz->mod.seriya==jukaz->mod.seriya&&iukaz->mod.number==jukaz->mod.number)
                if (iukaz->engine!=jukaz->engine)
                    diff++;
            }
        if (diff==max)//если нашли модель, запоминаем ее
            {*n1=*n1+1;
             mod[*n1]=i;}
        }
    }
}


//вывод в файл
void print(int n1, int mod[], car cat[], char *filename)
{int c,i;
FILE *fout;
    fout=fopen(filename, "w");
    fprintf(fout,"Models with max amount of different engine capacity:\r\n");
    for(i=0;i<n1+1;i++)
        {c=mod[i];
        if (cat[c].mod.seriya!=cat[c-1].mod.seriya||i==0)
            {fprintf(fout,"Model...Series.....%d\r\n",cat[c].mod.seriya);
            fprintf(fout,"Model...Number.....%d\r\n\r\n",cat[c].mod.number);
            }
        }
    fclose(fout);
}

int main (){
    int kol,n1;
    car catalog[200];
    int models[20];
    FILE *fout;

    read(&kol,catalog,"input.txt");
    search(catalog, kol, models, &n1);
    if(n1!=-1)
        print(n1, models,catalog,"output.txt");
    else
        {fout=fopen("output.txt", "w");
        fprintf(fout,"No needed cars were found");
        }
    return 0;
}
