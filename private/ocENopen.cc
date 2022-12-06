#include <octave/oct.h>
#include <iostream>
#ifdef __cplusplus
extern "C"
{
#endif
#include "epanet2.h"
#ifdef __cplusplus
}  /* end extern "C" */
#endif                                        \

// mkoctfile ocENopen.cc -L. -lepanet -I.
// Usage: ocENopen(strcat(pwd,"/","redMoratalla.inp") ,strcat(pwd,"/","prueba.rpt") ,strcat(pwd,"/","prueba.bin"))
//    ENopen("redMoratalla.inp","prueba.rpt","");

DEFUN_DLD (ocENopen, args, , "Calls ENopen Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
charNDArray  file1 = args(0).char_array_value();
charNDArray  file2 = args(1).char_array_value();
charNDArray  file3 = args(2).char_array_value();
  // Convert into C strings
const char * f1 = file1.data();
const char * f2 = file2.data();
//if (file3.ndims()>0)
//{
const char * f3 = file3.data();
//}
//octave_stdout <<  file1;
//octave_stdout << "\n";

// .c_str()? parece solo aplicables a row de char matrix...
//std::cout << f1 <<'\n';
  // Call NAG routine like in C
int errorcode = ENopen(const_cast<char*>(f1), const_cast<char*>(f2), const_cast<char*>(f3));

  // Assign output arguments to retval      
retval(0) = errorcode;
retval(1) = f1;
return retval;

    
}
