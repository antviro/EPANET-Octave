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
## @deftypefn {Function File} {@var{errorcode} =} ENinitQ(@var{flag})
## Initializes the water quality simulation.
## @var{flag} is an integer which can be 0 or 1
## 0 do not save results to the binary output file
## 1 save results to the binary output file (for instance for using ENreport afterwards)
## It returns an error code.
## @seealso{ENrunQ, ENnextQ}
## @end deftypefn

function errorcode = ENinitQ(flag)
  if nargin ==0,
    flag   = 0;
  end
  if ~(max(flag==[0 1])),  #('not correct flag value')
    flag = 0;
  end
  errorcode = ocENinitQ(flag);
endfunction
