#include <stdio.h>

struct node
{	int info;
	node *left, *right;
};

//новый узел с числом p
node *newn(int p)
{
	node *uk = new node;
	uk->info = p;
	uk->left = uk->right = NULL;
	return(uk);
}

//присоединение нового узла c числом x к узлу p слева
void setleft(node *p, int x)
{	p->left=newn(x);
}

//присоединение нового узла c числом x к узлу p справа
void setright(node *p, int x)
{	p->right=newn(x);
}

node *form()
{	int n;
	node *der = NULL, *next, *tek;
	printf("Input integer numbers\nletter means that input is over");
	if (scanf("%d",&n)==1)
	{	der = newn(n);
		while (scanf("%d",&n)==1)
		{	next = tek = der;
			while (next!=NULL)
			{	tek = next;
				if (n<tek->info)
					next = tek->left;
				else
					next = tek->right;
			}
			if(n<tek->info) 
				setleft(tek,n);
			else
				setright(tek,n);
		}
	}
	return der;
}

//вывод дерева на экран
void print_tree(node *der, int h)
{	if(der)
	{	print_tree(der->left, h+1);
		for(int i=0; i<h; i++) 
			printf(" ");
		printf("%d\r\n",der->info);
		print_tree(der->right, h+1);
	}
}

int summary(node *der)
{
    if (der == NULL) return 0;
    if (der != NULL)
    {
        if (der->info%2==1)
            return (summary(der->right) + summary(der->left) + der->info);
        else
            return (summary(der->right) + summary(der->left));
    }

}

int main()
{node *der;
printf("Building tree\n");
der = form();
if (!der)
	printf("Tree is empty");
else
{	print_tree(der, 0);
	printf("Sum of tree's odd elements = %d", summary(der));
}
return 0;
}