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
function zoomOutAll_det_nokey(handles)

%bitplanes image
axes(handles.bitplane1)          %set this axes as active
zoom out                            %perform zoom out
axes(handles.bitplane2)          %set this axes as active
zoom out                            %perform zoom out
axes(handles.bitplane3)          %...
zoom out
axes(handles.bitplane4)
zoom out
axes(handles.bitplane5)
zoom out
axes(handles.bitplane6)
zoom out
axes(handles.bitplane7)
zoom out
axes(handles.bitplane8)
zoom out

%%
%watermarked image
axes(handles.image)
zoom out

%%
%detected message
axes(handles.detectedMessage)
zoom out

axes(handles.messageOriginal_im);
zoom out

