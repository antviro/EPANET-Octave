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
## @deftypefn {Function File} {@var{id},@var{errorcode} =} ENgetpatternid(@var{index})
## Gets the text id of a (or some) patterns
## @var{index} is an integer which is the index of the pattern
## Outputs:
## @var{id} is a string with the pattern identifier, it should be a string variable containing the string and not the string itself. No idea of why it cause problem the later...
## It can be run vectorized where id would be a string cell array, in case index is an array
## @var{errorcode} can also be retrieved
## @seealso{ENgetpatternid, ENgetpatternvalue, ENsetpatternvalue}
## @end deftypefn

function [id,errorcode] = ENgetpatternid(index)
  if  length(index)==1,
    [id,errorcode] = ocENgetpatternid(index);
  elseif length(index)>1,
    [id,errorcode] = cellfun ("ocENgetpatternid",index);
  else #index =[]
    # all patterns retrieved
    index =1:ENgetcount(3);
    [id,errorcode] = arrayfun ("ocENgetpatternid",index,"UniformOutput", false);
  endif
endfunction
