#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//очистка входной строки
#define CLR while (getchar()!='\n')
#define FCLR while (getc(f)!='\n')

//структура студентов,стек
struct Students{
    struct
    {
        char name[80], surname[80], patronymic[80];
    } info;
    int group;
    struct
    {
        unsigned int B[5];
        float mark;
    } achieve;
    Students *next;
};

//замена в строке символа '\n' на '\0'
void deln(char *s)
{	for (; *s && *s!='\n'; s++);
	*s='\0';
}

//считывание из файла в стек
Students *Add (FILE *f)
{char s[80];
Students *stack = NULL;
float sum;
	while(!(feof(f)))
	{	sum=0;
	    Students *uk = new Students;//выделение памяти
	    uk->next = stack;
	    stack = uk;
	    fgets(s,80,f);//строка Student 1:
	    fgets(uk->info.surname,80,f); //Фамилия
	    deln(uk->info.surname);
	    fgets(uk->info.name,80,f);//Имя
	    deln(uk->info.name);
	    fgets(uk->info.patronymic,80,f);//отчество
	    deln(uk->info.patronymic);
	    fscanf(f,"%d", &(uk->group));//группа
	    if (!feof(f))
	        FCLR;
	    for(int i = 0; i<5; i++) //считывание оценок
	    {	
	    	fscanf(f,"%d", &(uk->achieve.B[i]));
	        sum += uk->achieve.B[i];
	    }
	    uk->achieve.mark = sum/5;//средняя оценка
	    if (!feof(f))
	        FCLR;
	}
	return (stack);
}

//вывод в файл
void Print(Students *catalog, char *filename)
{FILE *fl;
int k = 1;
    fl = fopen(filename,"w");
    fputs("STUDENTS:\r\n",fl);
    while(catalog!=NULL)
    {	fprintf(fl, "\r\nStudent %d:\r\n", k++);
        fprintf(fl, "FIO:   "); fprintf(fl, "%s   ", catalog->info.surname); fprintf(fl, "%s   ", catalog->info.name); fprintf(fl, "%s\n", catalog->info.patronymic);
        fprintf(fl, "Group:   "); fprintf(fl, "%d   \r\n", catalog->group);
        fprintf(fl, "Marks:   ");
        for(int i = 0; i<5; i++)
            fprintf(fl, "%d   ", catalog->achieve.B[i]);
        fprintf(fl, "\r\nAverage Mark:   "); fprintf(fl, "%.1f   \r\n", catalog->achieve.mark);
        catalog = catalog->next;
    }
    fclose(fl);
}

//получение от пользователя новой записи
Students* getStudent()
{char readingString[80];
int readingInt;
float sum;
    Students *newStudent = new Students;
    printf("Enter surname:\r\n");
    scanf("%s",&readingString);
    strcpy(newStudent->info.surname,readingString);
    printf("Enter name:\r\n");
    scanf("%s",&readingString);
    strcpy(newStudent->info.name,readingString);
    printf("Enter patronymic:\r\n");
    scanf("%s",&readingString);
    strcpy(newStudent->info.patronymic,readingString);
    printf("Enter group:\r\n");
    scanf("%d",&readingInt);
    newStudent->group = readingInt;
    for (int i=0; i<5;i++)
    {   
    	printf("Enter mark#%d:\r\n",i);
        scanf("%d",&readingInt);
        newStudent->achieve.B[i] = readingInt;
        sum += newStudent->achieve.B[i];
    }
    newStudent->achieve.mark = sum/5;
	return (newStudent);
}

//копирование данных из одной структуры в другую
void copyStudent(Students *source, Students *dest)
{	strcpy(source->info.surname,dest->info.surname);
	strcpy(source->info.name,dest->info.name);
	strcpy(source->info.patronymic,dest->info.patronymic);
	source->group=dest->group;
	for (int i = 0; i<5; i++)
		source->achieve.B[i]=dest->achieve.B[i];
	source->achieve.mark=dest->achieve.mark;
}

/*вставить новую запись, задаваемую пользователем,
перед каждой записью с данными о студенте из указанной группы*/
Students* changes(Students *catalog, int group)
{Students *uk = new Students;
Students *addedStudent = getStudent();
uk=catalog;
    while (uk)
    {
        if (uk->group == group) //проверка на группу
        {
            Students *newStudent = new Students;
            copyStudent(newStudent, addedStudent);
            newStudent->next = uk->next;
            uk->next = newStudent;
            uk = uk->next;
        }
        uk = uk->next;
    }
	return (catalog);
}


int main()
{Students *catalog = NULL;
FILE *f;
char filename[20];
int group;
printf("Input file name: \r\n");
gets(filename);
if (!(f = fopen(filename,"r")))
    {puts("File not found");
    exit(1);
    }
catalog = Add(f);
fclose(f);
Print(catalog, "output1.txt");
printf("\r\nEnter group:\r\n");
scanf("%d",&group);
catalog = changes(catalog, group);
Print(catalog, "output2.txt");
return 0;
}
