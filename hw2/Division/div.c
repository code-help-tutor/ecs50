WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{	
	int quotient = 0, remainder = 0;
	int count = 31;
	int dividend = atoi(argv[1]);
	int divisor = atoi(argv[2]);

	for(int i = count; i >=0; i--)
	{
		remainder <<= 1;
		remainder |= ((dividend >> i) & 1);
		
		if(remainder >= divisor)
		{	
			remainder -= divisor;
			quotient |= 1 << i;
		} 
	}
	

	//printf("%u R %u\n", cout , dividend);
	
	return 0;
}
