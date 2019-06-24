#ifndef SOME_LIBRARY_H
#define SOME_LIBRARY_H

#ifdef COMPILING_DLL
#define SOME_DLLEXPORT __declspec(dllexport)
#else
#define SOME_DLLEXPORT __declspec(dllimport)
#endif

extern "C" SOME_DLLEXPORT char *get_time();
extern "C" SOME_DLLEXPORT void say_something(char *);

#endif

