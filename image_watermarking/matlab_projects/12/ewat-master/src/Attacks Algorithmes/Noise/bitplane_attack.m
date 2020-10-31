%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                           Hogeschool Antwerpen                          %
%                Industriële Wetenschappen: Elektronica-ICT               %
%                      MultiMediaGroep - Watermarking                     %
%                                                                         %
%                                                                         %
%                             Masterthesis 4.2                            %
%                               Kevin Heylen                              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%bitplane_attack: replaces bitplane with noise
%@image: image of which a bitplane will be replace
%@bitplane: the bitplanes to replace (e.g. 7 will replace bitplane LSB

function im_bp_replaced = bitplane_attack(image, bitplane)

try
    [H W D] = size(image);                                  %get size of image
    randn('state', sum(100*clock));                         %initialise random generator
    noise_bp = ((randn(H, W) < 0));                           %generate random pattern)

    im_bp_replaced = image; 

    for k = 1:D
       im_bp_replaced(:,:,:) = bitset(image(:,:,:), 9-bitplane,noise_bp(:,:));
    end
catch
    im_bp_replaced = image;
end

