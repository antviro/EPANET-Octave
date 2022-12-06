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

// mkoctfile ocENinitH.cc -L. -lepanet -I.
// Usage: ocENinitH(0)
//    ENopen();

DEFUN_DLD (ocENinitH,args , , "Calls ENopenH Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
int flag = args(0).int16_array_value().xelem(0,0);

  // Call EN routine like in C
int errorcode = ENinitH(flag );

  // Assign output arguments to retval      
retval(0) = errorcode;
retval(1) = flag;
return retval;

    
}
