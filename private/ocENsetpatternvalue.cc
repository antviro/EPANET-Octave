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

// mkoctfile ocENsetpatternvalue.cc -L. -lepanet -I.
// Usage:  


DEFUN_DLD (ocENsetpatternvalue, args, , "Calls ENsetpatternvalue Epanet")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
int index = args(0).int16_array_value().xelem(0,0);
int period = args(0).int16_array_value().xelem(0,0);
float factor = (float) args(1).array_value().xelem(0,0);

int errorcode = ENsetpatternvalue(index, period, factor);

// Assign output arguments to retval      
//retval(1) = errorcode;
retval(0) = errorcode;
//retval(1) = factors[nfactors-1];
return retval;   
}
