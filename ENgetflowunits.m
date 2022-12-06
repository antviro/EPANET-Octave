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
## @deftypefn {Function File} {@var{flowunits},@var{errorcode}, @var{flowunitsstring} =} ENgetflowunits()
## Units for flow rate is specified
## Outputs:
## @var{flowunits} is a number which represents the kind of flow rate units used
## @var{errorcode} can also be retrieved
## @var{flowunits} is a string with the flow units.
## @seealso{ }
## @end deftypefn

function [flowunits , errorcode, flowunitsstring] = ENgetflowunits()

  [flowunits, errorcode] = ocENgetflowunits();
    switch flowunits,
      case 0,
        flowunitsstring="EN_CFS"; # ft3/s
      case 1,
        flowunitsstring="EN_GPM";
      case 2,
        flowunitsstring="EN_MGD";
      case 3,
        flowunitsstring="EN_IMGD";
      case 4,
        flowunitsstring="EN_AFD";
      case 5,
        flowunitsstring="EN_LPS"; # l/s
      case 6,
        flowunitsstring="EN_LPM"; # l/min
      case 7,
        flowunitsstring="EN_MLD"; #1e3 m3/dia
      case 8,
        flowunitsstring="EN_CMH"; #m3/h
      case 9,
        flowunitsstring="EN_CMS"; #m3/dia
    endswitch
endfunction
