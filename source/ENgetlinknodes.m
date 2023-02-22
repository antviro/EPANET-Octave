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
## @deftypefn {Function File} {@var{fromnode},@var{tonode},@var{errorcode} =} ENgetlinknodes(@var{id})
## Get nodes around each link
## Outputs:
## @var{fromnode} is the node at start of link
## @var{tonode} is the node at end of link
## @var{errorcode} can also be retrieved
## Inputs:
## @var{id} is the integer index of the link (can be a vector) if id is   empty [] all link nodes are retrieved [from,to]=ENgetlinknodes([])
## @seealso{ENgetlinkid}
## @end deftypefn

function [fromnode, tonode , errorcode] = ENgetlinknodes(id)
  if  length(id)==1,
    [fromnode, tonode ,errorcode] = ocENgetlinknodes(id);
  elseif length(id)>1,
    [fromnode, tonode ,errorcode]  = arrayfun ("ocENgetlinknodes",id);
  else # all links retrieved
    id =1:ENgetcount(2);
    [fromnode, tonode ,errorcode]  = arrayfun ("ocENgetlinknodes",id);
  endif
endfunction
