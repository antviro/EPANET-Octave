## -*- texinfo -*-
## Example which on the one hand get all nodes with consumption,
## and on the other hand introduce a leak modelled as an emitter
## in one of the nodes, running the simulation and getting
## time series of the leakage flow rate as well as its max
## and average value



Enopen("redM.inp")
ENopenHoginitH(0)
hydrantnode="52";
allNodes=ENgetnodeid([]);
ihydrantnode=ENnodeid2index(allNodes,"52");
demandasbase=ENgetnodevalue([],"EN_BASEDEMAND");
nodosconsumo=find(demandasbase>0);
tstep=inf;
ENsetnodevalue(ihydrantnode,"EN_EMITTER",2.157);
ENinitH(10);
clear tsimulacion;
clear Qfuga;
iT=1;
while tstep>0
  [tsimulacion(iT),coderr]=ENrunH();
  Qfuga(iT)=ENgetnodevalue(ihydrantnode,"EN_DEMAND")
  tstep=ENnextH();
  iT = iT+1;
end
Qmaxfuga=max(Qfuga)
Qmediofuga=mean(Qfuga)

ENcloseH();
ENclose();
