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

// mkoctfile ocENsetlinkvalue.cc -L. -lepanet -I.
// Usage: coderror = ocENsetlinkvalue(10, 11);clear ocENsetlinkvalue;
//    ENopen();

DEFUN_DLD (ocENsetlinkvalue,args , , "Calls ENopenH Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
int index = args(0).int16_array_value().xelem(0,0);
int paramcode = args(1).int16_array_value().xelem(0,0);
// EN_DIAMETER
// EN_LENGTH
// EN_ROUGHNESS
// EN_MINORLOSS
// EN_INITSTATUS
// EN_INITSETTING
// 0
// 1
// 2
// 3
// 4
// 5
// EN_KBULK
//  6
// Diameter
// Length
// Roughness coeff.
// Minor loss coeff.
// Initial link status
// (0 = closed, 1 = open)
// Pipe roughness
// Initial pump speed
// Initial valve setting
// Bulk reaction coeff.
// ...
float value = (float) args(2).row_vector_value().elem(0);
//RowVector	row_vector_value
  // Call EN routine like in C
int errorcode = ENsetlinkvalue(index, paramcode, value );

  // Assign output arguments to retval      
retval(0) = errorcode;
retval(1) = value; 
retval(2) = index;
retval(3) = paramcode;
retval(4) = value;
return retval;

    
}
