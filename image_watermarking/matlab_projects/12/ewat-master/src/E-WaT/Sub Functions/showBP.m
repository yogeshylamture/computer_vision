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
%showBP: display the bitplanes in the appropriate axes
%@handles: active set of handles
%@graph: which set of graphs to display the bitplanes in
%@im_bp: 3D matrix representing the 24 (=3*8) bitplanes of an image
function showBP(handles, graph, im_bp)
switch graph
    case 'original'                                     %im_bp contains the bitplanes of the original image, so we need to display it in the original axes
        set(handles.titleOriginal, 'Visible', 'on');    %show title
        set(handles.ORIbitplane1, 'Visible', 'on');     %show bitplane axes
        set(handles.ORIbitplane2, 'Visible', 'on');
        set(handles.ORIbitplane3, 'Visible', 'on');
        set(handles.ORIbitplane4, 'Visible', 'on');
        set(handles.ORIbitplane5, 'Visible', 'on');
        set(handles.ORIbitplane6, 'Visible', 'on');
        set(handles.ORIbitplane7, 'Visible', 'on');
        set(handles.ORIbitplane8, 'Visible', 'on');
        set(handles.cb1, 'Visible', 'on');              %show check boxes to select bitplanes
        set(handles.cb2, 'Visible', 'on');
        set(handles.cb3, 'Visible', 'on');
        set(handles.cb4, 'Visible', 'on');
        set(handles.cb5, 'Visible', 'on');
        set(handles.cb6, 'Visible', 'on');
        set(handles.cb7, 'Visible', 'on');
        set(handles.cb8, 'Visible', 'on');
        
        axes(handles.ORIbitplane1);                     %set ORIbitplanex-axes as active
        imshow(im_bp(:,:,1));                          %show image in axes
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.ORIbitplane2);
        image(im_bp(:,:,2));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.ORIbitplane3);
        image(im_bp(:,:,3));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.ORIbitplane4);
        image(im_bp(:,:,4));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.ORIbitplane5);
        image(im_bp(:,:,5));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.ORIbitplane6);
        image(im_bp(:,:,6));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.ORIbitplane7);
        image(im_bp(:,:,7));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.ORIbitplane8);
        image(im_bp(:,:,8));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
    case 'WM'                                           %im_bp contains the bitplanes of the watermarked image, so we need to display it in the watermarked axes
        set(handles.titleWMImage, 'Visible', 'on');     %show title
        set(handles.WMbitplane1, 'Visible', 'on');      %show bitplane axes    
        set(handles.WMbitplane2, 'Visible', 'on');
        set(handles.WMbitplane3, 'Visible', 'on');
        set(handles.WMbitplane4, 'Visible', 'on');
        set(handles.WMbitplane5, 'Visible', 'on');
        set(handles.WMbitplane6, 'Visible', 'on');
        set(handles.WMbitplane7, 'Visible', 'on');
        set(handles.WMbitplane8, 'Visible', 'on');
        
        axes(handles.WMbitplane1);                      %set WMbitplanex-axes as active
        imshow(im_bp(:,:,1));                           %show image in axes
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.WMbitplane2);
        imshow(im_bp(:,:,2));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.WMbitplane3);
        imshow(im_bp(:,:,3));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.WMbitplane4);
        imshow(im_bp(:,:,4));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.WMbitplane5);
        imshow(im_bp(:,:,5));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.WMbitplane6);
        imshow(im_bp(:,:,6));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.WMbitplane7);
        imshow(im_bp(:,:,7));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling
        axes(handles.WMbitplane8);
        imshow(im_bp(:,:,8));
        axis equal;                                     %sets the aspect ratio. (Show the image in its right ratio)
        axis tight;                                     %Sets the axis limits to the arrange of the data.
        axis off;                                       %Turn off all axis labeling   
    otherwise                                           %when wrong graph argument passed
        figure                                          %create new figure    
        imshow(im_bp);                                  %display image in new figure 
end

