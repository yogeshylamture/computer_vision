%% Make watermark 
function [watermark] = make_watermark_dwt(blocksize,cover_work,message,type_message,key,type_key)

        %determine size of cover work
        Mc=size(cover_work,1);	%Height
        Nc=size(cover_work,2);	%Width

        if(type_message == 'text')

            %Convert the message to binary form - 0's and 1's
            message_binary = dec2bin(message);

            %determine maximum message size based on cover work, and blocksize
            max_message=floor(Mc*Nc/(blocksize^2));

            %Create a message string from the binary form and find the size
            message_string = num2str(message_binary);
            k = size(message_string,1);
            l = size(message_string,2);

            %reshape the message to a vector consisting of 0's and 1's
            %the command reshape will take the content from message and assign it to a
            %matrix [1,k*l]
            message_reshaped = reshape(message_string,1,k*l);

            %check that the message isn't too large for cover
            if (size(message_reshaped,2) > max_message)
                msgbox('Message is too large to fit in Cover Work','Message error','error')
                error('Message too large to fit in Cover Work')
            end

            %first fill up the message_vector with ones
            %then replace ones with message bits
            message_vector = ones(1,max_message);
            message_vector(1:k*l) = message_reshaped-48;            %minus 48 is necessary correction
            message_vector(1:k*l);
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
            Mm=size(message,1);	%Height
            Nm=size(message,2);	%Width

            %determine maximum message size based on cover work, and blocksize
            max_message=floor(Mc*Nc/(blocksize^2));

            %reshape the message to a vector consisting of 0's and 1's
            %the command reshape will take the content from message and assign it to a
            %matrix [Mm*Nm,1]
            message=round(reshape(message,Mm*Nm,1)./256);

            %check that the message isn't too large for cover
            if (length(message) > max_message)
                msgbox('Message is too large to fit in Cover Work','Message error','error')
                error('Message too large to fit in Cover Work')
            end

            %expand the message out to the maximum message size by adding 1's
            message_vector=ones(1,max_message);
            message_vector(1,1:length(message))=message;
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

        %generate PN sequences to implement "1" and "0"
        %all values are 0 or 1
        pn_sequence_one = round( rand(blocksize,blocksize) );
        pn_sequence_zero = ones(blocksize,blocksize) - pn_sequence_one; 
        %pn_sequence_one=round(2*(rand(blocksize,blocksize)-0.5));
        %pn_sequence_zero=round(2*(rand(blocksize,blocksize)-0.5));

        %find two highly un-correlated PN sequences
        %while (corr2(pn_sequence_one,pn_sequence_zero) > -0.1)
        %    pn_sequence_one=round(2*(rand(blocksize,blocksize)-0.5));
        %    pn_sequence_zero=round(2*(rand(blocksize,blocksize)-0.5));
        %end

        %process the image in blocks
        %first construct the global watermark mask
        x=1;
        y=1;
        watermark_mask = zeros(Mc,Nc);

        %For each bit in the message_vector, add a PN_sequence to the mask 
        for i = 1:size(message_vector,2)   
            workbar(i/size(message_vector,2),'Adding message...','Progress');

            %if message bit contains zero, add pn_sequence_zero to that portion of mask
            if (message_vector(1,i) == 0)
                watermark_mask(y:(y+blocksize-1),x:(x+blocksize-1)) = pn_sequence_zero;

            %otherwise add pn_sequence_one to portion of mask
            else
                watermark_mask(y:(y+blocksize-1),x:(x+blocksize-1)) = pn_sequence_one;
            end

            %move to next block of mask along x; If at end of row, move to next row
            if ((x+2*blocksize-1) > Nc)
                x=1;
                if ((y+2*blocksize-1) > Mc)
                    y = y;
                else
                    y=y+blocksize;
                end
            else
                x=x+blocksize;
            end
        end

        %return watermark_mask
        watermark = watermark_mask;