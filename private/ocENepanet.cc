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

// mkoctfile ocENepanet.cc -L. -lepanet -I.
// Usage: ocENepanet(strcat(pwd,"/","redMoratalla.inp") ,strcat(pwd,"/","prueba.rpt") ,strcat(pwd,"/","prueba.bin"))
//    ENepanet("redMoratalla.inp","prueba.rpt","");

// void writecon (char *s)
//         {
//             puts(s);
//         }

DEFUN_DLD (ocENepanet, args, , "Calls Epanet (ENepanet), performing a complete simulation")
{
    octave_value_list retval;
    // Retrieve input arguments from args
    //%  std::string
    //    char * f1 = args(0).c_str;
    charNDArray  file1 = args(0).char_array_value();
    charNDArray  file2 = args(1).char_array_value();
    charNDArray  file3 = args(2).char_array_value();
    // int printprogress = args(3).int16_array_value().xelem(0,0);
    int errorcode;
    // Convert into C strings
    const char * f1 = file1.data();
    const char * f2 = file2.data();
    //if (file3.ndims()>0)
    //{
    const char * f3 = file3.data();
    //}

    // if (printprogress == 0) {
    //             void (* vfunc) (char *s);
    //     vfunc = writecon;
    //     errorcode =  ENepanet(const_cast<char*>(f1), const_cast<char*>(f2), const_cast<char*>(f3), vfunc);
    // }
    // else {
    errorcode = ENepanet(const_cast<char*>(f1), const_cast<char*>(f2), const_cast<char*>(f3),NULL);
    // }
    // Assign output arguments to retval      
    retval(0) = errorcode;
    return retval;
  
}
