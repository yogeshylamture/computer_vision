function bitword=dewatermark_k(varargin)
%This function performs a watermark extraction operation
%string , inserted through the watermark_k function
%Accept at least one input parameter and returns a single parameter
%output ( the string of course) . Can accept any numerical key 
%also used during the step of watermarking.
%                    bitword=dewatermark_k(img_w,key);



if length(varargin)==0                          %Control the number of parameters passed in input
    return
elseif length(varargin)==2                      %If a second parameter is specified:
    rand('seed',varargin{2});                   %Fixed the seed of the rand
end

img_w=varargin{1};                              %I acquire the first input parameter

i=1;                                            %I create and initialize an index to 1
flag=0;                                         %I create and initialize a flag to 0
im=img_w(:);                                    %Amount the image into a single column vector
bitword=[''];                                   %Create the container for the string

if length(varargin)==2                          %Control if you are using a key:
    k=randperm(length(im));                     %I create a vector of indices use randperm
end

while (i<=length(im))&&(flag==0),               %Until we do not analyze the entire image and do not find the cap character:
    bitchar=uint8(0);                           %clean bitchar variable
    for j=1:8                                   %Operations performed 8 pixels at a time
        if length(varargin)==2                  %Control if you are using a key:
            index=k((i-1) + j);                 %Calculating the pixel index to read
        else
            index=(i-1) + j;                    %Calculating the pixel index to read
        end
        b=bitget(im(index),1);                  %extract the least significant bit
        if(b==1)                                %If it is equal to 1
            bitchar=bitset(bitchar,j);          %Septum the bitchar character j - th bit
        end
    end
    if(bitchar==255)                            %Check if the character read is the cap
        flag=1;                                 %If you have set flag to 1
    else
        b_index=(i-1)/8 +1;                     %Otherwise the calculation of the position of the character in the string index
        bitword(b_index)=char(bitchar);         %Update the string
        i=i+8;                                  %Update the counter
    end

end

end