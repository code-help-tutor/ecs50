WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
#include <stdio.h>
#include <stdlib.h>
#include "combs.h"

void print_mat(int** mat, int num_rows, int num_cols);
void free_mat(int** mat, int num_rows, int num_cols);
//void recursion(int k, int cols,int len,int* current,int* items,int* row, int** matrix);

int max(int a, int b){
  return a > b ? a : b;
}

int min(int a, int b){
  return a < b ? a : b;
}

int num_combs(int n, int k){
  int combs = 1;
  int i;
  
  for(i = n; i > max(k, n-k); i--){
    combs *= i;
  }

  for(i = 2; i <= min(k, n - k); i++){
    combs /= i;
  }
  
  return combs;

}

void print_mat(int** mat, int num_rows, int num_cols){
  int i,j;
  
  for(i = 0; i < num_rows; i++){
    for( j = 0; j < num_cols; j++){
      printf("%d ", mat[i][j]); 
    }
    printf("\n");
  }
}

void free_mat(int** mat, int num_rows, int num_cols){
  int i;
  
  for(i = 0; i < num_rows; i++){
    free(mat[i]);
  }
  free(mat);
}

void recursion(int k, int cols,int len,int* current,int* items,int* row, int** matrix){
    if(k == 0)
    {
        for(int i = 0; i < cols; ++i)
            matrix[*row][i] = current[i];
        (*row)++;
    }
    else
        for(int i = 0; i < len; i++)
        {
            current[cols - k] = items[i];
            recursion(k - 1, cols, len - i - 1,current,items + i + 1,row,matrix);
        }
    
}

int** get_combs(int* items, int k, int len){
    int combs = num_combs(len, k);
    int** matrix = (int**)malloc(combs * sizeof(int*));
    int* current = (int*)malloc(k *sizeof(int));
    int row = 0;
    
    for(int i = 0; i < combs; ++i){
        matrix[i] = (int*)malloc(k * sizeof(int));
    }
    recurion(k,k,len,current,items,&row,matrix);
    return matrix;
}


int main(){
  int num_items;
  int* items; 
  int i,k;
  int** combs;
  printf("How many items do you have: ");
  scanf("%d", &num_items);
  
  items = (int*) malloc(num_items * sizeof(int));
  
  printf("Enter your items: ");
  for(i = 0; i < num_items; i++){
    scanf("%d", &items[i]);
  } 
  
  printf("Enter k: ");
  scanf("%d", &k);
  
  combs = get_combs(items, k, num_items);
  print_mat(combs,num_combs(num_items, k) ,k);
  free(items);
  free_mat(combs,num_combs(num_items, k), k);
  
  return 0;
}

