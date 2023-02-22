function descripcion = nodetypecode (typecode)
  switch typecode
    case 0
      descripcion = "Junction";
    case 1
      descripcion = "Reservoir";
    case 2
      descripcion =   "Tank";
  endswitch
endfunction
    
