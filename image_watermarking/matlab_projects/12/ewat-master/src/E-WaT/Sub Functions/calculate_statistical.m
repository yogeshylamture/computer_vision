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
%calculate_statistical: computes mes, psnr, ber and wsnr for the two passed
%images
%@original_image: non distorted image
%@distorted_image: distorted image
%§mse: mean squared error
%§psnr: peak signal to noise ratio
%§ber: bit error rate



function [MSE,PSNR,BER]=calculate_statistical(original_image ,distorted_image)


[oH oW oD] = size(original_image);       %get size of original image
[dH dW dD] = size(original_image);       %get size of distorted image

% MSE/BER
tempMSE = 0;                            %initialize tempMSE to zeros
BER = 0;
for i=1:min(oH, dH)
    for j=1:min(oW, dW)
        tempMSE = tempMSE + (original_image(i,j)*255-distorted_image(i,j)*255)^2;  %compute sum of MSE's of all pixels and multiply by 255 to get MSE in range 0..255
        if(original_image(i,j) ~= distorted_image(i,j))
            BER = BER + 1;
        end
    end
end
MSE = (tempMSE/(oH*oW));                  %divde tempMSE by nr of pixels to get mse 

% PSNR
MAX = 255;                              %define max pixel value (because of double images, it should be 1, but we multiplied MSE with 255, so max must be 255
PSNR = 10*log10(MAX^2/MSE);             %comute PSNR
if(PSNR == inf)
    PSNR = 70;
end

% BER
if (oH == dH && oW == dW)               %ori same size as distorted
    BER = BER/(oH*oW);
elseif(oH*oW < dH*dW)                   %ori smaller than distorted
    BER = (BER + (dH*dW-oH*oW))/Lo;
else                                    %ori bigger than distorted
    BER = (BER + (oH*oW-dH*dW))/Lo;
end
