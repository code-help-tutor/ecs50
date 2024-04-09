WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
#include <iostream>
#include <fstream>
#include <stdio.h>
#include <cstdlib>
#include <sstream>
using namespace std;

int extractInteger(string str) 
{ 
    stringstream ss;     
  
    ss << str; 
  
    string temp; 
    int getNum, number = 0; 
    while (!ss.eof()) { 
 
        ss >> temp; 
  
        if (stringstream(temp) >> getNum) 
            number = getNum;
    } 
    return number;
} 

int Index(int row, int column, int N){

    int zeroNum = (row*(row +1) / 2); 
    return row * N + column - zeroNum;
}

int* readMatrix(char*filename)
{
	ifstream file;
	file.open(filename);
	
	string str;
	getline(file, str);

	int index = 0, i = 0;

	index = extractInteger(str);
	
	int ele = index * (index + 1) / 2;
	int *array = new int[ele];

	while(getline(file, str))
	{	
		int X = extractInteger(str);
		array[i] = X;
		i++;
	}

	file.close();

	return array;
}

int main(int argc, char*argv[])
{	
	ifstream file;
	file.open(argv[1]);
	
	string str;
	getline(file, str);

	int N = extractInteger(str);
	file.close();

	int *array1 = readMatrix(argv[1]);
	int *array2 = readMatrix(argv[2]);

	
	int ele = N * (N + 1) / 2;
	int sum[ele];
    for(int i = 0; i < ele; i ++){
        sum[i] = 0;
    }
   
    for(int i = 0; i < N; i++)
        for(int j = i; j < N; j++)
            for(int k = i; k <= j; k++)
                sum[Index(i,j,N)] += array1[Index(i, k, N)] * array2[Index(k, j, N)];
  
    for(int i = 0; i < ele; i++)
    	cout << sum[i] << " ";

    cout << endl;
	
	return 0;
}