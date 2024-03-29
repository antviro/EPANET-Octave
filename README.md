This repository contains a wrapper of the Epanet Toolkit for GNU Octave, in which the aim has been as being as close as possible to the C library but including vectorial operations, as well as examples of use. Among those examples the folder urbanDMAHydraulicPotential contains the scripts corresponding to the paper DOI: "to be inserted".


# Table of contents
1. [Code description](#EPANET-Octave-code)
2. [Examples](#Examples)
3. [Instalation and issues](#Instalation-and-issues)


# EPANET-Octave code

## Function File: _errorcode =_ **ENcloseH** _( )_

    

Closes the hydraulic analysis system, freeing all allocated memory. It returns
an error code.

**See also:** ENinitH, ENrunH, ENnextH, ENopenH.

## Function File: _errorcode =_ **ENopen** _()_

    

Closes the Epanet Toolkit (with ENclose.c). It returns an error code.

**See also:** ENopen.

## Function File: _errorcode =_ **ENcloseQ** _( )_

    

Closes the water quality analysis system, freeing all allocated memory. It
returns an error code.

**See also:** ENinitH, ENrunH, ENnextH, ENopenH.

## Function File: _errorcode =_ **ENepanet** _( fileinp, filereport, filebin)_

    

Epanets the Epanet Toolkit (with ENepanet.c). fileinp EPANET input file (inp).
Compulsory argument. filereport output report file (in case used), if not
given inp file name is used changing its extension with rpt instead filebin
binary output file (in case used), if not given inp file name is used changing
its extension with bin instead.

**See also:** .

## Function File: _number ,errorcode =_ **ENgetcount( countcode)**

    

Counts the number of network components of a specified type countcode is a
string or a number with the specified type It can be run vectorized
introducing countcode as a vector (or matrix) of numbers Outputs: number is
the number we wanted to obtain errorcode can also be retrieved EN_NODECOUNT 0
EN_TANKCOUNT 1 reservoirs and tank nodes EN_LINKCOUNT 2 EN_PATCOUNT 3 time
patterns EN_CURVECOUNT 4 curves EN_CONTROLCOUNT 5

**See also:** .

## Function File: _errormessage ,newerrorcode =_ **ENgeterror( errorcode)**

    

Runs a step of hydraulic simulation. errormessage is the corresponding
message(s) of error Outputs: errorcode is the number of the error we want to
know It can be run vectorized where errormessage would be a string cell array
newerrorcode can also be retrieved

**See also:** ENgeterror, ENgetnodevalue, ENsetnodevalue.

## Function File: _flowunits ,errorcode, flowunitsstring =_ **ENgetflowunits()**

    

Units for flow rate is specified Outputs: flowunits is a number which
represents the kind of flow rate units used errorcode can also be retrieved
flowunits is a string with the flow units.

**See also:** .

## Function File: _id ,errorcode =_ **ENgetlinkid( index)**

    

Runs a step of hydraulic simulation. index is an integer which is the index of
the link Outputs: id is a string with the link identifier, it should be a
string variable containing the string and not the string itself. No idea of
why it cause problem the later... It can be run vectorized where id would be a
string cell array, in case index is an array errorcode can also be retrieved

**See also:** ENgetlinkid, ENgetlinkvalue, ENsetlinkvalue.

## Function File: _index ,errorcode =_ **ENgetlinkindex( linkid)**

    

Runs a step of hydraulic simulation. linkid is a string with the link
identifier, it should be a string variable containing the string and not the
string itself. No idea of why it cause problem the later... It can be run
vectorized where nodeid would be a string cell array, whereas index and
errorcode are returned as arrays nodeid ={"n1","n5"} -> index and errorcode
would be 1x2 arrays Outputs: index is an integer which is the index of the
link errorcode can also be retrieved

**See also:** ENgetlinkid, ENgetlinkvalue, ENsetlinkvalue.

## Function File: _fromnode ,tonode,errorcode =_ **ENgetlinknodes( id)**

    

Get nodes around each link Outputs: fromnode is the node at start of link
tonode is the node at end of link errorcode can also be retrieved Inputs: id
is the integer index of the link (can be a vector) if id is empty [] all link
nodes are retrieved [from,to]=ENgetlinknodes([])

**See also:** ENgetlinkid.

## Function File: _typecode ,errorcode,stype =_ **ENgetlinkvalue( id)**

    

Gets the text id of a link (or several links) Outputs: typecode is the code of
the type of link errorcode can also be retrieved stype is a string describing
type of link Inputs: id is the integer index of the link (can be a vector) or
empty [] and then all links are retrieved: ENgetlinktype([])

**See also:** ENgetlinkid, ENgetlinkvalue, ENsetlinkvalue.

## Function File: _value ,errorcode =_ **ENgetlinkvalue( id,param)**

    

get a value of a link.  
Outputs:  
value is the value we wanteed to obtain.  
errorcode can also be retrieved.  
Inputs:  
id is the integer index of the link (can be a vector/matrix) or [] and then
all link values are retrieved ENgetlinkvalue([],"EN_FLOW").  
param is the parameter to be measured it can be a string or an integer:  
EN_DIAMETER 0  
EN_LENGTH 1  
EN_ROUGHNESS 2  
EN_MINORLOSS 3 minor loss coef  
EN_INITSTATUS 4 initial link status (0= closed, 1=open)  
EN_INITSETTING 5 initial pipe roughness, pump speed or valve setting  
EN_KBULK 6 bulk reaction coef.  
EN_KWALL 7 wall reaction coef.  
EN_FLOW 8 flow rate  
EN_VELOCITY 9 flow velocity  
EN_HEADLOSS 10  
EN_STATUS 11 current link status (0= closed, 1=open)  
EN_SETTING 12 roughness, pump speed or valve setting  
EN_ENERGY 13 energy expended in kW (Â¿power?)  

**See also:** ENgetlinkid, ENgetlinkvalue, ENsetlinkvalue.

## Function File: _id ,errorcode =_ **ENgetnodeid( index)**

    

Runs a step of hydraulic simulation. index is an integer which is the index of
the node Outputs: id is a string with the node identifier, it should be a
string variable containing the string and not the string itself. No idea of
why it cause problem the later... It can be run vectorized where id would be a
string cell array, in case index is an array errorcode can also be retrieved

**See also:** ENgetnodeid, ENgetnodevalue, ENsetnodevalue.

## Function File: _index ,errorcode =_ **ENgetnodeindex( nodeid)**

    

Runs a step of hydraulic simulation. nodeid is a string with the node
identifier, it should be a string variable containing the string and not the
string itself. No idea of why it cause problem the later... It can be run
vectorized where nodeid would be a string cell array, whereas index and
errorcode are returned as arrays nodeid ={"n1","n5"} -> index and errorcode
would be 1x2 arrays Outputs: index is an integer which is the index of the
node errorcode can also be retrieved

**See also:** ENgetnodeid, ENgetnodevalue, ENsetnodevalue.

## Function File: _typecode ,errorcode,stype =_ **ENgetnodevalue( id)**

    

Runs a step of hydraulic simulation. Outputs: typecode is the code of the type
of node errorcode can also be retrieved stype is a string describing type of
node Inputs: id is the integer index of the node (can be a vector) or it can
be [] and then all nodes are retrieved.

**See also:** ENgetnodeid, ENgetnodevalue, ENsetnodevalue.

## Function File: _[ value,errorcode] =_ **ENgetnodevalue( id,param)**

    

Gets the value in a node.  
It can be run vectorized where nodeid would be a string cell array, whereas
index and errorcode are returned as arrays nodeid ={"n1","n5"} -> index and
errorcode would be 1x2 arrays.  
Outputs:  
value is the value we wanteed to obtain.  
errorcode can also be retrieved.  
Inputs:  
id is the integer index of the node (can be a vector/matrix). If no node is
specified all nodes value are retrieved e.g. ENgetnodevalue ([],10).  
param is the parameter to be measured it can be a string or an integer:  
"EN_ELEVATION" 0  
"EN_BASEDEMAND" 1  
"EN_PATTERN" 2  
"EN_EMITTER" 3 # Emitter coeff.  
"EN_INITQUAL" 4 # Initial quality  
"EN_SOURCEQUAL" 5 # Source quality  
"EN_SOURCEPAT" 6#Source pattern index  
"EN_SOURCETYPE" 7# Source type  
"EN_TANKLEVEL" 8 # Initial water level in tank  
"EN_DEMAND" 9# Actual demand  
"EN_HEAD"10# Hydraulic head  
"EN_PRESSURE"11# Pressure  
"EN_QUALITY"12# Actual quality  
"EN_SOURCEMASS"13# Mass flow rate per minute of a chemical source  
"EN_CONCEN" 0  
"EN_MASS" 1  
"EN_SETPOINT" 2  
"EN_FLOWPACED" 3  

**See also:** ENgetnodeid, ENgetnodevalue, ENsetnodevalue.

## Function File: _id ,errorcode =_ **ENgetpatternid( index)**

    

Gets the text id of a (or some) patterns index is an integer which is the
index of the pattern Outputs: id is a string with the pattern identifier, it
should be a string variable containing the string and not the string itself.
No idea of why it cause problem the later... It can be run vectorized where id
would be a string cell array, in case index is an array errorcode can also be
retrieved

**See also:** ENgetpatternid, ENgetpatternvalue, ENsetpatternvalue.

## Function File: _index ,errorcode =_ **ENgetpatternindex( patternid)**

    

Runs a step of hydraulic simulation. patternid is a string with the pattern
identifier, it should be a string variable containing the string and not the
string itself. No idea of why it cause problem the later... It can be run
vectorized where patternid would be a string cell array, whereas index and
errorcode are returned as arrays patternid ={"n1","n5"} -> index and errorcode
would be 1x2 arrays Outputs: index is an integer which is the index of the
pattern errorcode can also be retrieved

**See also:** ENgetpatternid, ENgetpatternvalue, ENsetpatternvalue.

## Function File: _[ len,errorcode] =_ **ENgetpatternlen( id)**

    

Gets the number of time periods in a specific time pattern. It can be run
vectorized where nodeid would be a string cell array, whereas index and
errorcode are returned as arrays nodeid ={"n1","n5"} -> index and errorcode
would be 1x2 arrays Outputs: len is the length we wanteed to obtain errorcode
can also be retrieved Inputs: id is the integer index of the pattern (can be a
vector/matrix). If no node is specified all nodes length are retrieved e.g.
ENgetpatternlen ([],10)

**See also:** ENgetnodeid, ENgetpatternlen, ENsetpatternlen.

## Function File: _[ value,errorcode] =_ **ENgetpatternvalue( id,** _period )_

    

Gets the multiplier factor for a specific time period in a time pattern. It
can be run vectorized where nodeid would be a string cell array, whereas index
and errorcode are returned as arrays nodeid ={"n1","n5"} -> index and
errorcode would be 1x2 arrays Outputs: value is the multiplier factor for a
specific time period in a time pattern. errorcode can also be retrieved
Inputs: id is the integer index of the pattern (can be a vector/matrix). If no
node is specified all nodes value are retrieved e.g. ENgetpatternvalue ([],10)
period is the number of time period in which multiplier wants to be retrieved

**See also:** ENgetnodeid, ENgetpatternvalue, ENsetpatternvalue.

## Function File: _errorcode =_ **ENinitH( flag)**

    

Initializes the simulation (tank levels, link status, clock time, ...)..  
flag is an integer which can be 0, 1, 10 or 11 (selfnote: check that is not
binary formatted 0,1,2,3).  
0 do not re-initialize flows, do not save results to file.  
1 do not re-initialize flows, save results to file.  
10 re-initialize flows, do not save results to file.  
11 re-initialize flows, save results to file.  
It returns an error code.  

**See also:** ENrunH, ENnextH.

## Function File: _errorcode =_ **ENinitQ( flag)**

    

Initializes the water quality simulation. flag is an integer which can be 0 or
1 0 do not save results to the binary output file 1 save results to the binary
output file (for instance for using ENreport afterwards) It returns an error
code.

**See also:** ENrunQ, ENnextQ.

## Function File: _codigodeerrorsinimplementar =_ **ENinsertvalve( fileinp,**
_idpipe ,typeofvalve,valve_settings,valve_minorlosses)_

    

Inputs.  
fileinp.  
idpipe is the pipe index or pipe id (not vectorized at the moment).  
typeofvalve It can be either a string of a number: EN_PRV 3 Pressure Reducing
Valve.  
EN_PSV 4 Pressure Sustaining Valve.  
EN_PBV 5 Pressure Breaker Valve.  
EN_FCV 6 Flow Control Valve.  
EN_TCV 7 Throttle Control Valve.  
EN_GPV 8 General Purpose Valve.  
valve_settings is the variable with the settings of the valve (it depends on
valve type, see EPANET manual).  
valve_minorlosses is the minor losses coefficient of the valve..  
voy por aqui en descripcion.  
En una segunda version habria que introducir algo por si se usa dos veces en
la misma tuberia por error o no. Y de tener coordenadas el inp estaria bien
meter la valvula a 1/20 de la tuberia para poder visualizarla si se considera
interesante.  
Outputs:.  
id is a string with the node identifier, it should be a string variable
containing the string and not the string itself. No idea of why it cause
problem the later... It can be run vectorized where id would be a string cell
array, in case index is an array errorcode can also be retrieved.  

**See also:** ENgetnodeid, ENgetnodevalue, ENsetnodevalue.

## Function File: _index =_ **ENlinkid2index( cellids,** _id )_

    

Get the ids of all the links parting from a cellarray of sortered index
(obtained previously with ENgetlinkid([]), e.g. allLinks = ENgetlinkid([]);
ENlinkid2index(allLinks,identificacionnodo). It also works with nodes, however
a new function is suggested for nodes just for making code easier to read. It
returns 0 when a id is not found. It can run with EPANET Toolkit closed index
is an integer which is the index of the link Outputs: id is a string with the
link identifier, it should be a string variable containing the string and not
the string itself. No idea of why it cause problem the later... It can be run
vectorized where id would be a string cell array, in case index is an array

**See also:** ENgetlinkid, ENgetlinkvalue, ENsetlinkvalue.

## Function File: _tstep ,errorcode =_ **ENnextH()**

    

Determines the time step until there is some hydraulic change. So that ENrunH
should be called again. Outputs: tstep is an integer with the previously
mentioned time step or 0 if the end of sim. is reached. errorcode can also be
retrieved

**See also:** ENnextH.

## Function File: _tstep ,errorcode =_ **ENnextQ()**

    

Advances the water quality simulation to the start of the next hyrdaulic time
period. So that ENrunQ should be called again. Outputs: tstep is an integer
with the previously mentioned time step or 0 if the end of sim. is reached.
errorcode can also be retrieved

**See also:** ENnextQ.

## Function File: _index =_ **ENnodeid2index( cellids,** _id )_

    

Get the ids of all the nodes parting from a cellarray of sortered index
(obtained previously with ENgetnodeid([]), e.g. allNodes = ENgetnodeid([]);
ENnodeid2index(allNodes,identificacionnodo). It also works with links
(actually, it is just a copy of it replacing "link" with "node") for making
code easier to read. It returns 0 when a id is not found. It can run with
EPANET Toolkit closed index is an integer which is the index of the node
Outputs: id is a string with the node identifier, it should be a string
variable containing the string and not the string itself. No idea of why it
cause problem the later... It can be run vectorized where id would be a string
cell array, in case index is an array

**See also:** ENgetnodeid, ENgetnodevalue, ENsetnodevalue.

## Function File: _errorcode =_ **ENopenH** _( )_

    

Opens the hydraulic analysis system. It must be run before ENinitH, ENrunH,
ENnextH. It returns an error code.

**See also:** ENinitH, ENrunH, ENnextH.

## Function File: _errorcode =_ **ENopenHoginitH( flag)**

    

Opens the hydraulic analysis system and initializates it. It must be run
before ENrunH, ENnextH. Initializes the simulation (tank levels, link status,
clock time, ...)..  
flag is an integer which can be 0, 1, 10 or 11 (selfnote: check that is not
binary formatted 0,1,2,3).  
0 do not re-initialize flows, do not save results to file.  
1 do not re-initialize flows, save results to file.  
10 re-initialize flows, do not save results to file (default).  
11 re-initialize flows, save results to file.  
It returns two error codes, one for the opening of the hydraulic system and
another one for the initialization, if the openning fails it does not go on
with the initialization returning an empty array as second error code.  

**See also:** ENrunH, ENnextH.

## Function File: _errorcode =_ **ENopen** _( fileinp, filereport, filebin).  
_

    

Opens the Epanet Toolkit (with ENopen.c). fileinp EPANET input file (inp). At
the moment fileinp should be in the working directory. Compulsory argument.  
filereport output report file (in case used), if not given inp file name is
used changing its extension with rpt instead.  
filebin binary output file (in case used), if not given inp file name is used
changing its extension with bin instead.  

**See also:** ENclose.

## Function File: _errorcode =_ **ENopenQ** _( )_

    

Opens the water quality analysis system. It must be run before ENinitQ,
ENrunQ, ENnextQ. It returns an error code.

**See also:** ENinitQ, ENrunQ, ENnextQ.

## Function File: _errorcode =_ **ENreport** _( )_

    

Writes a formatted text report on simulation results to the Report file. It
should be after ENsaveH It returns an error code.

**See also:** ENsaveH.

## Function File: _errorcode =_ **ENresetreport** _( )_

    

Clears any report formatting commands that either appeared in the [REPORT]
section of the EPANET Input file or were issued with the ENsetreport function.
After calling this function the default reporting options are in effect. These
are: No status report No energy report No nodes reported on No links reported
on Node variables reported to 2 decimal places Link variables reported to 2
decimal places (3 for friction factor) Node variables reported are elevation,
head, pressure, and quality Link variables reported are flow, velocity, and
head loss It returns an error code.

**See also:** ENsaveH.

## Function File: _t ,errorcode =_ **ENrunH()**

    

Runs a step of hydraulic simulation. Outputs: t is an integer with current
simulation time in seconds. errorcode can also be retrieved

**See also:** ENnextH.

## Function File: _t ,errorcode =_ **ENrunQ()**

    

Makes available the hydraulic and water quality results that occur at the
start of the next time period of a water quality analysis. Outputs: t is an
integer with current simulation time in seconds. errorcode can also be
retrieved

**See also:** ENnextQ.

## Function File: _errorcode =_ **ENsaveH** _( )_

    

Transfers results of a hydraulic simulation from the binary Hydraulics file to
the binary Output file, where results are only reported at uniform reporting
intervals. It should be called before writting the report It returns an error
code.

**See also:** ENreport.

## Function File: _errorcode =_ **ENsavehydfile** _( filebin)_

    

Savehydfiles the Epanet Toolkit (with ENsavehydfile.c). filebin EPANET file.
Compulsory argument.

**See also:** ENclose.

## Function File: _[ errorcode] =_ **ENsetlinkvalue( id,param,value)**

    

Sets the value in a link.  
Outputs:  
errorcode can also be retrieved.  
Inputs:  
id is the integer index of the link (can be a vector/matrix). If no link is
specified all links value are retrieved e.g. ENsetlinkvalue ([],10).  
param is the parameter to be measured it can be a string or an integer:  
EN_DIAMETER 0  
EN_LENGTH 1  
EN_ROUGHNESS 2  
EN_MINORLOSS 3 minor loss coef  
EN_INITSTATUS 4 initial link status (0= closed, 1=open)  
EN_INITSETTING 5 initial pipe roughness, pump speed or valve setting  
EN_KBULK 6 bulk reaction coef.  
EN_KWALL 7 wall reaction coef.  
EN_STATUS 11 current link status (0= closed, 1=open)  
EN_SETTING 12 roughness, pump speed or valve setting  
value is the values we want to set it should have the same size of id (if id
is empty then it should be a vector with one value for each link.

**See also:** ENsetlinkid, ENsetlinkvalue, ENsetlinkvalue.

## Function File: _[ errorcode] =_ **ENsetnodevalue( id,param,value)**

    

Sets the value in a node.  
Outputs:  
errorcode can also be retrieved.  
Inputs:  
id is the integer index of the node (can be a vector/matrix). If no node is
specified all nodes value are retrieved e.g. ENsetnodevalue ([],10).  
param is the parameter to be measured it can be a string or an integer:  
value is the values we want to set it should have the same size of id (if id
is empty then it should be a vector with one value for each node..  
"EN_ELEVATION" 0  
"EN_BASEDEMAND" 1  
"EN_PATTERN" 2  
"EN_EMITTER" 3 # Emitter coeff.  
"EN_INITQUAL" 4 # Initial quality  
"EN_SOURCEQUAL" 5 # Source quality  
"EN_SOURCEPAT" 6#Source pattern index  
"EN_SOURCETYPE" 7# Source type  
"EN_TANKLEVEL" 8 # Initial water level in tank  
"EN_DEMAND" 9# Actual demand  
"EN_HEAD"10# Hydraulic head  
"EN_PRESSURE"11# Pressure  
"EN_QUALITY"12# Actual quality  
"EN_SOURCEMASS"13# Mass flow rate per minute of a chemical source  
"EN_CONCEN" 0  
"EN_MASS" 1  
"EN_SETPOINT" 2  
"EN_FLOWPACED" 3  

**See also:** ENsetnodeid, ENsetnodevalue, ENsetnodevalue.

## Function File: _[ errorcode] =_ **ENsetpattern( id,factors)**

    

Sets all of the multiplier factors for a specific time pattern Outputs:
errorcode can also be retrieved Inputs: id is the integer index of the pattern
(not vectorised). factors is a vector with the factors we want to set up

**See also:** .

## Function File: _[ errorcode] =_ **ENsetpatternvalue( id,period,factor)**

    

Sets the multiplier factors of period nt for a specific time pattern Outputs:
errorcode can also be retrieved Inputs: id is the integer index of the pattern
(it works vectorised aswell). period period within time pattern factor is the
factor we want to set up

**See also:** .

## Function File: _errorcode =_ **ENgetstatusreport( statuslevel)**

    

Set the level of hydraulic status reporting. statuslevel es el nivel de status
segun esta tabla: // 0 - no status reporting // 1 - normal reporting // 2 -
full status reporting Outputs: errorcode can also be retrieved

**See also:** ENsetreport.

## Function File: _errorcode =_ **ENsolveH** _( )_

    

Runs a complete hydraulic simulation writting the results for all time periods
to the binary Hydraulics file. Do not use with ENinitH, ENrunH, ENnextH,
ENcloseH, ENopenH. It returns an error code.

**See also:** ENopen, ENreport.

## Function File: _errorcode =_ **ENsolveQ** _( )_

    

Runs a complete water quality simulation writting the results for all time
periods to the binary output file. Do not use with ENinitQ, ENrunQ, ENnextQ,
ENcloseQ, ENopenQ. It returns an error code.

**See also:** ENopen, ENreport.


## Function File: _id ,errorcode =_ **ENlinkid2index( index)**

    

Get the ids of all the links parting from a cellarray of sortered index
(obtained previously with ENgetlinkid([] index is an integer which is the
index of the link Outputs: id is a string with the link identifier, it should
be a string variable containing the string and not the string itself. No idea
of why it cause problem the later... It can be run vectorized where id would
be a string cell array, in case index is an array errorcode can also be
retrieved

**See also:** ENgetlinkid, ENgetlinkvalue, ENsetlinkvalue.

[Come back to TOC](#Table-of-contents)

# Examples

## examples/example_leakCalc.m

Example which on the one hand get all nodes with consumption, and on the other hand introduce a leak modelled as an emitter in one of the nodes. Such leak could model a pipe leak or a fire hydrant for example. Afterwards, the simulation is run getting time series of the leakage flow rate as well as its max and average value.

The script is commented here as tutorial of how to use it.

    Enopen("redM.inp") # we open the system
    ENopenHoginitH(0)  # we open an initialise the hydraulic system
    hydrantnode="52";  # node labelled as "52" is where we have the leak or hydrant in this case
    allNodes=ENgetnodeid([]); # we get an array with all nodes labels sortered by their internal id
    ihydrantnode=ENnodeid2index(allNodes,"52"); # We get the internal id of the hydrant node
    demandasbase=ENgetnodevalue([],"EN_BASEDEMAND"); #we get each node base demand
    nodosconsumo=find(demandasbase>0);    # we ge a list of such nodes whose consumption is not null (supply nodes)
    tstep=inf;
    ENsetnodevalue(ihydrantnode,"EN_EMITTER",2.157); #we set the emitter coeficient to 2.157 in the hydrant node, see EPANET manual for more details about equations.
    ENinitH(10); # We re-initialize flows in the hydraulic system (needed after defining as emitters nodes which were not defined initially as emitter (they had before a non-pressure dependent demand).
    clear tsimulacion; 
    clear Qfuga;
    iT=1;
    while tstep>0 #while simulation is not finished
      [tsimulacion(iT),coderr]=ENrunH(); #we run a simulation step
      Qfuga(iT)=ENgetnodevalue(ihydrantnode,"EN_DEMAND") #we store the flow rate on the node (substract the corresponding with consumption if not null?)
      tstep=ENnextH(); #we prepare simulation for the next step, if finished tstep would be 0
      iT = iT+1;
    end
    #we get the statistics of the leak flow rate
    Qmaxfuga=max(Qfuga) 
    Qmediofuga=mean(Qfuga)

    #We close the hydraulic system and the epanet network
    ENcloseH();
    ENclose();
    



## examples/urbanDMAHydraulicPotential

Here are the scripts of the paper DOI: to be added

[Come back to TOC](#Table-of-contents)

# Instalation and issues


## INSTALATION
Instruction assumes GNU/Linux as OS, particularly everything is tested under DEBIAN GNU/Linux. Nevertheless there should work in any other OS where Epanet TK is available, like Ms Windows. Although some of the instructions should be adapted. Alternatively, WSL could be used to run it under the Linux subsystem oficcially available in Ms Windows.

### Checkout/download package (en la carpeta donde lo queremos)

Download package from github, either using git commands/app or downloading and decompressing.

### Comprobar que las librerias dinámicas en /usr/local/lib/ se enlazan

    
    cat /etc/ld.so.conf.d/libc.conf
    
Its ouptput should include /usr/local/lib for example:

    # libc default configuration
    /usr/local/lib


### Create a folder in /usr/local/lib and copy there the libraries

What out! The following code $OCTAVE_EPANET_PATH should be replaced by its position e.g. /home/antonio/epanet-octave

Alternatively, you can create the shell variable =OCTAVE_EPANET_PATH= by using and instruction like
    
    OCTAVE_EPANET_PATH=$HOME/Documents/epanet/epanet/epanet-octave
    
indicating where is located the program


    
    sudo mkdir /usr/local/lib/epanet-octave
    sudo ln -s $OCTAVE_EPANET_PATH/*.so* /usr/local/lib/epanet-octave/
    sudo ldconfig # para actualizar el cache de librerias din a tener en cuenta
    sudo ldconfig /usr/local/lib/epanet-octave/ #no necesario pero ayuda a detectar fallos
    

### Within Octave


    cd $OCTAVE_EPANET_PATH/private # This can alternatively be done through Octave file browser
    compile_every_cc
    

### Use it

Program can either be used from folder $OCTAVE_EPANET_PATH or better adding such folder to the Octave Path, so that it can be used from any folder.

## Update instructions
If a new version is available this is the guide of how to update it

### Update repository

Update the repository with git

### Recompile the oct files from Octave

Do this in epanet-octave folder
    
    cd private # This can alternatively be done through Octave file browser
    compile_every_cc



## Issues and TODOs

   There are some bugs in the opening of certain INPs, whose cause has not yet been located, as well as with some valves/nodes labels in which the string are not well converted. As this is using an old version of EPANET ToolKit, this bugs could disappear after running in the updated version, although Epanet TK version has been kept frozen here to avoid any unforeseen change which may affect the project in which this is being used. Once finished, the new version will be tested.

### TODOs

#### Update used version of Epanet Toolkit

#### Modifications to ENgetpatternvalue ENsetpatternvalue

Besides vectorial used, it is planned to add matrix (pattern-time)

#### Include more checks to avoid errors in the wrapper

For instance, before calling ocENget... detect if argument is not an integer (e.g. a string), and produce an error message instead of sending the wrong argument, which leads to Octave being killed.

[Come back to TOC](#Table-of-contents)