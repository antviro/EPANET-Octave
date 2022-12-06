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
## @deftypefn {Function File} {[@var{errorcode}] =} ENsetpatternvalue(@var{id},@var{period},@var{factor})
## Sets the multiplier factors of period  nt for a specific time pattern
## Outputs:
## @var{errorcode} can also be retrieved
## Inputs:
## @var{id} is the integer index of the pattern (it works vectorised aswell).
## @var{period} period within time pattern
## @var{factor} is the factor we want to set up
## @seealso{}
## @end deftypefn

function [errorcode] = ENsetpatternvalue(id,period,factor)
  if  length(id)==1,
    errorcode = ocENsetpatternvalue(id, period, factor);
  elseif length(id)>1,
    errorcode = arrayfun ("ocENsetpatternvalue",id, period, factor);   
  else   # all patterns change at that period
    id =1:ENgetcount(3);
    errorcode = arrayfun ("ocENsetpatternvalue",id,period , factor);
  endif
endfunction
