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

// mkoctfile ocENgetpatternlen.cc -L. -lepanet -I.



DEFUN_DLD (ocENgetpatternlen, args, , "Calls ENgetpatternlen Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
int index = args(0).int16_array_value().xelem(0,0);
int length;

  // Call EN routine like in C
int errorcode = ENgetpatternlen(index , &length);

  // Assign output arguments to retval      
retval(1) = errorcode;
retval(0) = length;
//retval(2) = patternid; // looking for errors
//retval(3) = args(0).char_array_value().ndims();
return retval;

    
}
