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

// mkoctfile ocENsetstatusreport.cc -L. -lepanet -I.

DEFUN_DLD (ocENsetstatusreport,args , , "Calls ENsetstatusreport Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
int statuslevel = args(0).int16_array_value().xelem(0,0);
// 0 - no status reporting
// 1 - normal reporting
// 2 - full status reporting
int errorcode = ENsetstatusreport( statuslevel);

  // Assign output arguments to retval      
retval(0) = errorcode;
return retval;

    
}
