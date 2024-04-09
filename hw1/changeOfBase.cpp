WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
#include <iostream>
#include <string>
#include <ctype.h>
using namespace std;

int main(void)
{ 
  string str, newStr;
  int value = 0, base, newbase, num;
  
  cout <<"Please enter the number's base: ";
  cin >> base;
  cout << "Please enter the number: ";
  cin >> str;
  cout << "Please enter the new base: ";
  cin >> newbase;
  
  for(string::const_iterator itr = str.begin(); itr != str.end(); itr++)
  {
    value *= base;
    if(isdigit(*itr))
      value += *itr - '0';
    else
      value += toupper(*itr) - 'A' + 10;
  }
  cout << str << " base " << base << " is ";

    while(value > 0){
      num = value % newbase;
      if(num < 10)
          newStr.insert(newStr.begin(), (char)('0' + num));
        else
          newStr.insert(newStr.begin(), (char) ('A' + num - 10));
      
      value /=newbase;
    }
 
  cout << newStr << " base " << newbase << endl ;

  return 0;
}

