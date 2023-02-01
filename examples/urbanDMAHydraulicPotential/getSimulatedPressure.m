function [simulatedPressures, t]  = getSimulatedPressure (roughness, variableRuhedLinks, nodeList, measuredPressures)

%  size(roughness)
  if (size(roughness,2)==1),roughness = roughness'; endif
%%%%%%%%
  roughness=abs(roughness);
%%%%%%%%
  
 error =  ENinitH(10); % Reiniciamos simulacion
 if error ~= 0, ENgeterror(error); endif  % alguna accion? paramos?

 error = ENsetlinkvalue( variableRuhedLinks, 2, roughness);
if error ~= 0, ENgeterror(error); endif  % alguna accion? paramos?

% preinicializamos
 simulatedPressures = zeros(size(measuredPressures));
%%% simulatedFlowRate = zeros(size(measuredFlowRates'));
%

 
 deltaT = 1000;
 iT = 1;

while deltaT>0,
  [t(iT),error] = ENrunH();
  if error ~= 0, ENgeterror(error); endif  % alguna accion? paramos?  
% reading set of pressures & flow rates
  [presiones, error ] = ENgetnodevalue(nodeList,11);%"EN_PRESSURE")
  if error ~= 0, ENgeterror(error); endif  % alguna accion? paramos?
%%%  [flowrates, error ] = ENgetlinkvalue(linkList,8);%"EN_FLOW")
%%%  if error ~= 0, ENgeterror(error); endif  % alguna accion? paramos?

  %p7237(iT) = ENgetnodevalue(983,11);
##   size(presiones)
##   size(simulatedPressures)
  ## %  t(end)
  ## size(simulatedPressures(iT,:))

  %% iT sube mas de simulatedPressures size!!!!!!!! ver
%  iT
%  size(flowrates)
%  size(simulatedFlowRate)
%  size(presiones)
  simulatedPressures(iT,:) = presiones;
  
%%% COMENTO TEMPORALMENTE PA AHORRAR TIEMPO
%%%
%%%  simulatedFlowRate(iT,:) = flowrates;
%%%  

  [deltaT,error] = ENnextH();
  if error ~= 0, ENgeterror(error); endif  % alguna accion? paramos?
  
  iT = iT+1;
endwhile

%fflush(1)
