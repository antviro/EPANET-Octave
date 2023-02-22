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
## @deftypefn {Function File} {[@var{errorcode}] =} ENsetpattern(@var{id},@var{factors})
## Sets all of the multiplier factors for a specific time pattern
## Outputs:
## @var{errorcode} can also be retrieved
## Inputs:
## @var{id} is the integer index of the pattern (not vectorised). 
## @var{factors} is a vector with the factors we want to set up
## @seealso{}
## @end deftypefn

function [errorcode] = ENsetpattern(id,factors)
  if  length(id)==1,
    errorcode = ocENsetpattern(id, factors);
  ## elseif length(id)>1,
  ##   errorcode = arrayfun ("ocENsetpattern",id,paramcode,value); 
  else   # all nodes retrieved
    ## id =1:ENgetcount(0);
    ## errorcode = arrayfun ("ocENsetpattern",id,paramcode,value);
    error('vectorizacion no implementada aun en esta funcion')
  endif
endfunction
