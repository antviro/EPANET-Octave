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
## @deftypefn {Function File} {[@var{value},@var{errorcode}] =} ENgetnodevalue(@var{id},@var{param})
## Gets the value in a node@.@*
## It can be run vectorized where nodeid would be a string cell array, whereas index and errorcode are returned as arrays nodeid =@{"n1","n5"@} --> index and errorcode would be 1x2 arrays@.@*
## Outputs:@*
## @var{value} is the value we wanteed to obtain@.@*
## @var{errorcode} can also be retrieved@.@*
## Inputs:@*
## @var{id} is the integer index of the node (can be a vector/matrix). If no node is specified all nodes value are retrieved e.g. ENgetnodevalue ([],10)@.@*
## @var{param} is the parameter to be measured it can be a string or an integer:@*
## "EN_ELEVATION" 0@*                               
## "EN_BASEDEMAND" 1@*                               
## "EN_PATTERN" 2     @*                             
## "EN_EMITTER" 3 # Emitter coeff.                  @*
## "EN_INITQUAL" 4 # Initial quality                 @*
## "EN_SOURCEQUAL" 5 # Source quality               @*
## "EN_SOURCEPAT" 6#Source pattern index              @*     
## "EN_SOURCETYPE" 7# Source type                 @*
## "EN_TANKLEVEL" 8 # Initial water level in tank   @*     
## "EN_DEMAND" 9# Actual demand                   @*
## "EN_HEAD"10# Hydraulic head              @*
## "EN_PRESSURE"11# Pressure                  @*
## "EN_QUALITY"12# Actual quality               @*      
## "EN_SOURCEMASS"13# Mass flow rate per minute of a chemical source       @*
## "EN_CONCEN" 0@*
## "EN_MASS" 1@*
## "EN_SETPOINT" 2@*
## "EN_FLOWPACED" 3@*
## @seealso{ENgetnodeid, ENgetnodevalue, ENsetnodevalue}
## @end deftypefn

function [value, errorcode] = ENgetnodevalue(id,param)
  if ischar(param),
    param=toupper(param);
    switch param,
      case "EN_ELEVATION"
        paramcode = 0;
      case "EN_BASEDEMAND"
        paramcode =  1;
      case "EN_PATTERN"
        paramcode =  2;
      case "EN_EMITTER"
        paramcode =  3; # Emitter coeff.
      case "EN_INITQUAL"
        paramcode =  4; # Initial quality
      case "EN_SOURCEQUAL"
        paramcode =  5; # Source quality
      case "EN_SOURCEPAT"
        paramcode =  6;#Source pattern index
      case "EN_SOURCETYPE"
        paramcode =  7;# Source type
      case "EN_TANKLEVEL"
        paramcode =  8;# Initial water level in tank
      case "EN_DEMAND"
        paramcode =  9;# Actual demand
      case "EN_HEAD"
        paramcode =  10;# Hydraulic head
      case "EN_PRESSURE"
        paramcode =  11;# Pressure
      case "EN_QUALITY"
        paramcode =  12;# Actual quality
      case "EN_SOURCEMASS"
        paramcode =  13;# Mass flow rate per minute of a chemical source
      case "EN_CONCEN"
        paramcode = 0;
      case "EN_MASS"
        paramcode = 1;
      case "EN_SETPOINT"
        paramcode = 2;
      case "EN_FLOWPACED"
        paramcode = 3;
      otherwise
        error("El texto introducido no se corresponde con ninguna propiedad de nodo")
    endswitch
  else
    paramcode = param;
  endif
  if  length(id)==1,
    [value,errorcode] = ocENgetnodevalue(id, paramcode);
  elseif length(id)>1,
    [value,errorcode] = arrayfun ("ocENgetnodevalue",id,paramcode);
  else   # all nodes retrieved
    id =1:ENgetcount(0);
    [value,errorcode] = arrayfun ("ocENgetnodevalue",id,paramcode);
  endif
endfunction
