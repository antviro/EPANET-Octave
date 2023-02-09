%%% We load input data
input_buscando_presiones_minimas_V2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% This block is only needed if label names in EPANET and out are different %%%%%%%%%%%%
%%%%%%%%%%%%%%%%% In such a case, tablacorreccion and tablacorreccion_links_input_output are the %%%%%%
%%%%%%%%%%%%%%%%% variables used for that purpose --they are loaded before here-- %%%%%%%%%%%%%%%%%%%%%
if OPEN_VALVES,
  for icorr=1:length(tablacorreccion)
    lista_id_nodos.(SST){find(strcmp(lista_id_nodos.(SST), tablacorreccion{icorr}{1}))} = tablacorreccion{icorr}{2};
  endfor

  for icorr=1:length(tablacorreccion_links_input_output)
    indicelista_icorr =    find(strcmp(links_input_output_SST, tablacorreccion_links_input_output{icorr}{1}));
    if length(indicelista_icorr)==1,
      links_input_output_SST{indicelista_icorr} = tablacorreccion_links_input_output{icorr}{2};
    endif
    
  endfor

endif
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
opening_error = ENopen(ficheroINP)
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
iPattern = ENnodeid2index(allPatterns, nombre_patron);
nodesPattern = ENgetnodevalue([],"EN_PATTERN");
nodesBaseDemand=ENgetnodevalue([],"EN_BASEDEMAND");

nodeList = find(nodesPattern==iPattern & nodesBaseDemand >0);
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
if DIBUJO,
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
  if CONOCEMOS_SENTIDOS,
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
  if CONOCEMOS_SENTIDOS,
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%saving main results in matlab compatible file 
save(cstrcat("minP_y_Q_",SSTlabel,"_",str_open_valves, ".mat"),"-V7","minP","iNode_minP","minHead","iNode_minHead","QList","t","id_Node_minP","ficheroINP","SST","SSTlabel","OPEN_VALVES","str_open_valves","linkStatus_registered","linkStatus_simulated");



%We close the simulation and the toolkit
if CIERRA_TOOLKIT,
  closing_error = ENcloseH();
  closing_error = ENclose();
end
