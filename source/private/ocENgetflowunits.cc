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

// mkoctfile ocENgetflowunits.cc -L. -lepanet -I.

DEFUN_DLD (ocENgetflowunits, , , "Calls ENopenH Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
int flowunits;
  // Call EN routine like in C
int errorcode = ENgetflowunits(&flowunits );
// 0
// 1
// 2
// 3
// 4
// 5
// 6
// 7
// 8
// 9
// ==========EN_CFS
// EN_GPM
// EN_MGD
// EN_IMGD
// EN_AFD
// EN_LPS
// EN_LPM
// EN_MLD
// EN_CMH
// EN_CMD
// cubic feet per second
// gallons per minute
// million gallons per day
// Imperial mgd
// acre-feet per day
// liters per second
// liters per minute
// million liters per day
// cubic meters per hour
// cubic meters per day

  // Assign output arguments to retval      
retval(1) = errorcode;
retval(0) = flowunits; // INVERTIR EN run y next
return retval;

    
}
