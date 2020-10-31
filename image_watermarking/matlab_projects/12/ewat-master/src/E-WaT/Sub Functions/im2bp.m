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
%im2bp: splits an image into bitplanes (8) and return bitplanes by a  matrix
%@im: original image (1 layer)
%§im_bp: bitplane matrix (W * H * nr of bitplanes)
function im_bp = im2bp(im)

workbar(0.1, 'Converting image to bitplanes', 'Converting image to bitplanes...');
[W H D] = size(im);         %determine size 
im_bp = zeros(W,H,8);      %create matrix with same size as im, but with depth 24 (=8*3). 
                            %We work with 24 because we need 3 layers to
                            %display the function. Therefor we create one
                            %bitplane and copy this into the next two
                            %bitplanes (k:k+2). Thus every bitplane consists
                            %of three 'layers' of the im_bp matrix.
if(max(im) <= 1)
    im = im*255;
end
im = uint8(im);             %convert im to uint8 (if not allready uint8)
for k=1:1:8
    im_bp(:,:,k) = bitget(im(:,:),(9-k))*255;  %multiply with 255 to convert to appropriate range (0-255) to display image
    workbar(k/8);
end                                                     

im_bp = uint8(im_bp);       %convert im_bp to uint8
workbar(1.0);