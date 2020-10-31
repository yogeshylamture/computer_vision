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

%setIcon: displays an image im an a uicontrol uicntrl with size H x W. This
%way it is possible to put an image on a pushbutton 
%@uicntrl: uicontrol  to put the image on (e.g. handles.pushbutton1)
%@im: image to display
%@H: height of icon to display (not of im)
%@W: widht if icon to display (not of im)
function setIcon(uicntrl, im, H, W)

%Determine how much data will be lost converting im to a W x H icon
[m n d] = size(im);                     %get size of im
m_skip = ceil(m/H);                     %determine how many pixels to skip vertically
n_skip = ceil(n/W);                     %determine how many pixels to skip horizontally   

% Create the HxW icon (RGB data)
if(d == 1)
    im = cat(3, im, im, im);            %if im is 1-layered, make it 3 layered by copying the first layer three times
end
icn = zeros(H,W,3);                     %create 3 layered empty icon with size H x W
icn = im(1:m_skip:end,1:n_skip:end,:);  %fill icon with image data
%icn = uint8(icn);                       %convert icn to uint8     

set(uicntrl,'cdata',icn);               %show icon on the uicontrol

