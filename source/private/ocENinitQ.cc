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

// mkoctfile ocENinitQ.cc -L. -lepanet -I.
// Usage: ocENinitQ(0)
//    ENopen();

DEFUN_DLD (ocENinitQ,args , , "Calls ENopenH Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
int flag = args(0).int16_array_value().xelem(0,0);

  // Call EN routine like in C
int errorcode = ENinitQ(flag );

  // Assign output arguments to retval      
retval(0) = errorcode;
retval(1) = flag;
return retval;

    
}
