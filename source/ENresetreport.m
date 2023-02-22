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
## @deftypefn {Function File} {@var{errorcode} =} ENresetreport ( )
## Clears any report formatting commands that either appeared in the [REPORT] section
## of the EPANET Input file or were issued with the ENsetreport function.
## After calling this function the default reporting options are in effect. These are:
## No status report
## No energy report
## No nodes reported on
## No links reported on
## Node variables reported to 2 decimal places
## Link variables reported to 2 decimal places (3 for friction factor)
## Node variables reported are elevation, head, pressure, and quality
## Link variables reported are flow, velocity, and head loss
## It returns an error code.
## @seealso{ENsaveH}
## @end deftypefn

function errorcode = ENresetreport()
  errorcode = ocENresetreport();
endfunction
