## Copyright (C) 2015 Antonio Vigueras Rodríguez <avigueras.rodriguez@upct.es>
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {@var{errorcode} =} ENepanet (@var{fileinp}, @var{filereport}, @var{filebin})
## Epanets the Epanet Toolkit (with ENepanet.c).  @var{fileinp} EPANET input file (inp). Compulsory argument.
##  @var{filereport} output report file (in case used), if not given inp file name is used changing its extension with rpt instead
## @var{filebin} binary output file (in case used), if not given inp file name is used changing its extension with bin instead.
## @seealso{}
## @end deftypefn

function errorcode = ENepanet(fileinp, filereport, filebin)
  switch nargin,
    case 0
      error('No files specified')
    case 1
      fileinp = ruta_absoluta_file(fileinp);
      filereport = fileinp;
      filereport(end-2:end)='rpt';
      filebin = fileinp;
      filebin(end-2:end)='bin';
      if check_file_inp(fileinp),
        errorcode = ocENepanet(fileinp, filereport, filebin);
      else
        error('file not found')
      endif 
    case 2
      fileinp = ruta_absoluta_file(fileinp);
      filereport = ruta_absoluta_file(filereport);
      filebin = fileinp;
      filebin(end-2:end)='bin';
      if check_file_inp(fileinp),
        errorcode = ocENepanet(fileinp, filereport, filebin);
      else
        error('file not found')
      endif 

    case 3
      fileinp = ruta_absoluta_file(fileinp);
      filereport = ruta_absoluta_file(filereport);
      filebin = ruta_absoluta_file(filebin);
      if check_file_inp(fileinp),
        errorcode = ocENepanet(fileinp, filereport, filebin);
      else
        error('file not found')
      endif 


  endswitch

  function located_file = check_file_inp (fileinp)
    located_file = length(dir(fileinp));
  endfunction 

  function file = ruta_absoluta_file(f1)
    if f1(1)=='/',
      file = f1;
    elseif f1(1)=='~',
      error('introduce rutas relativas o absolutas sin emplear el caracter ~')
    else
      file = strcat(pwd,'/',f1);
    endif
  endfunction
endfunction
