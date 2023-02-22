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

// mkoctfile ocENgetcount.cc -L. -lepanet -I.
// Usage: [count, coderror] = ocENgetcount(0)
//    ENopen();

DEFUN_DLD (ocENgetcount,args , , "Calls ENopenH Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
int countcode = args(0).int16_array_value().xelem(0,0);
// EN_NODECOUNT  0  Nodes
// EN_TANKCOUNT 1  Reservoirs and tank nodes
// EN_LINKCOUNT 2 Links
// EN_PATCOUNT 3 Time patterns
// EN_CURVECOUNT 4 Curves
// EN_CONTROLCOUNT 5 Simple controls


int count;
  // Call EN routine like in C
int errorcode = ENgetcount(countcode, &count );

  // Assign output arguments to retval      
retval(1) = errorcode;
retval(0) = count; // INVERTIR EN run y next
return retval;

    
}
