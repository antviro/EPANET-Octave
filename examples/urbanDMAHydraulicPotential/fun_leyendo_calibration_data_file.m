function [nodeList, measuredPressures, linkList, measuredFlowrate] = fun_leyendo_calibration_data_file(calibration_file, ficheroINP, output_file) 
## -*- texinfo -*-
## @deftypefn {Function File} {[@var{nodeList,measuredPressures,linkList,measuredFlowrate}]} = fun_leyendo_calibration_data_file(@var{calibration_file}, @var{ficheroINP}, @var{output_file})
## Read the measurements which are going to be used and interpolates them to the simulation steps@.@*
## It could be done the other way around but then it slowes the process as it may have to be done inside of the error evaluation function (it could be better if time steps changes from one simulation to another@.@*
## Outputs:@*
## @var{nodeList} Array with the indixes of the nodes in which pressure has been measured@.@*
## @var{measuredPressures} DESCRIPTION@.@*
## @var{linkList} DESCRIPTION@.@*
## @var{measuredFlowrate} DESCRIPTION@.@*
## Inputs:@*
## @var{calibration_file} DESCRIPTION@.@*
## @var{ficheroINP} DESCRIPTION@.@*
## @var{output_file} DESCRIPTION@.@*
## @seealso{TOBEWRITTEN, TOBEWRITTEN}
## @end deftypefn
% Calibration file should have this format
#The flowmeter should have a numeric value here that together with Q is their Epanet label of the corresponding link for instance: Q1 flow rate measurements will start like this:
## ;1 
## Q1 0 915.458
## On each line after the label we have three columns the full label, time and the variable.
## Once the time series ends, there is an empty line and a new label of the other sensors.
## Q1 0.16667 915.458
## Q1 0.33333 915.458
## Q1 0.5 915.458
## Q1 0.66667 915.458
## [...]
##
## ;101
## Q101 0 257.875
## Q101 0.16667 257.875
## Q101 0.33333 257.875
## Q101 0.5 273.114
## [...]
## The pressure manometers should have text on their labels, and the label after the semicolon would be exactly the EPANET label, otherwise the format is similar to the flowmeters.
## If the labels of your network follows other rule you may either change the labels where the sensors are or modify lightly this function to adapt it.
## ;DAVILESES
## DAVILESES 0 1.596
## DAVILESES 0.16667 1.605
## DAVILESES 0.33333 1.605
## DAVILESES 0.5 1.605
## DAVILESES 0.66667 1.605
## DAVILESES 0.83333 1.605
## DAVILESES 1 1.605
## [...]
  error_abriendo = ENopen(ficheroINP)
  error_abriendo = ENopenH()
%%%%%%%%%%%%%%%%%
  allLinks = ENgetlinkid([]);
  allNodes = ENgetnodeid([]);
%%%%%%%%%% We run a simulation (under some circunstances steps could change - tank levels)
  error = ENinitH(10)
  deltaT = 1000
  iT = 1;

  while deltaT>0,
    [t(iT),error] = ENrunH();
    [deltaT,error] = ENnextH();
    
    iT = iT+1;
  endwhile
  numT = iT-1

  
  clear nodeList, clear linkList, clear etiquetasNotFound;
  clear labelNodeList; clear labelLinkList;
  numNodeList = 1;
  numLinkList = 1;
  numEtiquetasNotFound = 1;

  FIDcal = fopen(calibration_file, "r");


  if fscanf(FIDcal,"%c",1)~=";"
    error("Error reading calibration file");
  endif


  while (!feof(FIDcal)),
    label = fscanf(FIDcal,"%s",1);
    etiquetanumerica = (~isnan(strread(label,"%n")));

    if etiquetanumerica==1,
% link
      label   = ["Q" label];
      linkIndex = ENlinkid2index (allLinks, label);
      if length(linkIndex) == 0, linkIndex = 0; endif %% por compatibilidad octave-epanet versionanterior
       %      [linkIndex , erroridentificando] = ENgetlinkindex(label);

                            % leer datos e interpolar
      fscanf(FIDcal, "%c",2); % END OF LINE char 13 - 10
      nDatos = 1;
      time =[];
      seriedatos=[];
      letra = fscanf(FIDcal, "%c",1);
      while letra~=";",
        fscanf(FIDcal,"%s",1);
        time(nDatos)= fscanf(FIDcal,"%f",1);
        seriedatos(nDatos)= fscanf(FIDcal,"%f\n",1);
        nDatos = nDatos + 1;
        letra = fscanf(FIDcal, "%c",1);
      endwhile
      if linkIndex ~= 0, %erroridentificando == 0,
        linkList(numLinkList) = linkIndex;
        labelLinkList{numLinkList} = label;
% INTERPOLATION
        pp_measuredFlowrate = interp1(time*3600,seriedatos, 'pp');
        measuredFlowrate(numLinkList,:) = ppval(pp_measuredFlowrate, t);
%measuredFlowrate(numLinkList,:) = interp1(time*3600,seriedatos, t);
        numLinkList = numLinkList + 1;
        
      else %not found
        etiquetasNotFound{numEtiquetasNotFound} = label;
        numEtiquetasNotFound = numEtiquetasNotFound + 1;
      endif
      
    else
% node

      nodeIndex = ENnodeid2index (allNodes, label);
      if length(nodeIndex) == 0, nodeIndex = 0; endif %% por compatibilidad octave-epanet versionanterior
     %      [nodeIndex , erroridentificando] = ENgetnodeindex(label);
                              % leer datos e interpolar
      fscanf(FIDcal, "%c",2); % END OF LINE char 13 - 10
      nDatos = 1;
      time =[];
      seriedatos=[];

      letra = fscanf(FIDcal, "%c",1);
      while letra~=";",
        fscanf(FIDcal,"%s",1);
        time(nDatos)= fscanf(FIDcal,"%f",1);
        seriedatos(nDatos)= fscanf(FIDcal,"%f\n",1);
        nDatos = nDatos + 1;
        letra = fscanf(FIDcal, "%c",1);
      endwhile
      if nodeIndex ~= 0, %erroridentificando == 0,
        nodeList(numNodeList) = nodeIndex;
        labelNodeList{numNodeList} = label;
% INTERPOLATION
        pp_measuredPressures = interp1(time*3600,seriedatos, 'pp');
        measuredPressures(numNodeList,:) = ppval(pp_measuredPressures, t);
%measuredPressures(numNodeList,:) = interp1(time*3600,seriedatos, t);
        numNodeList = numNodeList + 1;

      else %not found
        etiquetasNotFound{numEtiquetasNotFound} = label;
        numEtiquetasNotFound = numEtiquetasNotFound + 1;
      endif
      
      
    endif
  endwhile

  save(output_file)
%fclose(FIDcal)
  error_cerrando=ENcloseH();
  error_cerrando=ENclose();

 %nodeList = [5 10 100 500 600]
 %linkList = [2825 2850 2928 9400]

%simulatedPressures(iT,:)
