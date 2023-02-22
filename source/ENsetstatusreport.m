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
## @deftypefn {Function File} {@var{errorcode} =} ENgetstatusreport(@var{statuslevel})
## Set the level of hydraulic status reporting.
## @var{statuslevel} es el nivel de  status segun esta tabla:
## // 0 - no status reporting
## // 1 - normal reporting
## // 2 - full status reporting
## Outputs:
## @var{errorcode} can also be retrieved
## @seealso{ENsetreport}
## @end deftypefn

function [errorcode] = ENsetstatusreport(statuslevel)
  [errorcode] = ocENsetstatusreport(statuslevel);
endfunction
