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
## @deftypefn {Function File} {@var{errorcode} =} ENsolveQ ( )
## Runs a complete water quality simulation writting the results for all time periods   to the binary output file. Do not use with ENinitQ, ENrunQ, ENnextQ, ENcloseQ, ENopenQ.
## It returns an error code.
## @seealso{ENopen, ENreport}
## @end deftypefn

function errorcode = ENsolveQ()
  errorcode = ocENsolveQ();
endfunction
