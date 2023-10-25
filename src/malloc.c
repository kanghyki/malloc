#include "../inc/implementation/ft_malloc_imp.h"

void* malloc(size_t size) {
  (void)size;
//  void* ptr = mmap(0, getpagesize() * 2, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
//  int ret = munmap(pre_alloc, getpagesize() * 2);

  return NULL;
}
