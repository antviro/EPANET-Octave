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
## @deftypefn {Function File} {@var{codigodeerrorsinimplementar} =} ENinsertvalve(@var{fileinp}, @var{idpipe},@var{typeofvalve},@var{valve_settings},@var{valve_minorlosses})
## Inputs@.@*
## @var{fileinp}@.@*
## @var{idpipe} is the pipe index or pipe id (not vectorized at the moment)@.@*
## @var{typeofvalve}
## It can be either a string of a number:
## EN_PRV 3 Pressure Reducing Valve@.@*
## EN_PSV 4 Pressure Sustaining Valve@.@*
## EN_PBV 5 Pressure Breaker Valve@.@*
## EN_FCV 6 Flow Control Valve@.@*
## EN_TCV  7 Throttle Control Valve@.@*
## EN_GPV 8 General Purpose Valve@.@*
## @var{valve_settings} is the variable with the settings of the valve (it depends on valve type, see EPANET manual)@.@*
## @var{valve_minorlosses} is the minor losses coefficient of the valve.@.@*
##voy por aqui en descripcion@.@*
## En una segunda version habria que introducir algo por si se usa dos veces en la misma tuberia por error o no. Y de tener coordenadas el inp estaria bien meter la valvula a 1/20 de la tuberia para poder visualizarla si se considera interesante@.@*
## Outputs:@.@*
## @var{id} is a string with the node identifier, it should be a string variable containing the string and not the string itself. No idea of why it cause problem the later...
## It can be run vectorized where id would be a string cell array, in case index is an array
## @var{errorcode} can also be retrieved@.@*
## @seealso{ENgetnodeid, ENgetnodevalue, ENsetnodevalue}
## @end deftypefn

function  ENinsertvalve( fileinp, idpipe, typeofvalve, valve_settings, valve_minorlosses)

  if nargin == 3,
    valve_settings = 0;
    valve_minorlosses = 0;
  elseif nargin == 4,
    valve_minorlosses = 0;
  elseif nargin == 2,
    valve_settings = 0;
    valve_minorlosses = 0;
    typeofvalve = "GPV";
  elseif nargin <2,
    error("Not enought arguments")
  endif
  valve_settings = num2str(valve_settings);
  valve_minorlosses = num2str(valve_minorlosses);

  
  coderror =  ENopen(fileinp);

  %% VER QUE TUBERIA ES Y SACAR su info
  if ischar(idpipe),
    [ipipe, coderror] = ENgetlinkindex(idpipe);
  else
    ipipe = idpipe;
    [idpipe, coderror] = ENgetlinkid(idpipe);
  endif
  lenidpipe = length(idpipe);
  
  [fromnode, tonode] = ENgetlinknodes(ipipe);
  fromnodeID = ENgetnodeid(fromnode);
  tonodeID = ENgetnodeid(tonode);
  length = num2str(ENgetlinkvalue(ipipe,"EN_LENGTH"));
  diameter = num2str(ENgetlinkvalue(ipipe,"EN_DIAMETER"));
  roughness = num2str(ENgetlinkvalue(ipipe,"EN_ROUGHNESS"));
  pipeminorloss = num2str(ENgetlinkvalue(ipipe,"EN_MINORLOSS"));
  initstatus = ENgetlinkvalue(ipipe,"EN_INITSTATUS");
  if initstatus == 1, initstatus = "Open";elseif initstatus == 0, initstatus ="Closed"; else initstatus = "CV";endif
  fromnodeelevation = ENgetnodevalue(fromnode, "EN_ELEVATION");

  %% Tipo de valvula a introducir
  if ischar(typeofvalve),
    typeofvalve=typeofvalve(end-2:end);
  else
    switch typeofvalve,
      case 3
        typeofvalve="PRV";
      case 4
        typeofvalve="PSV";
      case 5
        typeofvalve="PBV";
      case 6
        typeofvalve="FCV";
      case 7
        typeofvalve="TCV";
      case 8
        typeofvalve="GPV";
      otherwise
        error('Not a valid type')
    endswitch
  endif
  
  coderror = ENclose();

  ############################################
%%% Cadena Introducir nodo/junction nuevo
  ## [JUNCTIONS]
  ## ;ID              	Elev        	Demand      	Pattern         
  ##  n1              	670.62      	0           	                	;

  ##nynodoid = cstrcat...
  nynodoid = cstrcat(" ",fromnodeID,"aftervalve");
  lineanynodoid = cstrcat(nynodoid," \t",num2str(fromnodeelevation)," \t0 \t \t;\n");
  
  
  
  
