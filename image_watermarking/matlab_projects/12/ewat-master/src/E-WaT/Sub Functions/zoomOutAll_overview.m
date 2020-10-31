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
function zoomOutAll_emb_nokey(handles)

axes(handles.axes1_original)          %set this axes as active
zoom out                            %perform zoom out
axes(handles.axes1_watermarked)          %set this axes as active
zoom out                            %perform zoom out
axes(handles.axes2_watermarked)
zoom out
axes(handles.axes2_attacked)          %...
zoom out
axes(handles.axes3_original)          %...
zoom out
axes(handles.axes3_attacked)          %...
zoom out
axes(handles.axes4_embed)          %...
zoom out
axes(handles.axes4_detected)          %...
zoom out



