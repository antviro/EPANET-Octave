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

// mkoctfile ocENnextH.cc -L. -lepanet -I.
// Usage: [tstep, coderr] = ocENnextH()
//    ENopen();

DEFUN_DLD (ocENnextH,args , , "Calls ENopenH Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//long t = args(0).int32_array_value().xelem(0,0);
long tstep;
  // Call EN routine like in C
int errorcode = ENnextH(&tstep );

  // Assign output arguments to retval      
retval(1) = errorcode;
retval(0) = tstep; // COMPROBAR
return retval;

    
}