%%% Cadena tuberia nueva
## [PIPES]
##;ID              	Node1           	Node2           	Length      	Diameter    	Roughness   	MinorLoss   	Status
  nypipeid = cstrcat(" ",idpipe,"aftervalve"); # name could be kept
  lineanypipe = cstrcat( nypipeid, " \t", nynodoid, " \t", tonodeID, " \t", length, " \t", diameter, " \t", roughness, " \t", pipeminorloss, " \t", initstatus," \t;\n");
  
  
%%% Cadena válvula
## [VALVES]
## ;ID              	Node1           	Node2           	Diameter    	Type	Setting     	MinorLoss   
##  1               	n40             	3               	80          	PBV 	0           	0           	;
  valveid = cstrcat(" valve",idpipe);
  lineanyvalve = cstrcat(valveid, " \t", fromnodeID, " \t", nynodoid, " \t", diameter, " \t",typeofvalve, " \t",valve_settings, " \t",valve_minorlosses, " \t;\n");

  
%%% abrir fichero y copiar eliminando tuberia idpipe e introduciendo nuevas cadenas
#strjoin (cellofstrings,"\n"); strjoin (cellofstrings,"") parece q no
#strncmpi (s1, s2, n)
  FIDinp = fopen(fileinp,"r");

  lineafichero ="1";
  n=1;
  comprobacion_cambios = zeros(4,1); ## para comprobar que hemos hecho los cambios
  NotEOF = 1;
  while NotEOF,
    lineafichero = fgets(FIDinp);

    ## comprobar si estamos donde hay que introducir o eliminar filas
    if  lineafichero(1) == -1,
      ## End of file reached
      NotEOF = 0;
    else
      if strncmpi(lineafichero, "[JUNCTIONS]",11)
        ## En nodos [JUNCTIONS], copiar dos lineas la detectada y la descripcion,
        fileinp_text{n} = lineafichero;
        n = n + 1;
        lineafichero = fgets(FIDinp);
        fileinp_text{n} = lineafichero;
        n = n + 1;
        ## y anhadir:    lineanynodoid 
        fileinp_text{n} = lineanynodoid;
        n = n + 1;
        ##
        comprobacion_cambios(1) = 1;
      elseif strncmpi(lineafichero, "[PIPES]",7)
        ## En pipe [PIPES] copiar dos lineas etiqueta y descripcion
        fileinp_text{n} = lineafichero;
        n = n + 1;
        lineafichero = fgets(FIDinp);
        fileinp_text{n} = lineafichero;
        n = n + 1;
        ## anhadir: lineanypipe
        fileinp_text{n} = lineanypipe;
        n = n + 1;
        ##
        comprobacion_cambios(2) = 1;
        
      elseif strncmpi(lineafichero,[" ", idpipe],lenidpipe+1)
        ## Eliminar pipe idpipe
        ## No se copia la linea (no se hace nada)
        ##
        comprobacion_cambios(3) = 1;
      elseif strncmpi(lineafichero, "[VALVES]",8)
        ## En [VALVES] copiar dos lineas etiqueta y descripcion
        fileinp_text{n} = lineafichero;
        n = n + 1;
        lineafichero = fgets(FIDinp);
        fileinp_text{n} = lineafichero;
        n = n + 1;
        ## anhadir lineanyvalve
        fileinp_text{n} = lineanyvalve;
        n = n + 1;
        ##
        comprobacion_cambios(4) = 1;
      else
        ## sino almacenamos el valor e incrementamos n
        fileinp_text{n} = lineafichero;
        n = n + 1;
      endif
    endif
  endwhile

  fclose(FIDinp);

  comprobacion_cambios
  ##save datos.mat
  if prod(comprobacion_cambios),
    texto_fichero = strjoin(fileinp_text,"");

    FIDinp = fopen(fileinp,"w");
    ##    FIDinp = stdout
    fputs(FIDinp,texto_fichero);
    ##    save prueba.octave # PROBANDO DEPURANDO ERRORES
    fclose(FIDinp);
    
  else
    error ("Ha habido algun error en la lectura del fichero INP comprueba su formato");
  end
  
endfunction
