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

// mkoctfile ocENresetreport.cc -L. -lepanet -I.
// Usage:  


DEFUN_DLD (ocENresetreport, , , "Calls ENresetreport Epanet")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;

int errorcode = ENresetreport( );

// Assign output arguments to retval      
//retval(1) = errorcode;
retval(0) = errorcode;
//retval(1) = factors[nfactors-1];
return retval;   
}
