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
%@string1: original image
%@string2: distorted image
%@b: bit error ratio

function b = ber(string1, string2)

[Ho Wo Do] = size(string1);
[Hd Wd Dd] = size(string2);

if(Ho ~= Hd && Wo ~= Wd)
    b = 0000;
else
    dif = string1 == string2;
    b = (Ho*Wo - sum(sum(sum(dif))))/(Ho*Wo);
end
 