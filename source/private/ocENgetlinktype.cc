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

// mkoctfile ocENgetlinktype.cc -L. -lepanet -I.
// Usage:  tipo =ocENgetlinktype(3) 


DEFUN_DLD (ocENgetlinktype, args, , "Calls ENgetlinktype Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
int index = args(0).int16_array_value().xelem(0,0);
int typecode;
//EN_CVPIPE
// EN_PIPE
// EN_PUMP
// EN_PRV
// EN_PSV
// EN_PBV
// EN_FCV
// EN_TCV
// EN_GPV
// 0
// 1
// 2
// 3
// 4
// 5
// 6
// 7
// 8
// Pipe with Check Valve
// Pipe
// Pump
// Pressure Reducing Valve
// Pressure Sustaining Valve
// Pressure Breaker Valve
// Flow Control Valve
// Throttle Control Valve
// General Purpose Valve

int errorcode = ENgetlinktype(index, &typecode);

  // Assign output arguments to retval      
retval(0) = typecode;
retval(1) = errorcode;
// EN_JUNCTION 0 Junction node
// EN_RESERVOIR 1 Reservoir node
// EN_TANK 2 Tank node



//retval(2) = linktype; // looking for errors
//retval(3) = args(0).char_array_value().ndims();
return retval;

    
}
