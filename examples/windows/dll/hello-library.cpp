#include <stdio.h>
#include <time.h>
#include <windows.h>

#include "examples/windows/dll/hello-library.h"
#include "examples/windows/dll/some_library/some_library.h"

DLLEXPORT char *get_time() {
  time_t ltime;
  time(&ltime);
  return ctime(&ltime);
}

DLLEXPORT void say_hello(char *message) {
  printf("Hello from dll!\n%s", message);

  say_something(message);
}
