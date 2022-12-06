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
## @deftypefn {Function File} {[@var{len},@var{errorcode}] =} ENgetpatternlen(@var{id})
## Gets the number of time periods in a specific time pattern.
## It can be run vectorized where nodeid would be a string cell array, whereas index and errorcode are returned as arrays nodeid ={"n1","n5"} --> index and errorcode would be 1x2 arrays
## Outputs:
## @var{len} is the length we wanteed to obtain
## @var{errorcode} can also be retrieved
## Inputs:
## @var{id} is the integer index of the pattern (can be a vector/matrix). If no node is specified all nodes length are retrieved e.g. ENgetpatternlen ([],10)
## @seealso{ENgetnodeid, ENgetpatternlen, ENsetpatternlen}
## @end deftypefn

function [len, errorcode] = ENgetpatternlen(id)
  if  length(id)==1,
    [len,errorcode] = ocENgetpatternlen(id);
  elseif length(id)>1,
    [len,errorcode] = arrayfun ("ocENgetpatternlen",id);
  else   # all nodes retrieved
    id =1:ENgetcount(3);
    [len,errorcode] = arrayfun ("ocENgetpatternlen",id);
  endif
endfunction
