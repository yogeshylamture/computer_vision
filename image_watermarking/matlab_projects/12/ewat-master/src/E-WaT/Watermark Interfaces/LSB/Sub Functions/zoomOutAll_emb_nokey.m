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

%bitplanes original image
axes(handles.ORIbitplane1)          %set this axes as active
zoom out                            %perform zoom out
axes(handles.ORIbitplane2)          %set this axes as active
zoom out                            %perform zoom out
axes(handles.ORIbitplane3)          %...
zoom out
axes(handles.ORIbitplane4)
zoom out
axes(handles.ORIbitplane5)
zoom out
axes(handles.ORIbitplane6)
zoom out
axes(handles.ORIbitplane7)
zoom out
axes(handles.ORIbitplane8)
zoom out
%%
%bitplanes watermarked image
axes(handles.WMbitplane1)
zoom out
axes(handles.WMbitplane2)
zoom out
axes(handles.WMbitplane3)
zoom out
axes(handles.WMbitplane4)
zoom out
axes(handles.WMbitplane5)
zoom out
axes(handles.WMbitplane6)
zoom out
axes(handles.WMbitplane7)
zoom out
axes(handles.WMbitplane8)
zoom out

%%
%watermark preview
axes(handles.WMPreview)
zoom out
%%
%original image
axes(handles.imageORI)
zoom out
%%
%watermarked image
axes(handles.imageWM)
zoom out
