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
%%
%zoomOutAll: resets all axes to the original zoom
%@handles: current set of handles
function zoomOutAll_attack(handles)

%bitplanes image
axes(handles.imageBefore)          %set this axes as active
zoom out                            %perform zoom out
axes(handles.imagePreview)          %set this axes as active
zoom out                            %perform zoom out
axes(handles.imageAfter)          %...
zoom out
