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
## @deftypefn {Function File} {@var{errorcode} =} ENinitH(@var{flag})
## Initializes the simulation (tank levels, link status, clock time, ...).@.@*
## @var{flag} is an integer which can be 0, 1, 10 or 11 (selfnote: check  that is not binary formatted 0,1,2,3)@.@*
## 0 do not re-initialize flows, do not save results to file@.@*
## 1 do not re-initialize flows, save results to file@.@*
## 10 re-initialize flows, do not save results to file@.@*
## 11 re-initialize flows, save results to file@.@*
## It returns an error code@.@*
## @seealso{ENrunH, ENnextH}
## @end deftypefn

function errorcode = ENinitH(flag)
  if nargin ==0,
    flag   = 0;
  end
  if ~(max(flag==[0 1 10 11])),  #('not correct flag value')
    flag = 0;
  end
  errorcode = ocENinitH(flag);
endfunction
