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
## @deftypefn {Function File} {@var{number},@var{errorcode} =} ENgetcount(@var{countcode})
## Counts the number of network components of a specified type
## @var{countcode} is a string or a number with the  specified type
## It can be run vectorized introducing countcode as a vector (or matrix) of numbers
## Outputs:
## @var{number} is the number we wanted to obtain
## @var{errorcode} can also be retrieved
## EN_NODECOUNT 0
## EN_TANKCOUNT 1 reservoirs and tank nodes
## EN_LINKCOUNT 2
## EN_PATCOUNT 3 time patterns
## EN_CURVECOUNT 4 curves
## EN_CONTROLCOUNT 5
## @seealso{ }
## @end deftypefn

function [number, errorcode] = ENgetcount(countcode)
  if ischar(countcode),
    countcode=toupper(countcode);
    switch countcode,
      case "EN_NODECOUNT"
        countcode = 0;
      case "EN_TANKCOUNT"
        countcode = 1;
      case "EN_LINKCOUNT"
        countcode = 2;
      case "EN_PATCOUNT"
        countcode = 3;
      case "EN_CURVECOUNT"
        countcode = 4;
      case "EN_CONTROLCOUNT"
        countcode = 5;
      otherwise
        error("El texto introducido no se corresponde con ninguna propiedad de nodo")
    endswitch

    [number,errorcode] = ocENgetcount(countcode);
    
  else
    if  length(countcode)==1,
      [number,errorcode] = ocENgetcount(countcode);
    elseif length(countcode)>1,
      [number,errorcode] = arrayfun ("ocENgetcount",countcode);
    else
      number=[];
      errorcode=[];
    endif
  endif
endfunction
