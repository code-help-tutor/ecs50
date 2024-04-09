WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
#include "MyFloat.h"

MyFloat::MyFloat(){
  sign = 0;
  exponent = 0;
  mantissa = 0;
}

MyFloat::MyFloat(float f){
  unpackFloat(f);
}

MyFloat::MyFloat(const MyFloat & r){
	sign = r.sign;
	exponent = r.exponent;
	mantissa = r.mantissa;
}

ostream& operator<<(std::ostream &strm, const MyFloat &f){
	//this function is complete. No need to modify it.
	strm << f.packFloat();
	return strm;
}


MyFloat MyFloat::operator+(const MyFloat& r) const{
	MyFloat Obj = MyFloat(*this);
	MyFloat copyr(r);
	
	Obj.mantissa |= (1 << 23);
	copyr.mantissa |= (1 << 23);

	Obj.mantissa <<= 1;
	copyr.mantissa <<= 1;
	
	Obj.exponent--;
	copyr.exponent--;

	while(Obj.exponent != copyr.exponent)
	{
		if(Obj.exponent > copyr.exponent)
		{
			copyr.exponent++;
			copyr.mantissa >>= 1;
		}
		else
		{
			Obj.exponent++;
			Obj.mantissa >>= 1;
		}
	}

	if(Obj.sign != copyr.sign)
	{
		if(Obj.mantissa > copyr.mantissa)
			Obj.mantissa = Obj.mantissa - copyr.mantissa;
		else
		{
			Obj.mantissa = copyr.mantissa - Obj.mantissa;
			Obj.sign = copyr.sign;
		}
	}
	else
		Obj.mantissa += copyr.mantissa;
	

	if(Obj.mantissa == 0)
	{
		Obj.exponent = 0;
		Obj.sign = 0;
		return Obj;
	}

	while(1)
	{
		if(Obj.mantissa >= 0x1000000)
		{
			Obj.mantissa >>= 1;
			Obj.exponent++;	
		}

		if(Obj.mantissa < (1 << 23))
		{
			Obj.mantissa <<=1;
			Obj.exponent--;
		}

		if(Obj.mantissa >= (1 << 23) && Obj.mantissa < 0x1000000)
		{	
			Obj.mantissa -= (1 << 23);
			break;
		}
	}
	
	return Obj;
}

MyFloat MyFloat::operator-(const MyFloat& r) const{
	MyFloat copyr = MyFloat(r);

	if(copyr.sign == 1)
		copyr.sign = 0;
	else
		copyr.sign = 1;

	
	return *this + copyr; //you don't have to return *this. it's just here right now so it will compile
}

bool MyFloat::operator==(float f) const {
    return f == packFloat();
}

void MyFloat::unpackFloat(float f) {
        __asm__(
                "movl %%eax, %%ebx;"
                "shrl $31, %%eax;"
                "movl %%ebx, %%ecx;"
                "andl $0x7f800000, %%ebx;"
                "shrl $23, %%ebx;"
                "andl $0x007fffff, %%ecx":
                "=a" (sign),
                "=b" (exponent),
                "=c" (mantissa) :
                "d" (f) :
                "cc"
        );

}//unpackFloat

float MyFloat::packFloat() const{

  float f = 0;
          
 __asm__(
      "shl $31, %%eax;" 
      "shl $23, %%ebx;" 
      "orl %%eax, %%ebx;" 
      "orl %%ebx, %%ecx;" 
      "movl %%ecx, %%edx" 
     :"=d" (f):
     "a" (sign), 
     "b" (exponent), 
     "c" (mantissa):
     "cc"
    );
  return f;
}
