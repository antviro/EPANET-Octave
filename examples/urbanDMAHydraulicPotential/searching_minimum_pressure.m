%SST Name
SST="condesbarcelona_avchurra"

%Boolean variables
LOAD_INPUT_DATA_FROM_SCRIPT = 0
GRAPHICAL_OUTPUT = 1;
COMPUTE_HP_POTENTIAL_AEP = 0
CLOSE_TOOLKIT =1;
%% SST_NODES_PATTERN_SELECTION = 1;
%% all subsector/sector nodes have the same consumption patterns
%% if not they could be selected in a GIS program and introduced
%% as input
OPEN_VALVES = 1; % 0 is under the exp. test conditions 
required_pressure = 25; % required pressure in m.
valid_time = [] %[],[8, 23]*60*60 if empty no exclusion hours other wise it should be an interval initial time - final time in seconds (or hours*60*60)

if ~LOAD_INPUT_DATA_FROM_SCRIPT,
  %%%
  INPfile =	"160623reducidoV1_sl3LC.inp";
  % INP file prepared under test conditions (it can also be done in EpanetTK)
	pattern_name =	"AVChurra_CondesBCN";	
	links_input_output_SST =	{"Q769",	"Q770",	"V257",	"V256",	"V192"};
	input_or_output =	[1	1	-1	-1	1];
  %% 1 means flow rate entering the SST is positive, -1 if negative. One number for each inlet link defined in links_input_output_SST
  KNOWN_DIRECTIONS = 1	;	 %If 0 absolute value of Q is plotted --its direction should be checked--
	if OPEN_VALVES,						
		INPfile = "160721RedMurcia.inp";	%general INP file of the city under normal situation				
		load(cstrcat('lista_nodos_',SST,'.octave'));
 % under normal situation the selection of nodes can be loaded from the previous simulation
 % with OPEN_VALVES = 0
 % or alternatively from a GIS generated list (in case pattern is now linked to ST instead of to SST)
 %
 % This is only needed if one wants to keep different label names in Assets DB and in EPANET, usually
 % it can be kept empty to deactivate it
    correction_table=[];
    correction_table_links_input_output=[];
  endif
else,
%%% We load input data
  input_searching_minimum_pressures
  % This file should include a switch depending on SST just defining the previous input variable for each case studie, so that choosing one or another just needs to change the first variables in this file.
endif

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% This block is only needed if label names in EPANET and out are different %%%%%%%%%%%%
%%%%%%%%%%%%%%%%% In such a case, correction_table and correction_table_links_input_output are the %%%%%%
%%%%%%%%%%%%%%%%% variables used for that purpose --they are loaded before here-- %%%%%%%%%%%%%%%%%%%%%
if OPEN_VALVES,
  for icorr=1:length(correction_table)
    lista_id_nodos.(SST){find(strcmp(lista_id_nodos.(SST), correction_table{icorr}{1}))} = correction_table{icorr}{2};
  endfor

  for icorr=1:length(correction_table_links_input_output)
    indicelista_icorr =    find(strcmp(links_input_output_SST, correction_table_links_input_output{icorr}{1}));
    if length(indicelista_icorr)==1,
      links_input_output_SST{indicelista_icorr} = correction_table_links_input_output{icorr}{2};
    endif
    
  endfor

endif
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
opening_error = ENopen(INPfile)
if opening_error==302,
  error("Epanet Toolkit was not closed properly, try to close it, although it may hang Octave")
endif
% With regard to run in parallel, EPANET TK is not prepared to be able to... however, I have checked and it can be run in parallel running inside of different octave instances... (1 octave per parallel EPANET simulation...)
%
%%%%%%%%%%%%%%%%%%%%%%
% presionesmedidas y flowratemeasures...
%%%%%%%%%%%%%%%%%%%%%%
allNodes = ENgetnodeid([]);
allLinks = ENgetlinkid([]);
allPatterns = ENgetpatternid ([]);

%% links with entrances or exits:
linkList = ENlinkid2index(allLinks,links_input_output_SST);
% we get the indexes of the inlet links in which the hydraulic resource is being assessed
linkStatus_registered = ENgetlinkvalue (linkList ,"EN_INITSTATUS");

if OPEN_VALVES,
  nodeList = ENnodeid2index (allNodes , lista_id_nodos.(SST));
  if sum(  nodeList==0),
    display('Label errors not yet fixed in SST nodes')
    sum(nodeList==0),
    nodeList(nodeList==0)=[];
  endif
  
else
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We select nodes with the selected Pattern and a non-null base demand
  %% ENpatternid2index
  iPattern = ENnodeid2index(allPatterns, pattern_name);
  nodesPattern = ENgetnodevalue([],"EN_PATTERN");
  nodesBaseDemand=ENgetnodevalue([],"EN_BASEDEMAND");

  nodeList = find(nodesPattern==iPattern & nodesBaseDemand >0);
% nodes with no demand are removed from the list (it is not necessary to achieve the minimum pressure/head if there is no consumers)
  lista_id_nodos.(SST)  = allNodes (nodeList );
  save(cstrcat('lista_nodos_',SST,'.octave'),"lista_id_nodos");
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% There could be added an error test code after each sentence

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VALVES TO OPEN?: They could be included here. At the moment they are already included in INP
%% but here they can be modified if needed
if OPEN_VALVES,  
% incluido en inp nuevo  error = ENsetlinkvalue (linkList ,"EN_INITSTATUS",1);
  linkStatus_simulated= ENgetlinkvalue (linkList ,"EN_INITSTATUS");
  str_open_valves="open";
