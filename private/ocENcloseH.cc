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

// mkoctfile ocENcloseH.cc -L. -lepanet -I.
// Usage: ocENcloseH()
//    ENclose();

DEFUN_DLD (ocENcloseH, , , "Calls ENcloseH Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
  // Call EN routine like in C
int errorcode = ENcloseH( );

  // Assign output arguments to retval      
retval(0) = errorcode;
return retval;

    
}
