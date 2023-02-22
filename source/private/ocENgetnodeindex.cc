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

// mkoctfile ocENgetnodeindex.cc -L. -lepanet -I.
// Usage: s="n1"; in =ocENgetnodeindex(s) SI NO SE PASA POR CADENA INTERMEDIA METE UN CARACTER ADICIONAL


DEFUN_DLD (ocENgetnodeindex, args, , "Calls ENgetnodeindex Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
const char * nodeid = args(0).char_array_value().data();
int index;

  // Call EN routine like in C
int errorcode = ENgetnodeindex(const_cast<char*>(nodeid), &index);

  // Assign output arguments to retval      
retval(1) = errorcode;
retval(0) = index;
//retval(2) = nodeid; // looking for errors
//retval(3) = args(0).char_array_value().ndims();
return retval;

    
}
