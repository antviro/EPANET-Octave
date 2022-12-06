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

// mkoctfile ocENgetlinkvalue.cc -L. -lepanet -I.
// Usage: [value, coderror] = ocENgetlinkvalue(10, 11);
//    ENopen();

DEFUN_DLD (ocENgetlinkvalue,args , , "Calls ENopenH Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
int index = args(0).int16_array_value().xelem(0,0);
int paramcode = args(1).int16_array_value().xelem(0,0);


float value;
  // Call EN routine like in C
int errorcode = ENgetlinkvalue(index, paramcode, &value );

  // Assign output arguments to retval      
retval(1) = errorcode;
retval(0) = value; // INVERTIR EN run y next
retval(2) = index;
retval(3) = paramcode;
retval(4) = &value;
return retval;

    
}
