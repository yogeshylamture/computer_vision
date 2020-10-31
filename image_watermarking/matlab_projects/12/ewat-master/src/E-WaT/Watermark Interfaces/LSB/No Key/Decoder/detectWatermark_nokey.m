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

%detectWatermark_nokey: searches for a watermark and displays the detected
%message by using the inverse algorithm of computeWatermark.m
%@handles: active set of handles
%@im_wm: watermarked (and possibly attacked) image
function detectWatermark_nokey(handles, im_wm)

set(handles.computingMessage, 'Visible', 'on');                             %show info message 'computing'
workbar(0.1, 'Searching for image watermark', 'Searching for image watermark');

im_bp_wm = im2bp(im_wm);

%bp 1
    
[messageType message_im message_t] = searchMessageNoKey(handles, im_bp_wm(:,:,1));

switch(messageType)
    case 'imag'
        set(handles.detMessTxt1, 'Visible', 'off');
        set(handles.detMessIm1, 'Visible', 'on')
        axes(handles.detMessIm1)
        imshow(message_im);
        axis equal
        axis tight
        axis off
    case 'text'
        set(handles.detMessTxt1, 'String' , message_t);
        set(handles.detMessTxt1, 'Visible', 'on');
        set(handles.detMessIm1, 'Visible', 'off');
end
workbar(0.125);

%bp 2
    
[messageType message_im message_t] = searchMessageNoKey(handles, im_bp_wm(:,:,2));

switch(messageType)
    case 'imag'
        set(handles.detMessTxt2, 'Visible', 'off');
        set(handles.detMessIm2, 'Visible', 'on')
        axes(handles.detMessIm2)
        imshow(message_im);
        axis equal
        axis tight
        axis off
    case 'text'
        set(handles.detMessTxt2, 'String' , message_t);
        set(handles.detMessTxt2, 'Visible', 'on');
        set(handles.detMessIm2, 'Visible', 'off');
end
set(handles.computingMessage, 'Visible', 'off');                            %hide info message 'computing'
workbar(0.25);

%bp 3
    
[messageType message_im message_t] = searchMessageNoKey(handles, im_bp_wm(:,:,3));

switch(messageType)
    case 'imag'
        set(handles.detMessTxt3, 'Visible', 'off');
        set(handles.detMessIm3, 'Visible', 'on')
        axes(handles.detMessIm3)
        imshow(message_im);
        axis equal
        axis tight
        axis off
    case 'text'
        set(handles.detMessTxt3, 'String' , message_t);
        set(handles.detMessTxt3, 'Visible', 'on');
        set(handles.detMessIm3, 'Visible', 'off');
end
set(handles.computingMessage, 'Visible', 'off');                            %hide info message 'computing'
workbar(0.375);

%bp 4
    
[messageType message_im message_t] = searchMessageNoKey(handles, im_bp_wm(:,:,4));

switch(messageType)
    case 'imag'
        set(handles.detMessTxt4, 'Visible', 'off');
        set(handles.detMessIm4, 'Visible', 'on')
        axes(handles.detMessIm4)
        imshow(message_im);
        axis equal
        axis tight
        axis off
    case 'text'
        set(handles.detMessTxt4, 'String' , message_t);
        set(handles.detMessTxt4, 'Visible', 'on');
        set(handles.detMessIm4, 'Visible', 'off');
end
set(handles.computingMessage, 'Visible', 'off');                            %hide info message 'computing'
workbar(0.5);

%bp 5
    
[messageType message_im message_t] = searchMessageNoKey(handles, im_bp_wm(:,:,5));

switch(messageType)
    case 'imag'
        set(handles.detMessTxt5, 'Visible', 'off');
        set(handles.detMessIm5, 'Visible', 'on')
        axes(handles.detMessIm5)
        imshow(message_im);
        axis equal
        axis tight
        axis off
    case 'text'
        set(handles.detMessTxt5, 'String' , message_t);
        set(handles.detMessTxt5, 'Visible', 'on');
        set(handles.detMessIm5, 'Visible', 'off');
end
set(handles.computingMessage, 'Visible', 'off');                            %hide info message 'computing'
workbar(0.625);

%bp 6
    
[messageType message_im message_t] = searchMessageNoKey(handles, im_bp_wm(:,:,6));

switch(messageType)
    case 'imag'
        set(handles.detMessTxt6, 'Visible', 'off');
        set(handles.detMessIm6, 'Visible', 'on')
        axes(handles.detMessIm6)
        imshow(message_im);
        axis equal
        axis tight
        axis off
    case 'text'
        set(handles.detMessTxt6, 'String' , message_t);
        set(handles.detMessTxt6, 'Visible', 'on');
        set(handles.detMessIm6, 'Visible', 'off');
end
set(handles.computingMessage, 'Visible', 'off');                            %hide info message 'computing'
workbar(0.75);

%bp 7
    
[messageType message_im message_t] = searchMessageNoKey(handles, im_bp_wm(:,:,7));

switch(messageType)
    case 'imag'
        set(handles.detMessTxt7, 'Visible', 'off');
        set(handles.detMessIm7, 'Visible', 'on')
        axes(handles.detMessIm7)
        imshow(message_im);
        axis equal
        axis tight
        axis off
    case 'text'
        set(handles.detMessTxt7, 'String' , message_t);
        set(handles.detMessTxt7, 'Visible', 'on');
        set(handles.detMessIm7, 'Visible', 'off');
end
set(handles.computingMessage, 'Visible', 'off');                            %hide info message 'computing'
workbar(0.875);

%bp 1
    
[messageType message_im message_t] = searchMessageNoKey(handles, im_bp_wm(:,:,8));

switch(messageType)
    case 'imag'
        set(handles.detMessTxt8, 'Visible', 'off');
        set(handles.detMessIm8, 'Visible', 'on')
        axes(handles.detMessIm8)
        imshow(message_im);
        axis equal
        axis tight
        axis off
    case 'text'
        set(handles.detMessTxt8, 'String' , message_t);
        set(handles.detMessTxt8, 'Visible', 'on');
        set(handles.detMessIm8, 'Visible', 'off');
end
set(handles.computingMessage, 'Visible', 'off');                            %hide info message 'computing'
workbar(1,0);
