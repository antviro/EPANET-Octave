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
## @deftypefn {Function File} {@var{errormessage},@var{newerrorcode} =} ENgeterror(@var{errorcode})
## Runs a step of hydraulic simulation.
## @var{errormessage} is the corresponding message(s) of error
## Outputs:
## @var{errorcode} is the number of the error   we want to know
## It can be run vectorized where errormessage would be a string cell array
## @var{newerrorcode} can also be retrieved
## @seealso{ENgeterror, ENgetnodevalue, ENsetnodevalue}
## @end deftypefn

function [errormessage ,errorcode] = ENgeterror(errorcode)
  if  length(errorcode)==1,
    [errormessage, errorcode] = ocENgeterror(errorcode);
  elseif length(errorcode)>1,
    [errormessage, errorcode] = cellfun ("ocENgeterror",errorcode);
  else #index =[]
    errormessage=[];
    errorcode=0;
  endif
endfunction
