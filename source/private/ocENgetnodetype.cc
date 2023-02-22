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

// mkoctfile ocENgetnodetype.cc -L. -lepanet -I.
// Usage:  tipo =ocENgetnodetype(3) 


DEFUN_DLD (ocENgetnodetype, args, , "Calls ENgetnodetype Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
int index = args(0).int16_array_value().xelem(0,0);
int typecode;
//
int errorcode = ENgetnodetype(index, &typecode);

  // Assign output arguments to retval      
retval(0) = typecode;
retval(1) = errorcode;
// EN_JUNCTION 0 Junction node
// EN_RESERVOIR 1 Reservoir node
// EN_TANK 2 Tank node



//retval(2) = nodetype; // looking for errors
//retval(3) = args(0).char_array_value().ndims();
return retval;

    
}
