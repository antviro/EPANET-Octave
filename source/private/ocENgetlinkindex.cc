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

// mkoctfile ocENgetlinkindex.cc -L. -lepanet -I.
// Usage: s="n1"; in =ocENgetlinkindex(s) SI NO SE PASA POR CADENA INTERMEDIA METE UN CARACTER ADICIONAL


DEFUN_DLD (ocENgetlinkindex, args, , "Calls ENgetlinkindex Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
const char * linkid = args(0).char_array_value().data();
int index;

  // Call EN routine like in C
int errorcode = ENgetlinkindex(const_cast<char*>(linkid), &index);

  // Assign output arguments to retval      
retval(1) = errorcode;
retval(0) = index;
//retval(2) = linkid; // looking for errors
//retval(3) = args(0).char_array_value().ndims();
return retval;

    
}
