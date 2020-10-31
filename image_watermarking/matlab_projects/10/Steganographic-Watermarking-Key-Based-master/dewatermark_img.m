function varargout=dewatermark_img(varargin)
%This function performs a Watermark Extraction Operation
%image type inserted through the watermark_img function
%Accept at least one input parameter and returns a single parameter
% Output ( precisely image ) . Can accept any numerical key 
%also used during the step of watermarking
%                   img_log=dewatermark_img(img_w,key);

if length(varargin)==0                          %Control the number of parameters passed in input
    return
elseif length(varargin)==2                      %If a second parameter is specified:
    rand('seed',varargin{2});                   %Fixed the seed of the rand
    p=randperm(32);                             %create a vector of indices for the first 32 bits to be read
end

im_w=varargin{1}(:);                            %acquire the first input parameter and put it into a column vector

dim_l=0;                                        %It creates a variable that will put the size of the watermark
dim3_b=0;                                       %It creates a support variable that will hold the third dimension of the watermark bit

%START reading the header ( size of the watermark )
for j=1:2                                       %For each of the first two dimensions
    for i=1:15                                  %For each bit of the j-th dimension
        index=(j-1)*15 +i;                      %the linear index calculation for the pixels to be read
        if length(varargin)==2                  %Control if you are using a key:
          dim_b(i)=bitget(im_w(p(index)),1);    %acquire the i- th bit of the j-th dimension , p recovering from the pseudo-random index
        else
        dim_b(i)=bitget(im_w(index),1);         %Otherwise use the linear index
        end
    end
    dim_l(j)=bin2dec(num2str(dim_b));           %Convert to decimal the j -th dimension
    
    %Acquisition of the j - th bit of the third dimension
    if length(varargin)==2                      %Control if you are using a key:
        dim3_b(j)=bitget(im_w(p(30+j)),1);      %I acquire the j- th bit of the third dimension , p recovering from the pseudo-random index
    else
    dim3_b(j)=bitget(im_w(30+j),1);             %Otherwise use the linear index
    end
end
%END reading the header ( size of the watermark )
dim_l(3)=bin2dec(num2str(dim3_b));              %Convert to decimal the third dimension

len=prod(dim_l)+4;                              %the watermark including 4 bytes of the header size (in bytes )
im_log(prod(dim_l))=0;                          %I create a container for len - 4 pixels of the watermark
k=4;                                            %Put k=4 (32 bit already read)
if length(varargin)==2                          %Control if you are using a key:
   p=randperm(prod(dim_l)*8)+32;                %Calculating the pseudo-random indexes for subsequent pixels
end

%START reading the actual image
while k<len,                                    %Until we have not read all of the watermark pixels
    k=k+1;                                      %Increment k (+1 pixel)
    for j=1:8                                   %For each bit of the (k-4)-th pixel of the watermark
       index=(k-1)*8 + j;                       %the linear index calculation for the pixels to be read
       if length(varargin)==2                   %Control if you are using a key:
          b=bitget(im_w(p(index-32)),1);        %I acquire the j- th bit of the pixel to be read , recovering from the p pseudo-random index
       else
       b=bitget(im_w(index),1);                 %Otherwise use the linear index
       end
       
       if b==1                                  %If the acquired bit is equal to 1
        im_log(k-4)=bitset(im_log(k-4),j);      %Septum the j- th bit of the ( k - 4 ) -th pixels of the watermark,
       end
    end
end
%END real image reading and its

im_log=uint8(im_log);                           %Convert the values of im_log in whole

varargout{1}=reshape(im_log,dim_l(1),dim_l(2),dim_l(3));    %reconstruct arrays image watermark

end