ENopen("redM.inp")
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
