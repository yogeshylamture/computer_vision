function binary = convert2binary(message_path)

[path name ext vrsn] = fileparts(message_path);

switch ext 
    case '.bmp'
    case '.jpg'
    case '.tiff'
    case '.gif'
    case '.txt'
        file = fopen(message_path,'r');
        message_file = fread(file,'*char');
        
        
        
        message_file_reshaped = reshape(message_file,1,size(message_file,1));
        %Convert the message to binary form - 0's and 1's
        binary = dec2bin(message_file_reshaped);
    otherwise
        binary = '';
        for i = 1:8
            random_bit = round(rand);
            binary = strcat(binary,num2str(random_bit));
        end
        
end
        

