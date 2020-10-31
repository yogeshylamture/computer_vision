function wm = detect_QIM(watermarked_image,delta,blocksize,key_text)


%         type = get_root_data('chosen_message');
%         switch type
%             case 'text'
%                 message = get_root_data('chosen_message_text');
%                 
%             case 'imag'
%                 message = get_root_data('chosen_message_image');
%             
%         end;

        %fetch the value of delta in the root data
        %delta = get_root_data('delta');
        
        %blocksize = 8;

%         type = get_root_data('chosen_message');
%         switch type
%             case 'text'
%                 message = get_root_data('chosen_message_text');
%                 %show the text detecting...
%                 %hide the textbox recovered message
%                 
%             case 'imag'
%                 message = get_root_data('chosen_message_image');
%                 %show the text detecting...
%                 %hide the axes recovered_message
% 
%         end;

%         %calculate the sizes of the messages
%         if(strcmp(type,'text'))
%             message_binary = dec2bin(message);
%             Mo=size(message_binary,1);                     %Height
%             No=size(message_binary,2);                     %Width
%         else
%             Mo=size(message,1);
%             No=size(message,2);
%         end

        % read in the watermarked object
        % determine size of watermarked image
        Mw=size(watermarked_image,1);	%Height
        Nw=size(watermarked_image,2);	%Width

        % determine maximum possible message size in object
        max_message=floor(Mw*Nw/blocksize);

        %type_key = get_root_data('chosen_key');
        %switch type_key
        %    case 'text'
        %        key = get_root_data('chosen_key_text');

        %    case 'imag'
        %        key = get_root_data('chosen_key_image');
        %end;
        
        %if(type_key == 'text')
        %    key_text = key;

            %calculate the average of all values in the key text file
            m = size(key_text,1);
            sum = 0;
            for i = 1:m
                sum = sum + key_text(i,1);
            end
            average = round(sum/m);
        %else
        %    key_image = key;

            %determine size of key image
        %    Mm=size(key_image,1);	%Height
        %    Nm=size(key_image,2);	%Width

            %calculate the average of all values in the key image file
        %    sum = 0;
        %    for i = 1:Mm
%                 for j = 1:Nm
%                     sum = sum + key_image(i,j);
%                 end
%             end
%             average = round(sum/(Mm*Nm));
%         end

        %reset MATLAB's PN generator to state with value 'average'
        rand('state',double(average));

        %generate dither vectors dither[0] and dither[1]
        dither0 = zeros(1, blocksize); %#ok<NASGU>
        dither1 = zeros(1, blocksize);
        
        dither0 = rand(1, blocksize)*delta - delta/2;
        for j = 1:blocksize
            if (dither0(1,j) < 0 == 1)
                dither1(1,j) = 5 + dither0(1,j);
            else
                dither1(1,j) = -5 + dither0(1,j);
            end
        end
        
        % pad message out to maximum message size with ones
        message_vector=ones(max_message,1);

        % process the image in blocks
        % for each block determine it's correlation with base pn sequence
        x=1;
        y=1;
        detector = zeros(1,blocksize);
        sum = 0;
        
        for kk = 1:length(message_vector)

            %reapply the dither vector dither0 and quantize
            
            detect_quantized0(y,x:(x+blocksize-1)) = round(( double(watermarked_image(y,x:(x+blocksize-1))) - dither0(1,1:8) )/ delta) * delta; %#ok<AGROW>
            detect0(y,x:(x+blocksize-1)) = detect_quantized0(y,x:(x+blocksize-1)) + dither0(1,1:8); %#ok<AGROW>
            
            %check if the difference is less than delta/4
            for l = 0:blocksize-1
                if ( detect0(y,x:(x+l)) - double(watermarked_image(y,x:(x+l))) < delta/4 )
                    detector(1,l+1) = 0;
                else
                    detector(1,l+1) = 1;
                end
            end
            
            %calculate the sum of all detected differences 
            for m = 1:blocksize
                sum = sum + detector(1,m);
            end
            
            %assign the correct bit to the detected message
            if ( sum < blocksize/2 )
                message_vector(kk) = 0;
            else
                message_vector(kk) = 1;
            end
            
            sum = 0;

            % move on to next block. At and of row move to next row
            if (x+2*blocksize-1) > Nw
                x = 1;
                if(y+1) > Mw
                    y = y;
                else
                    y = y + 1;
                end
            else
                x = x + blocksize;
            end
        end

        % reshape the message
        wm=reshape(message_vector(1:1*8),1,8);

%         if(strcmp(type,'text'))
%             message(1:Mo,1:No);
%             %hide the text/image detecting...
%             set(handles.text14,'Visible','off');
%             set(handles.recovered_message,'Visible','off');
%             %show the textbox recovered message
%             set(handles.text12,'Visible','on');
%             %first transform the O's and 1's to characters, then reshape the the
%             %characters to a horizontal string
%             message_reshaped = reshape( char(bin2dec(num2str(message(1:Mo,1:No)))), 1, Mo); 
%             set(handles.text12,'String',message_reshaped);
% 
%             set_root_data(handles,'detected_message',message_reshaped);
%         else
%             %hide the text detecting...
%             set(handles.text14,'Visible','off');
%             set(handles.text12,'Visible','off');
%             %show the axes recovered_message
%             set(handles.recovered_message,'Visible','on');
%             axes(handles.recovered_message);                             %show the image in the axes 'recovered_message'
%             imshow(message);                                             %show the image
%             axis equal;
%             axis tight;
%             axis off;
% 
%             set_root_data(handles,'detected_message',message);
%         end


