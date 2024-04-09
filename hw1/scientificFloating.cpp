WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
#include <iostream>
#include <math.h>
#include<cstdlib>
using namespace std;

void getMantissa(unsigned int float_int)
{
   unsigned int *mantissa = new unsigned int[23];
  
   for (int i = 22; i >= 0; i--)
      mantissa[(22 - i)] = ((float_int >> i)&1);
  
   for (int i = 0; i <= 22; i++)  
   {
      if (mantissa[i] == 0)
      {
        int count = 0;
        for (int j = i; j <= 22; j++)
          if ( mantissa[j] == 1)
            count++;
        if (count == 0) 
         mantissa[i] = 2;
      }
  }
  int count = 0;
  for(int i = 0; i <= 22; i++)
      if(mantissa[i] == 2)
          count++;
  if(count != 23)
  {
    cout << ".";
    for(int i = 0; i <= 22; i++)
    { 
      if(mantissa[i] <= 1) 
         cout << mantissa[i];
    }
  }
}
void getSign(unsigned int num)
{
  unsigned int sign;
  sign = num >> 31;

  if(sign != 1)
    sign += 1;
  else
    cout << "-";
 
  cout << sign;
}

unsigned int getExp(unsigned int num)
{
 int exp = num & 0x7f800000;

  exp >>= 23;
 
  if(exp > 0)
    exp -= 127;
  else
    exp += 127;
  return exp;
}

int main(void)
{
  float num; 
  cout << "Please enter a float: ";
  cin >> num;
  
  if(num == 0)
  {
    cout << "0E0\n";
    exit(0);
  }

  unsigned int float_int = *((unsigned int *)&num);
  
  int exp = getExp(float_int);
 
  getSign(float_int);

  getMantissa(float_int);
  

  cout << "E" << exp << endl;
  return 0;
}
