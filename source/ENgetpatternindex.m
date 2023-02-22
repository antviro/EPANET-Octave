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
## @deftypefn {Function File} {@var{index},@var{errorcode} =} ENgetpatternindex(@var{patternid})
## Runs a step of hydraulic simulation.
## @var{patternid} is a string with the pattern identifier, it should be a string variable containing the string and not the string itself. No idea of why it cause problem the later...
## It can be run vectorized where patternid would be a string cell array, whereas index and errorcode are returned as arrays patternid =@{"n1","n5"@} --> index and errorcode would be 1x2 arrays
## Outputs:
## @var{index} is an integer which is the index of the pattern
## @var{errorcode} can also be retrieved
## @seealso{ENgetpatternid, ENgetpatternvalue, ENsetpatternvalue}
## @end deftypefn

function [index,errorcode] = ENgetpatternindex(patternid)
  if  ~iscell(patternid),
    [index,errorcode] = ocENgetpatternindex(patternid);
  else
    [index,errorcode] = cellfun ("ocENgetpatternindex",patternid);
  endif
endfunction
