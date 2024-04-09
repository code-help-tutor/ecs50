WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
#include<stdio.h>

int main(void)
{
	int n1, n2;
	scanf("%d %d", &n1, &n2);

	int i = 0;
	printf("%d %d\n", n1, n2);
	for(i = 0; i <= 31; i++)
	{
		n2 <<= 1;
		printf("%d", n2);
		if(n2 > n1)
		{
			i--;
			break;
		}
		else if(n2 == n1)
			break;
		else
			continue;
	}

	printf("%d R %d\n", i, n2 - n1);
}