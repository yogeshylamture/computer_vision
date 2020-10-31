%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                           Hogeschool Antwerpen                          %
%                IndustriŽle Wetenschappen: Elektronica-ICT               %
%                      MultiMediaGroep - Watermarking                     %
%                                                                         %
%                                                                         %
%                             Bachelorproef 3.2                           %
%              Kevin Heylen - Tom Meesters - Luc Verstrepen               %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [messageType message_im message_t] = searchMessageNoKey(handles, cover)


attack = get_root_data('attack');

switch(attack)
    case 'yes'
        messageType = get_root_data('chosen_message_attack');
        switch(messageType)
            case 'text'
                message = get_root_data('chosen_message_text_attack');
            otherwise
                message = get_root_data('chosen_message_image_attack');
        end
    otherwise
        messageType = get_root_data('chosen_message');
         switch(messageType)
            case 'text'
                message = get_root_data('chosen_message_text');
             otherwise
                 message = get_root_data('chosen_message_image');
        end
end


switch messageType
    case 'imag'
        % SEARCH FOR IMAGE
        message = get_root_data('embedded_message');
        [mH mW mD] = size(message);
        [cH cW cD] = size(cover);                                                   %get size of cover work
        blocksize = get_root_data('blocksize');                          %floor(get(handles.sliderBlocksize, 'Value'));
        messageFound_im = false;                                                       %initialize messageFound to false
        L = mH;                                                                      %intialize L to 1 (messagelength = 1)
        K = mW;
        [message_im maxCounts_im] = searchImage(handles, L, K, blocksize, cover);                                 %call search message function to determine any message
        messageFound_im = true;
        if(sum(sum(maxCounts_im)) > 0)
            messageFound_im = true;
        else
            messageFound_im = false;
        end
        message_t = 0;

    case 'text'

        %SEARCH FOR TEXT MESSAGE
    [cH cW cD] = size(cover);                                                   %get size of cover work
    [aH aW aD] = size(alphabet('a'));                                           %determine size of character matrices (all characters should have same size)
    L = length(message);                                                                      %intialize L to 1 (messagelength = 1)
    messageFound_t = false;                                                       %initialize messageFound to false
    [message_t maxCounts_t] = searchMessage(handles, L, cover);                                 %call search message function to determine any message
    count = 0;
    for i=1:L
        if(message(i) == '?')
            count = count + 1;
        end
    end
    if(count == L)
        messageFound_t = false;
    else
        messageFound_t = true;
    end
    message_im = 0;
end