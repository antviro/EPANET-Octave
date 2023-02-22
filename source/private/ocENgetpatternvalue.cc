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

// mkoctfile ocENgetpatternvalue.cc -L. -lepanet -I.



DEFUN_DLD (ocENgetpatternvalue, args, , "Calls ENgetpatternvalue Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
int index = args(0).int16_array_value().xelem(0,0);
int period = args(1).int16_array_value().xelem(0,0);

float value;

// Call EN routine like in C
int errorcode = ENgetpatternvalue(index , period, &value);

// Assign output arguments to retval      
retval(1) = errorcode;
retval(0) = value;
//retval(2) = patternid; // looking for errors
//retval(3) = args(0).char_array_value().ndims();
return retval;

    
}
