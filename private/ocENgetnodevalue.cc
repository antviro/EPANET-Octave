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

// mkoctfile ocENgetnodevalue.cc -L. -lepanet -I.
// Usage: [value, coderror] = ocENgetnodevalue(10, 11);
//    ENopen();

DEFUN_DLD (ocENgetnodevalue,args , , "Calls ENopenH Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
int index = args(0).int16_array_value().xelem(0,0);
int paramcode = args(1).int16_array_value().xelem(0,0);
// EN_ELEVATION 0 Elevation
// EN_BASEDEMAND 1 Base demand
// EN_PATTERN 2 Demand pattern index
// EN_EMITTER 3 Emitter coeff.
// EN_INITQUAL 4 Initial quality
// EN_SOURCEQUAL 5 Source quality
// EN_SOURCEPAT 6 Source pattern index
// EN_SOURCETYPE 7 Source type(See note below)
// EN_TANKLEVEL 8 Initial water level in tank
// EN_DEMAND 9 Actual demand
// EN_HEAD 10 Hydraulic head
// EN_PRESSURE 11 Pressure
// EN_QUALITY 12 Actual quality
// EN_SOURCEMASS 13 Mass flow rate per minute of a chemical source


float value;
  // Call EN routine like in C
int errorcode = ENgetnodevalue(index, paramcode, &value );

  // Assign output arguments to retval      
retval(1) = errorcode;
retval(0) = value; // INVERTIR EN run y next
retval(2) = index;
retval(3) = paramcode;
retval(4) = &value;
return retval;

    
}
