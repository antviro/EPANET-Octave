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

// mkoctfile ocENsolveQ.cc -L. -lepanet -I.
// Usage: ocENsolveQ()
//    ENsolve();

DEFUN_DLD (ocENsolveQ, , , "Calls ENsolveQ Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
  // Call EN routine like in C
int errorcode = ENsolveQ( );

  // Assign output arguments to retval      
retval(0) = errorcode;
return retval;

    
}
