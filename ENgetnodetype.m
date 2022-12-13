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
## @deftypefn {Function File} {@var{typecode},@var{errorcode},@var{stype} =} ENgetnodevalue(@var{id})
## Runs a step of hydraulic simulation.
## Outputs:
## @var{typecode} is the code of the type of node
## @var{errorcode} can also be retrieved
## @var{stype} is a string describing type of node
## Inputs:
## @var{id} is the integer index of the node (can be a vector) or it can be [] and then all nodes are retrieved.
## @seealso{ENgetnodeid, ENgetnodevalue, ENsetnodevalue}
## @end deftypefn

function [typecode, errorcode, stype] = ENgetnodetype(id)
  if  length(id)==1,
    [typecode,errorcode] = ocENgetnodetype(id);
  elseif length(id)>1,
    [typecode,errorcode] = arrayfun ("ocENgetnodetype",id);
  else  # all nodes retrieved
    id =1:ENgetcount(0);
    [typecode,errorcode] = arrayfun ("ocENgetnodetype",id);
  endif
  if nargout>2, #  not vectorised because no interest in obtaining this when seeking for speed
                #    stype = cell(size(typecode));
    stype = arrayfun("nodetypecode", typecode,"UniformOutput", false);
  endif 
endfunction
