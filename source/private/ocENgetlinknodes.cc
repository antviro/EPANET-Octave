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

// mkoctfile ocENgetlinknodes.cc -L. -lepanet -I.
// Usage:  tipo =ocENgetlinknodes(3) 


DEFUN_DLD (ocENgetlinknodes, args, , "Calls ENgetlinknodes Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
int index = args(0).int16_array_value().xelem(0,0);
int fromnode;
int tonode;

int errorcode = ENgetlinknodes(index, &fromnode, &tonode);

  // Assign output arguments to retval      
retval(0) = fromnode;
retval(1) = tonode;
retval(2) = errorcode;
// EN_JUNCTION 0 Junction node
// EN_RESERVOIR 1 Reservoir node
// EN_TANK 2 Tank node



//retval(2) = linknodes; // looking for errors
//retval(3) = args(0).char_array_value().ndims();
return retval;

    
}
