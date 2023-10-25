#include "../inc/ft_malloc.h"
#include <stdio.h>

int main() {
  size_t size = 20;
  char* ptr = (char*)malloc(sizeof(char) * size + 1);
  for (size_t i = 0; i < size; ++i) {
    ptr[i] = 'a';
  }
  ptr[size] = 0;
  printf("%s\n", ptr);

  realloc(ptr, 50);
  printf("%s\n", ptr);

  free(ptr);

  return 0;
}
