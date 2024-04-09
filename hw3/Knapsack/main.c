WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
#include <stdio.h>
#include <stdlib.h>

unsigned int max(unsigned int a, unsigned int b){
  //computes the max of a and b
  return a > b ? a : b;
}

unsigned int knapsack(int* weights, unsigned int* values, unsigned int num_items, 
              int capacity, unsigned int cur_value){
  /*
  solves the knapsack problem
  @weights: an array containing how much each item weighs
  @values: an array containing the value of each item
  @num_items: how many items that we have
  @capacity: the maximum amount of weight that can be carried
  @cur_weight: the current weight
  @cur_value: the current value of the items in the pack
  */
  unsigned int i;
  unsigned int best_value = cur_value;
  
  for(i = 0; i < num_items; i++){//for each remaining item
    if(capacity - weights[i] >= 0 ){//if we can fit this item into our pack
      //see if it will give us a better combination of items
      best_value = max(best_value, knapsack(weights + i + 1, values + i + 1, num_items - i - 1, 
                     capacity - weights[i], cur_value + values[i]));
    }//if we can fit this item into our pack   
  }//try to find the best combination of items among the remaining items
  return best_value;


}//knapsack

void readFile(const char* file_name, int** weights, unsigned int** values, unsigned int* num_items, int* capacity){
	/*
		File is strucured as:
		capacity
		num_items
		weight1 value1
		weight2 value2
		weight3 value3
		...
	*/
	FILE* fptr;
	unsigned int i;
	
	fptr = fopen(file_name, "r");
	
	
	fscanf(fptr,"%d", capacity); //read capacity
	fscanf(fptr,"%d", num_items); //read capacity
	
	//make space 
	*weights = (int*) malloc(*num_items * sizeof(int));
	*values = (unsigned int*) malloc(*num_items * sizeof(unsigned int));
	
	//read weights and values
	for(i = 0; i < *num_items; i++){
		fscanf(fptr, "%d", *weights + i);
		fscanf(fptr, "%u", *values + i);
	}
	
	//close file
	fclose(fptr);

}


int main(int argc, char **argv){
  int* weights;
  unsigned int* values;
  unsigned int num_items;
  int capacity;
  unsigned int max_value;

  
  if(argc == 2){
  	//readFile
  	readFile(argv[1], &weights, &values, &num_items, &capacity);
  	
  	//find the max that we can carry
  	max_value = knapsack(weights, values, num_items, capacity, 0);
  	printf("%u\n", max_value); //display result
  	
  	//free space malloced
  	free(weights);
  	free(values);
  } else{
  	printf("Usage: knapsack.out arg_file\n");
  }

  return 0;
  
 }//main
              
