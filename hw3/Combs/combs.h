WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
#ifndef COMBS_H
  #define COMBS_H
  int max(int a, int b);
  int min(int a, int b);

  int num_combs(int n, int k);
  void recursion(int k, int cols,int len,int* current,int* items,int* row, int** matrix);
  int** get_combs(int* items, int k, int len);
#endif
