#include <stdio.h>
#include <time.h>
#include <windows.h>

#include "examples/windows/dll/some_library/some_library.h"

SOME_DLLEXPORT char *get_time() {
  time_t ltime;
  time(&ltime);
  return ctime(&ltime);
}

SOME_DLLEXPORT void say_something(char *message) {
  printf("Hello from some_library!\n%s", message);
}

