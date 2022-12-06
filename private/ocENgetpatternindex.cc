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

// mkoctfile ocENgetpatternindex.cc -L. -lepanet -I.



DEFUN_DLD (ocENgetpatternindex, args, , "Calls ENgetpatternindex Epanet, returns an error code")
{
octave_value_list retval;
  // Retrieve input arguments from args
//%  std::string
//    char * f1 = args(0).c_str;
const char * patternid = args(0).char_array_value().data();
int index;

  // Call EN routine like in C
int errorcode = ENgetpatternindex(const_cast<char*>(patternid), &index);

  // Assign output arguments to retval      
retval(1) = errorcode;
retval(0) = index;
//retval(2) = patternid; // looking for errors
//retval(3) = args(0).char_array_value().ndims();
return retval;

    
}
