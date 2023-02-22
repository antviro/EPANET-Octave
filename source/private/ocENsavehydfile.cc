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

// mkoctfile ocENsavehydfile.cc -L. -lepanet -I.
// e.g.   ENsavehydfile("prueba.bin");

DEFUN_DLD (ocENsavehydfile, args, , "Calls ENsavehydfile Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
charNDArray  file1 = args(0).char_array_value();
  // Convert into C strings
const char * f1 = file1.data();
//
int errorcode = ENsavehydfile(const_cast<char*>(f1));

  // Assign output arguments to retval      
retval(0) = errorcode;
retval(1) = f1;
return retval;

    
}
