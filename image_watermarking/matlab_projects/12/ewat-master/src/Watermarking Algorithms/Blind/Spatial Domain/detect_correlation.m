function [recovered_message] = detect_correlation(watermarked_image,message,key,blocksize)

%read in the message type
[pathstr, mname, mext, versn] = fileparts(message);             

switch mext
    case '.txt'
        type_message = 'text';
    case '.jpg' 
        type_message = 'imag';
    case '.bmp' 
        type_message = 'imag';
    case '.gif'
        type_message = 'imag';
    case '.tiff'
        type_message = 'imag';
end

if(type_message == 'text')
    %read in the message text file
    file_name = [mname mext];
    k = fopen(file_name,'r');
    message_file = char(fread(k)); %#ok<FREAD>
    fclose(k);
    message_file_reshaped = reshape(message_file,1,size(message_file,1));
    
    %Convert the message to binary form - 0's and 1's
    message_binary = dec2bin(message_file_reshaped);

    %determine size of message
    [Mo,No] = size(message_binary);
else
    %read in the message image file
    mimage_file = [mname mext];
    message = imread(char(mimage_file));
    
    [mH mW mD] = size(message);                                             %get size of message file
        if (mD == 1 )                                                       %make sure that the images consist of 3 layers
            message = cat(3, message, message, message);
        elseif (mD == 2)
            message = cat(2, message, message(:,:,2));
        elseif (mD > 3)
            message = message(1:3);
        end
    message = rgb2gray(uint8(message));                                     %convert message to grayscale (1 layer);
    
    %determine size of message
    [Mo,No] = size(message);
end

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

if(strcmp(type_key,'text'))
    %read in the key text file
    file_name = [kname kext];
    k = fopen(file_name,'r');
    key_file = fread(k, '*char');
    fclose(k);
    key_file_reshaped = reshape(key_file,1,size(key_file,1));
    
    key_text = key_file_reshaped;

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

sequence_zero = pn_sequence_zero;
sequence_one = pn_sequence_one;

% determine size of watermarked image
Mw=size(watermarked_image,1);	%Height
Nw=size(watermarked_image,2);	%Width

% determine maximum possible message size in object
max_message=floor(Mw*Nw/(blocksize^2));

% pad message out to maximum message size with ones
message_vector=ones(max_message,1);

% process the image in blocks
% for each block determine it's correlation with base pn sequence
x=1;
y=1;
for i = 1:length(message_vector)

    workbar(i/length(message_vector),'Detecting the message...','Progress');

    % calculate correlations for both PN sequences
    correlation_one=corr2(watermarked_image(y:y+blocksize-1,x:x+blocksize-1),pn_sequence_one);
    correlation_zero=corr2(watermarked_image(y:y+blocksize-1,x:x+blocksize-1),pn_sequence_zero);

    % choose which ever correlation is higher
    if (correlation_one > correlation_zero)
        message_vector(i)=1;
    else
        message_vector(i)=0;
    end

    % move on to next block. At and of row move to next row
    if (x+2*blocksize-1) > Nw
        x = 1;
        if(y+2*blocksize-1) > Mw
        else
            y = y + blocksize;
        end
    else
        x = x + blocksize;
    end
end

% reshape the message
message = reshape(message_vector(1:Mo*No),Mo,No);

if strcmp(type_message,'text')
    %first transform the O's and 1's to characters, then reshape the the
    %characters to a horizontal string
    recovered_message = reshape( char(bin2dec(num2str(message(1:Mo,1:No)))), 1, Mo);
else
    recovered_message = message(1:Mo,1:No);
end
