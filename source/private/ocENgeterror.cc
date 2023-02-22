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

// mkoctfile ocENgeterror.cc -L. -lepanet -I.



DEFUN_DLD (ocENgeterror, args, , "Calls ENgeterror Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
int errorcode = args(0).int16_array_value().xelem(0,0);
char *perrormessage;
char errormessage[120]; //it should be initialized doc.
  // Call EN routine like in C
perrormessage = errormessage;
errorcode = ENgeterror(errorcode, perrormessage, 120);

  // Assign output arguments to retval      
retval(1) = errorcode;
retval(0) = errormessage;
return retval;

    
}
