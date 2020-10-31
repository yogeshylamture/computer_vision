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
%showBP_detector: display the bitplanes in the appropriate axes
%@handles: active set of handles
%%@im_bp:  matrix representing the 24 (=3*8) bitplanes of an image
function showBP_detector(handles, im_bp)


axes(handles.bitplane1);                        %set ORIbitplanex-axes as active
imshow(im_bp(:,:,1));                          %show image in axes
axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
axis tight;                                     %Sets the axis limits to the arrange of the data.
axis off;                                       %Turn off all axis labeling
axes(handles.bitplane2);
imshow(im_bp(:,:,2));
axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
axis tight;                                     %Sets the axis limits to the arrange of the data.
axis off;                                       %Turn off all axis labeling
axes(handles.bitplane3);
imshow(im_bp(:,:,3));
axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
axis tight;                                     %Sets the axis limits to the arrange of the data.
axis off;                                       %Turn off all axis labeling
axes(handles.bitplane4);
imshow(im_bp(:,:,4));
axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
axis tight;                                     %Sets the axis limits to the arrange of the data.
axis off;                                       %Turn off all axis labeling
axes(handles.bitplane5);
imshow(im_bp(:,:,5));
axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
axis tight;                                     %Sets the axis limits to the arrange of the data.
axis off;                                       %Turn off all axis labeling
axes(handles.bitplane6);
imshow(im_bp(:,:,6));
axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
axis tight;                                     %Sets the axis limits to the arrange of the data.
axis off;                                       %Turn off all axis labeling
axes(handles.bitplane7);
imshow(im_bp(:,:,7));
axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
axis tight;                                     %Sets the axis limits to the arrange of the data.
axis off;                                       %Turn off all axis labeling
axes(handles.bitplane8);
imshow(im_bp(:,:,8));
axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
axis tight;                                     %Sets the axis limits to the arrange of the data.
axis off;                                       %Turn off all axis labeling
