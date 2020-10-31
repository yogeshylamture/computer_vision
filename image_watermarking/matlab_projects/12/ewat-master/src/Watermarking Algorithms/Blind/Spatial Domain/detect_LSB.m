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

function decoded_message = extract_LSB(decoder_settings)

%here normaly comes the LSB decoder
original_message = decoder_settings.message;
message_size = numel(original_message);
decoded_message = '';
for i=1:message_size
    random_bit = round(rand);        %calculate random ones and zeros
    decoded_message = strcat(decoded_message,num2str(random_bit));
end

