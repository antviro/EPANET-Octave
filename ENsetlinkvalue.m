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
## @deftypefn {Function File} {[@var{errorcode}] =} ENsetlinkvalue(@var{id},@var{param},@var{value})
## Sets the value in a link@.@*
## Outputs:@*
## @var{errorcode} can also be retrieved@.@*
## Inputs:@*
## @var{id} is the integer index of the link (can be a vector/matrix). If no link is specified all links value are retrieved e.g. ENsetlinkvalue ([],10)@.@*
## @var{param} is the parameter to be measured it can be a string or an integer:@*
## EN_DIAMETER 0@*
## EN_LENGTH 1@*
## EN_ROUGHNESS 2 @*
## EN_MINORLOSS 3 minor loss coef@*
## EN_INITSTATUS 4 initial link status (0= closed, 1=open)@*
## EN_INITSETTING 5 initial pipe roughness, pump speed or valve setting@*
## EN_KBULK 6 bulk reaction coef.@*
## EN_KWALL 7 wall reaction coef.@*
## EN_STATUS 11 current link status (0= closed, 1=open)@*
## EN_SETTING 12 roughness, pump speed or valve setting@*
## @var{value} is the values we want to set it should have the same size of id (if id is empty then it should be a vector with one value for each link.
## @seealso{ENsetlinkid, ENsetlinkvalue, ENsetlinkvalue}
## @end deftypefn

function [errorcode] = ENsetlinkvalue(id,param,value)
  if ischar(param),
    param=toupper(param);
    switch param,
      case "EN_DIAMETER"
        paramcode = 0;
      case "EN_LENGTH" 
        paramcode =  1;
      case "EN_ROUGHNESS"
        paramcode =  2;
      case "EN_MINORLOSS"
        paramcode =  3; # Emitter coeff.
      case "EN_INITSTATUS"
        paramcode =  4; # Initial quality
      case "EN_INITSETTING"
        paramcode =  5; # Source quality
      case "EN_KBULK"
        paramcode =  6;#Source pattern index
      case "EN_KWALL"
        paramcode =  7;# Source type
      case "EN_STATUS"
        paramcode =  11;# Pressure
      case "EN_SETTING"
        paramcode =  12;# Actual quality
    otherwise
        error("El texto introducido no se corresponde con ninguna propiedad de nodo")
    endswitch
  else
    paramcode = param;
  endif
  if  length(id)==1,
    errorcode = ocENsetlinkvalue(id, paramcode,value);
  elseif length(id)>1,
    errorcode = arrayfun ("ocENsetlinkvalue",id,paramcode,value); 
  else   # all links retrieved
    id =1:ENgetcount(2);
    errorcode = arrayfun ("ocENsetlinkvalue",id,paramcode,value);
  endif
endfunction
