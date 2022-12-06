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

// mkoctfile ocENgetlinkid.cc -L. -lepanet -I.
// Usage:  s =ocENgetlinkid(3) SI NO SE PASA POR CADENA INTERMEDIA METE UN CARACTER ADICIONAL


DEFUN_DLD (ocENgetlinkid, args, , "Calls ENgetlinkid Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
int index = args(0).int16_array_value().xelem(0,0);
char *pid;
char id[15]; //it should be initialized doc.
  // Call EN routine like in C
pid = id;
int errorcode = ENgetlinkid(index, pid);

  // Assign output arguments to retval      
retval(1) = errorcode;
retval(0) = id;
return retval;

    
}
