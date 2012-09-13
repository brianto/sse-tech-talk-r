#include <stdio.h>

void fibonacci(int *indexin, int *result) {
  int index = indexin[0];
  
  if (index < 2) {
    result[0] = 1;
  }

  int fib_mem[] = {1, 1};
  
  for (int i = 2; i <= index; ++i) {
    int next = fib_mem[0] + fib_mem[1];
    
    fib_mem[0] = fib_mem[1];
    fib_mem[1] = next;
  }
      
  result[0] = fib_mem[1];
}