else
  linkStatus_simulated= ENgetlinkvalue (linkList ,"EN_INITSTATUS");
  str_open_valves="closed";
endif
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Correction of any error in the INP
%% For example here are some elevation corrections
ENsetnodevalue(4265,"EN_ELEVATION",41.261);
ENsetnodevalue(6460,"EN_ELEVATION",39.100) %p0508
%%%%%%%%%%%%%%%


opening_error = ENopenH()

% We run the simulation getting the information of flow rate QList in the selected links as well as
% the "instantaneous" minimum pressure minP and head minHead, together with the node in which the
% minimum values are achieved at each time step (iNode, iNode_minHead)
%[minP,iNode_minP, QList, t] = getMinimumPressure(nodeList,linkList) 
[minP,iNode_minP,minHead,iNode_minHead, QList, t] = getMinimumPressureAndHead(nodeList,linkList)
id_Node_minP = {allNodes{iNode_minP}}; % get the labels of the nodes
allNodes{unique(iNode_minP)} % print to screen the nodes in which the minimum pressure has been located at any time step (some times is good to have a look at them and even double check their node elevations

% same as before by with min head
id_Node_minHead = {allNodes{iNode_minHead}};
%allNodes{unique(iNode_minP)}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% This block is just to produce graphical output, if required.%%%%%%%%%%%
if GRAPHICAL_OUTPUT,
  figure(1)
  subplot(2,1,1)
  plot(t/3600,minP); 
  hold on; grid on;
  text(t(1)/3600,max(minP)-0.1,id_Node_minP{1})
  i_skift=find(diff(iNode_minP)~=0);
  if length(i_skift)>0,
    lista_nodos_pmin = id_Node_minP(i_skift);
    pos_Y = linspace(min(minP),max(minP),length(i_skift));
    text(t(i_skift)/3600, pos_Y ,lista_nodos_pmin)
  endif
  ylabel('pmin (m)')
  hold off
  subplot(2,1,2)
  if KNOWN_DIRECTIONS,
    plot(t/3600,QList.*input_or_output);grid on;
  else
      plot(t/3600,abs(QList));grid on;
  endif
  
  legend(links_input_output_SST)
  ylabel('flow rate (m3/h)')
  xlabel('Time (h)')
  print(cstrcat("minP_y_Q_",SSTlabel,"_",str_open_valves,".svg"));
  print(cstrcat("minP_y_Q_",SSTlabel,"_",str_open_valves,".png"));

  figure(2)
  subplot(2,1,1)
  plot(t/3600,minHead); 
  hold on; grid on;
  text(t(1)/3600,max(minHead)-0.1,id_Node_minHead{1})
  i_skift=find(diff(iNode_minHead)~=0);
  if length(i_skift)>0,
    lista_nodos_pmin = id_Node_minHead(i_skift);
    pos_Y = linspace(min(minHead),max(minHead),length(i_skift));
    text(t(i_skift)/3600, pos_Y ,lista_nodos_pmin)
  endif
  ylabel('head (m)')
  hold off
  subplot(2,1,2)
  if KNOWN_DIRECTIONS,
    plot(t/3600,QList.*input_or_output);grid on;
  else
      plot(t/3600,abs(QList));grid on;
  endif
  
  legend(links_input_output_SST)
  ylabel('flow rate (m3/h)')
  xlabel('Time (h)')
  print(cstrcat("minHead_y_Q_",SSTlabel,"_",str_open_valves,".svg"));
  print(cstrcat("minHead_y_Q_",SSTlabel,"_",str_open_valves,".png"));
  
endif
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if compute_hp_potential_aep,
%Interpolate time series
  time_s = t(1):1:t(end);
  minP_s = interp1(t, minP,time_s);
  QList_s = interp1(t,QList, time_s).*input_or_output; %positive (flow rate entering the sector, otherwise the potential minimum pressure could be out of the DMA!)
    
%filter out excluded times
  if length(valid_time)>0,
    included_indexes = time_s>=valid_time(1) & time_s<valid_time(2);
    time_s = time_s(included_indexes);
    minP_s = minP_s(included_indexes);
    QList_s = QList_s(included_indexes,:);
  endif
  
%Power (t) 1: instantaneous available Hn 2: minimum available Hn (in the valid time)
  power_s_1 = 9.81*(minP_s-required_pressure)'.*QList_s; %kW (rho=1e3 kg/m3)
  power_s_2 = 9.81*(min(minP_s)-required_pressure)'.*QList_s; %kW (rho=1e3 kg/m3)
%Eday1 and Eday2
  Eday1 = sum(power_s_1) * 1/60/60; % kWh (1/60/60 hour of each step 1s->h)
  Eday2 = sum(power_s_2) * 1/60/60;
%AEP1, AEP2
  AEP_1 = Eday1* 365.25; % kWh
  AEP_2 = Eday2* 365.25; % kWh
%save estimation
  save(cstrcat("AEP_",SSTlabel,"_",str_open_valves, ".mat"),"-V7","time_s","power_s_1","power_s_2","Eday1","Eday2","AEP_1","AEP_2","links_input_output_SST");
endif

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%saving main results in matlab compatible file 
save(cstrcat("minP_y_Q_",SSTlabel,"_",str_open_valves, ".mat"),"-V7","minP","iNode_minP","minHead","iNode_minHead","QList","t","id_Node_minP","INPfile","SST","SSTlabel","OPEN_VALVES","str_open_valves","linkStatus_registered","linkStatus_simulated");



%We close the simulation and the toolkit
if CLOSE_TOOLKIT,
  closing_error = ENcloseH();
  closing_error = ENclose();
end
