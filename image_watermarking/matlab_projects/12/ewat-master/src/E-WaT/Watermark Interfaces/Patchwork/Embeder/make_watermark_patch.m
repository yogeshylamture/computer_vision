function [watermark,sequence] = make_watermark_patch (blocksize,message_bit,cover_work)

        %determine the size of the cover work
        Mc = size(cover_work, 1);       %Height
        Nc = size(cover_work, 2);       %Width

        %Read in the type of key and the key itself
        type_key = get_root_data('chosen_key');
        switch type_key
            case 'text'
                key = get_root_data('chosen_key_text');

            case 'imag'
                key = get_root_data('chosen_key_image');
        end;

        %Calculate the average value of the key
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

        %reset Matlab's Pseudo Random Number Generator (PRNG) to state with initial
        %value average
        rand('state', double(average));

        %Read in the chosen type of message and the message itself
        attack = get_root_data('attack');
        switch attack
            case 'no'
                messageType = get_root_data('chosen_message');
                switch messageType
                    case 'text'
                        message = get_root_data('chosen_message_text');
                    case 'imag'
                        message = get_root_data('chosen_message_image');
                end;
            otherwise
                messageType = get_root_data('chosen_message');
                switch messageType
                    case 'text'
                        message = get_root_data('chosen_message_text_attack');
                    case 'imag'
                        message = get_root_data('chosen_message_image_attack');
                end;
        end;
        
        if(messageType == 'text')

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
            length_message = k*l;
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
            length_message = length(message);
        end
        
        %first construct the global watermark mask
        watermark_mask = zeros(Mc, Nc);
        
        %Create a variable to store the coordinates of the watermarked
        %pixels
        sequence = zeros(1,length_message*4);
        j = 1;
        
        Bv = floor(Mc/blocksize);        %Number of vertical blocks
        Bh = floor(Nc/blocksize);        %Number of horizontal blocks
        
        %Create a variable to check if this patch is already watermarked
        patch_used = zeros(Bv,Bh);
        
        for(i = 1:length_message)
            workbar(i/length_message,'Adding message...','Progress');
            if ( message_bit == 1 )

               %Choose a first random block
               ax = ceil(rand*Bv);
               ay = ceil(rand*Bh);
               
               %Check if the patch is already watermarked
               while( patch_used(ax,ay) == 1)
                    ax = ceil(rand*Bv);
                    ay = ceil(rand*Bh);
               end
               
               patch_used(ax,ay) = 1;
               
               %Choose a second block with an approximate equal value
               by = ay; 
               
               if (ax > 1)
                   bx = ax - 1;
               else
                   bx = ax + 1;
               end
               
               %Check if the patch is already watermarked
               while( patch_used(bx,by) == 1)
                   bx = ceil(rand*Bv);
                   by = ceil(rand*Bh);
               end
               
               %Change the value into 1 to show that this patch will be
               %watermarked
               patch_used(bx,by) = 1;
               
               sequence(1,j) = ax;
               sequence(1,j+1) = ay;
               sequence(1,j+2) = bx;
               sequence(1,j+3) = by;
               j = j + 4;

               %Apply the values to the selected pair of blocks
               watermark_mask(ax*blocksize-blocksize+1:ax*blocksize,ay*blocksize-blocksize+1:ay*blocksize) = 1;
               watermark_mask(bx*blocksize-blocksize+1:bx*blocksize,by*blocksize-blocksize+1:by*blocksize) = -1;
            else 

               %Choose a first random block
               ax = ceil(rand*Bv);
               ay = ceil(rand*Bh);
               
               %Check if the patch is already watermarked
               while( patch_used(ax,ay) == 1)
                    ax = ceil(rand*Bv);
                    ay = ceil(rand*Bh);
               end
               
               patch_used(ax,ay) = 1;
               
               %Choose a second block with an approximate equal value
               by = ay; 
               
               if (ax > 1)
                   bx = ax - 1;
               else
                   bx = ax + 1;
               end
               
               %Check if the patch is already watermarked
               while( patch_used(bx,by) == 1)
                   bx = ceil(rand*Bv);
                   by = ceil(rand*Bh);
               end
               
               %Change the value into 1 to show that this patch will be
               %watermarked
               patch_used(bx,by) = 1;
               
               sequence(1,j) = ax;
               sequence(1,j+1) = ay;
               sequence(1,j+2) = bx;
               sequence(1,j+3) = by;
               j = j + 4;

               %Apply the values to the selected pair of blocks
               if (message_vector(1,i) == 1)
                    watermark_mask(ax*blocksize-blocksize+1:ax*blocksize,ay*blocksize-blocksize+1:ay*blocksize) = 1;
                    watermark_mask(bx*blocksize-blocksize+1:bx*blocksize,by*blocksize-blocksize+1:by*blocksize) = -1;
               else
                    watermark_mask(ax*blocksize-blocksize+1:ax*blocksize,ay*blocksize-blocksize+1:ay*blocksize) = -1;
                    watermark_mask(bx*blocksize-blocksize+1:bx*blocksize,by*blocksize-blocksize+1:by*blocksize) = 1;
               end
            end
        end
        
        watermark = watermark_mask;