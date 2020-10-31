%% Make watermark
function [watermarked_image] = embed_correlation(embedding_parameters)

cover_work = embedding_parameters.image_layer;
message_vector = embedding_parameters.message_binary;
key = embedding_parameters.key_path;
% get secondary parameters
blocksize = embedding_parameters.var1;
embedding_strength = embedding_parameters.var2;
% var... dependent on the number of paramters




%determine size of cover work
Mc=size(cover_work,1);	%Height
Nc=size(cover_work,2);	%Width

%read in the message type
%[pathstr, mname, mext, versn] = fileparts(message);             

% switch mext
%     case '.txt'
%         type_message = 'text';
%     case '.jpg' 
%         type_message = 'imag';
%     case '.bmp' 
%         type_message = 'imag';
%     case '.gif'
%         type_message = 'imag';
%     case '.tiff'
%         type_message = 'imag';
% end

%read in the key type
[pathstr, kname, kext, versn] = fileparts(key);             

switch kext
    case '.txt'
        type_key = 'text';
    case '.jpg' 
        type_key = 'imag';
    case '.bmp' 
        type_key = 'imag';
    case '.gif'
        type_key = 'imag';
    case '.tiff'
        type_key = 'imag';
end


% if(type_message == 'text')
%     %read in the message text file
%     file_name = [mname mext];
%     k = fopen(file_name,'r');
%     message_file = char(fread(k)); %#ok<FREAD>
%     fclose(k);
%     message_file_reshaped = reshape(message_file,1,size(message_file,1));
%     
%     %Convert the message to binary form - 0's and 1's
%     message_binary = dec2bin(message_file_reshaped);
% 
%     %determine maximum message size based on cover work, and blocksize
%     max_message=floor(Mc*Nc/(blocksize^2));
% 
%     %Create a message string from the binary form and find the size
%     message_string = num2str(message_binary);
%     k = size(message_string,1);
%     l = size(message_string,2);
% 
%     %reshape the message to a vector consisting of 0's and 1's
%     %the command reshape will take the content from message and assign it to a
%     %matrix [1,k*l]
%     message_reshaped = reshape(message_string,1,k*l);
% 
%     %check that the message isn't too large for cover
%     if (size(message_reshaped,2) > max_message)
%         msgbox('Message is too large to fit in Cover Work','Message error','error')
%         error('Message too large to fit in Cover Work')
%     end
% 
%     %first fill up the message_vector with ones
%     %then replace ones with message bits
%     message_vector = ones(1,max_message);
%     message_vector(1:k*l) = message_reshaped-48;            %minus 48 is necessary correction
%     message_vector(1:k*l);
% else
%     %read in the message image file
%     mimage_file = [mname mext];
%     message = imread(char(mimage_file));
%     
%     [mH mW mD] = size(message);                                             %get size of message file
%         if (mD == 1 )                                                       %make sure that the images consist of 3 layers
%             message = cat(3, message, message, message);
%         elseif (mD == 2)
%             message = cat(2, message, message(:,:,2));
%         elseif (mD > 3)
%             message = message(1:3);
%         end
%     message = rgb2gray(uint8(message));                                     %convert message to grayscale (1 layer);
% 
%     %determine size of message image
%     Mm=size(message,1);	%Height
%     Nm=size(message,2);	%Width
% 
%     %determine maximum message size based on cover work, and blocksize
%     max_message=floor(Mc*Nc/(blocksize^2));
% 
%     %reshape the message to a vector consisting of 0's and 1's
%     %the command reshape will take the content from message and assign it to a
%     %matrix [Mm*Nm,1]
%     message=round(reshape(message,Mm*Nm,1)./256);
% 
%     %check that the message isn't too large for cover
%     if (length(message) > max_message)
%         msgbox('Message is too large to fit in Cover Work','Message error','error')
%         error('Message too large to fit in Cover Work')
%     end
% 
%     %expand the message out to the maximum message size by adding 1's
%     message_vector=ones(1,max_message);
%     message_vector(1,1:length(message))=message;
% end

if strcmp(type_key,'text')
    %read in the key text file
    file_name = [kname kext];
    k = fopen(file_name,'r');
    key_file = fread(k, '*char');
    fclose(k);
    key_file_reshaped = reshape(key_file,1,size(key_file,1));
    
    key_text = key_file_reshaped;

    %calculate the average of all values in the key text file
    m = size(key_text,1);
    sum = 0;
    for i = 1:m
        sum = sum + key_text(i,1);
    end
    average = round(sum/m);
else
    %read in the key image file
    image_file = [kname kext];
    im_key = imread(char(image_file));
    key_image = im_key;

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
pn_sequence_one=round( rand(blocksize,blocksize) );
pn_sequence_zero=ones(blocksize,blocksize) - pn_sequence_one; 

%process the image in blocks
%first construct the global watermark mask
x=1;
y=1;
watermark_mask = zeros(Mc,Nc);

%For each bit in the message_vector, add a PN_sequence to the mask 
for i = 1:size(message_vector,2)   
    %workbar(i/size(message_vector,2),'Adding message...','Progress');

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
        else
            y=y+blocksize;
        end
    else
        x=x+blocksize;
    end
end

%return watermarked_image
watermarked_image = cover_work + uint8(embedding_strength)*uint8(watermark_mask);
