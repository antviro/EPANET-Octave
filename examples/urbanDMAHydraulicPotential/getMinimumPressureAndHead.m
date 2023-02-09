function [minimumPressure, indexMinimumPressureNode,minimumHead, indexMinimumHeadNode , QList, t]  = getMinimumPressureAndHead (nodeList,linkList)
  %% Inputs:
  %% - nodeList: list of nodes in the subsector analysed (they are filtered out in the script to include only nodes with no null comsuption)
  %% - linkList: list of inlet links/pipes to the subsector (e.g. the "sectorising valves")
  %% Outputs:
  %% -minimumPressure: minimum pressure on each time step (at the node in which the minimum pressure is achieved on each time step
  %% -iNode node index where such minimum pressure is located on each time step (it will be converted into its label in the script)
  %% - minimumHead, indexMinimumHeadNoda: they are analogous variables to the two previous ones but using head instead of pressure.
  %% -QList(ilink,:) Flow rate time series for each inlet link
  %% -t arrat with the time of each time step (so that it can be time filtered if needed)
 error =  ENinitH(10); % We restart the simulation
 if error ~= 0, ENgeterror(error); endif  

 % initialising
 % listPressures = zeros(size(nodeList));
 
%

 
 deltaT = 1000;
 iT = 1;

 while deltaT>0, %when simulation is finished, deltaT will be 0
   %% we run a time step of the simulations
   [t(iT),error] = ENrunH(); 
   if error ~= 0, ENgeterror(error); endif
   
   %% reading set of pressures 
   [presiones, error ] = ENgetnodevalue(nodeList,11);%"EN_PRESSURE")
   if error ~= 0, ENgeterror(error); endif
   %% reading set of heads
   [head, error ] = ENgetnodevalue(nodeList,10);%"EN_HEAD") reading set of heads
   if error ~= 0, ENgeterror(error); endif  
   %% reading the set of flow rates
   [flowrates, error ] = ENgetlinkvalue(linkList,8);%"EN_FLOW")
   if error ~= 0, ENgeterror(error); endif  
   %% computing time step minimum
   [minimumPressure(iT),imin] = min(presiones);
   indexMinimumPressureNode(iT) = nodeList(imin);
   [minimumHead(iT),imin] = min(head);
   indexMinimumHeadNode(iT) = nodeList(imin);
   
   QList(iT,:)= flowrates;
   %%%  simulatedFlowRate(iT,:) = flowrates;

   %we prepare next step, and get the value of deltaT (0 if simulation's ended)
   [deltaT,error] = ENnextH();
   if error ~= 0, ENgeterror(error); endif
   
   iT = iT+1;
 endwhile

