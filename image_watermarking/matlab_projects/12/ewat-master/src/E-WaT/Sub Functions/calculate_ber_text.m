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
%calculate_ber: computes ber for two strings
%@original_text: non distorted image
%@distorted_text: distorted image
%§ber: bit error rate



function BER=calculate_ber_text(original_text, distorted_text)

Lo = length(original_text);             %get length of original text
Ld = length(distorted_text);            %get length of distorted text

% BER
BER = 0;
for i=1:min(Lo,Ld)
    if(original_text(i) ~= distorted_text(i))
        BER = BER + 1;
    end
end

if (Lo == Ld)
    BER = BER/Lo;
elseif(Lo < Ld)
    BER = (BER + (Ld-Lo))/Lo;
else
    BER = (BER + (Lo-Ld))/Lo;
end
    
