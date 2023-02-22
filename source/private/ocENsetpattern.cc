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

// mkoctfile ocENsetpattern.cc -L. -lepanet -I.
// Usage:  


DEFUN_DLD (ocENsetpattern, args, , "Calls ENsetpattern Epanet")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
int index = args(0).int16_array_value().xelem(0,0);

int nrow   = (int) args(1).array_value().dim1();
int ncolumns = (int) args(1).array_value().dim2();
int nfactors  = ( nrow > ncolumns ? nrow : ncolumns);
int byrow =( nrow > ncolumns ? 1: 0);
float factors[nfactors];
int i;
for ( i=0; i<nfactors; i++)
{
    factors[i] = (float) args(1).array_value().xelem(i * byrow,i * (1-byrow));
}
// char *pid;
// char id[15]; //it should be initialized doc.
//   // Call EN routine like in C
// pid = id;
int errorcode = ENsetpattern(index, factors, nfactors);

  // Assign output arguments to retval      
//retval(1) = errorcode;
retval(0) = errorcode;
//retval(1) = factors[nfactors-1];
return retval;

    
}
