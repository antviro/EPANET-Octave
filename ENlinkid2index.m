## Copyright (C) 2016 Antonio Vigueras Rodríguez <avigueras.rodriguez@upct.es>
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
## @deftypefn {Function File} {@var{index} =} ENlinkid2index(@var{cellids}, @var{id})
## Get the ids of all the links parting from a cellarray of sortered index (obtained previously with ENgetlinkid([]), e.g. allLinks = ENgetlinkid([]); ENlinkid2index(allLinks,identificacionnodo). It also works with nodes, however a new function is suggested for nodes just
## for making code easier to read. It returns 0 when a id is not found.
## It can run with EPANET Toolkit closed
## @var{index} is an integer which is the index of the link
## Outputs:
## @var{id} is a string with the link identifier, it should be a string variable containing the string and not the string itself. No idea of why it cause problem the later...
## It can be run vectorized where id would be a string cell array, in case index is an array
## @seealso{ENgetlinkid, ENgetlinkvalue, ENsetlinkvalue}
## @end deftypefn

function [index] = ENlinkid2index(cellids, id)
  if  ~iscell(id),
    index = strmatch (id,cellids,"exact")
  else
    index=zeros(1,length(id));
    for i=1:length(id),
      locatedindex = strmatch (id{i},cellids,"exact");
      if length(locatedindex)==1,
        index(i) = locatedindex;
      else
        index(i) = 0;
#not found, 0 chosen instead of -999 to be coherent with other TK functions
      endif
    endfor
  endif
endfunction
