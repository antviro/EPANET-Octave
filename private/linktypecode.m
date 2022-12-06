function descripcion = linktypecode (typecode)
  switch typecode
    case 0
      descripcion = "CVPipe";
    case 1
      descripcion = "Pipe";
    case 2
      descripcion =   "Pump";
    case 3
      descripcion =   "PRV";
    case 4
      descripcion =   "PSV";
    case 5
      descripcion =   "PBV";
    case 6
      descripcion =   "FCV";
    case 7
      descripcion =   "TCV";
    case 8
      descripcion =   "GPV";
  endswitch
endfunction
    
