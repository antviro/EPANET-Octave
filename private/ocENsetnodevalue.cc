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

// mkoctfile ocENsetnodevalue.cc -L. -lepanet -I.
// Usage: coderror = ocENsetnodevalue(10, 11);clear ocENsetnodevalue;
//    ENopen();

DEFUN_DLD (ocENsetnodevalue,args , , "Calls ENopenH Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
int index = args(0).int16_array_value().xelem(0,0);
int paramcode = args(1).int16_array_value().xelem(0,0);
// EN_ELEVATION
// EN_BASEDEMAND
// EN_PATTERN
// EN_EMITTER
// EN_INITQUAL
// EN_SOURCEQUAL
// EN_SOURCEPAT
// EN_SOURCETYPE
// EN_TANKLEVEL
// 0
// 1
// 2
// 3
// 4
// 5
// 6
// 7
// 8
// Elevation
// Baseline demand
// Time pattern index
// Emitter coefficient
// Initial quality
// Source quality
// Source pattern
// Source type (See note below)
// Initial water level in tank
float value = (float) args(2).row_vector_value().elem(0);
//RowVector	row_vector_value
  // Call EN routine like in C
int errorcode = ENsetnodevalue(index, paramcode, value );

  // Assign output arguments to retval      
retval(0) = errorcode;
retval(1) = value; 
retval(2) = index;
retval(3) = paramcode;
retval(4) = value;
return retval;

    
}
