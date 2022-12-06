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
## @deftypefn {Function File} {@var{tstep},@var{errorcode} =} ENnextQ()
## Advances the water quality simulation to the start of the next hyrdaulic time period. So that ENrunQ should be called again.
## Outputs:
## @var{tstep} is an integer with the previously mentioned time step or 0 if the end of sim. is reached.
## @var{errorcode} can also be retrieved
## @seealso{ENnextQ}
## @end deftypefn

function [tstep,errorcode] = ENnextQ()
  [tstep,errorcode] = ocENnextQ();
endfunction
