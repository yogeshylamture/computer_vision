
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                           Hogeschool Antwerpen                          %
%                Industriële Wetenschappen: Elektronica-ICT               %
%                      MultiMediaGroep - Watermarking                     %
%                                                                         %
%                                                                         %
%                             Bachelorproef 3.2                           %
%              Kevin Heylen - Tom Meesters - Luc Verstrepen               %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%bitplanes_to_watermark: determine which bitplanes are selected to be
%watermarked
%@handles: current set of handles
%@BP: selected biptlanes

function BP = bitplanes_to_watermark(handles)

N = zeros(1,8);                                         %check wich checkboxes are checked and put selected bitplanes in array N
i = 1;
if(get(handles.cb1, 'Value') == 1.0) 
    N(i) = 1;
    i = i+1;
end
if(get(handles.cb2, 'Value') == 1.0) 
    N(i) = 2;
    i = i+1;
end
if(get(handles.cb3, 'Value') == 1.0) 
    N(i) = 3;
    i = i+1;
end
if(get(handles.cb4, 'Value') == 1.0) 
    N(i) = 4;
    i = i+1;
end
if(get(handles.cb5, 'Value') == 1.0) 
    N(i) = 5;
    i = i+1;
end
if(get(handles.cb6, 'Value') == 1.0) 
    N(i) = 6;
    i = i+1;
end
if(get(handles.cb7, 'Value') == 1.0) 
    N(i) = 7;
    i = i+1;
end
if(get(handles.cb8, 'Value') == 1.0) 
    N(i) = 8;
end

BP = N;