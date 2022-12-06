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
## @deftypefn {Function File} {@var{t},@var{errorcode} =} ENrunQ()
## Makes available the hydraulic and water quality results that occur at the start of the next time period of a water quality analysis.
## Outputs:
## @var{t} is an integer with current simulation time in seconds.
## @var{errorcode} can also be retrieved
## @seealso{ENnextQ}
## @end deftypefn

function [t,errorcode] = ENrunQ()
  [t,errorcode] = ocENrunQ();
endfunction
