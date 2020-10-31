%% Make watermark
function [watermark, random_noise_pattern] = make_watermark_cdma(cover_work,message,type_message,key,type_key)

        %determine size of cover work
        Mc=size(cover_work,1);	%Height
        Nc=size(cover_work,2);	%Width

        if(type_message == 'text')

            %Convert the message to binary form - 0's and 1's
            message_binary = dec2bin(message);

            %Create a message string from the binary form and find the size
            message_string = num2str(message_binary);
            k = size(message_string,1);
            l = size(message_string,2);
            message_length = k*l;

            %reshape the message to a vector consisting of 0's and 1's
            %the command reshape will take the content from message and assign it to a
            %matrix [1,k*l]
            message_reshaped = reshape(message_string,1,k*l);

            %first fill up the message_vector with ones
            %then replace ones with message bits
            message_vector = ones(1,message_length);
            message_vector = message_reshaped-48;            %minus 48 is necessary correction
        else
            [mH mW mD] = size(message);                                             %get size of message file
                if (mD == 1 )                                                       %make sure that the images consist of 3 layers
                    message = cat(3, message, message, message);
                elseif (mD == 2)
                    message = cat(2, message, message(:,:,2));
                elseif (mD > 3)
                    message = message(1:3);
                end
            message = rgb2gray(uint8(message));                                     %convert message to grayscale (1 layer);

            %determine size of message image
            Mm = size(message,1);	%Height
            Nm = size(message,2);	%Width

            %determine maximum message size based on cover work, and blocksize
            message_length = Mm*Nm;

            %reshape the message to a vector consisting of 0's and 1's
            %the command reshape will take the content from message and assign it to a
            %matrix [Mm*Nm,1]
            message = round(reshape(message,1,Mm*Nm)./256);

            %expand the message out to the maximum message size by adding 1's
            message_vector = ones(1,message_length);
            message_vector = message;
        end

        if(type_key == 'text')
            key_text = key;

            %calculate the average of all values in the key text file
            m = size(key_text,1);
            sum = 0;
            for i = 1:m
                sum = sum + key_text(i,1);
            end
            average = round(sum/m);
        else
            key_image = key;

            %determine size of key image
            Mm=size(key_image,1);	%Height
            Nm=size(key_image,2);	%Width

            %calculate the average of all values in the key image file
            sum = 0;
            for i = 1:Mm
                for j = 1:Nm
                    sum = sum + key_image(i,j);
                end
            end
            average = round(sum/(Mm*Nm));
        end

        %reset MATLAB's PN generator to state with value 'average'
        rand('state',double(average)); 

        %process the image in blocks
        %first construct the global watermark mask
        x=1;
        y=1;
        watermark_mask = zeros(Mc,Nc);
        
        %create a random pattern matrix
        rp = zeros(Mc,Nc);

        %For each bit in the message_vector, add a PN_sequence to the mask 
        for i = 1:size(message_vector,2)   
            workbar(i/size(message_vector,2),'Adding message...','Progress');

            %generate a random noise pattern
            rp = rand(Mc,Nc);
            for j = 1:Mc
                for k = 1:Nc
                    if (rp(j,k) < 0.5)
                        rp(j,k) = -1;
                    else
                        rp(j,k) = 1;
                    end
                end
            end
            
            %if message bit contains zero, add the random noise pattern
            if (message_vector(1,i) == 0)
                watermark_mask = watermark_mask + rp;

            %otherwise subtract the random noise pattern from the mask
            else
                watermark_mask = watermark_mask - rp;
            end

        end

        %return watermark_mask
        watermark = watermark_mask;
        random_noise_pattern = rp;
        