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
## @deftypefn {Function File} {@var{errorcode} =} ENsavehydfile (@var{filebin})
## Savehydfiles the Epanet Toolkit (with ENsavehydfile.c).  @var{filebin} EPANET  file. Compulsory argument.
## @seealso{ENclose}
## @end deftypefn

function errorcode = ENsavehydfile(filebin)
  switch nargin,
    case 0
      error('No files specified')
    case 1
      filebin = ruta_absoluta_file(filebin);
        #   if check_file_inp(file,
        errorcode = ocENsavehydfile(filebin);
        #      end
  endswitch


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
