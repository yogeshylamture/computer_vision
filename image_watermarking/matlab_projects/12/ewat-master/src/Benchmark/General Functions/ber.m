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

%ber: computes Bit Error Ratio between two images
%@original_image: original image
%@distorted_image: distorted image
%@b: bit error ratio

function b = ber(original_image, distorted_image)

[Ho Wo Do] = size(original_image);
[Hd Wd Dd] = size(distorted_image);

if(Ho ~= Hd && Wo ~= Wd)
    msgbox('Image sizes must match to compute ber', 'Error', 'error');
    b = 0000;
else
    dif = original_image == distorted_image;
    b = (Ho*Wo - sum(sum(sum(dif))))/(Ho*Wo);
end
 