function varargout=watermark_img(varargin)
%This function inserts an image watermark within another 
%image passed as an input argument which you can also specify 
%a numeric key among the input arguments
%obligatory to have at least two input parameters:
%               [img_w,str]=watermark_img(img,img_logo);
%Returns the watermarked " img_w " image and an optional string of
%" Str " error. Accepts the input image to which you would
%watermark and the image (logo) to insert. And ' possible to add a 
%third input parameter that represents the numeric key:
%                   watermark_img(img,img_logo,key);

if length(varargin)<2                                   %Control the number of parameters passed in input
    return
elseif length(varargin)==3                              %If a third parameter was specified:
    rand('seed',varargin{3});                           %Fixed the seed of the rand
    p=randperm(32);                                     %create a vector of indices for the first 32 pixels to be modified
end

img=varargin{1};                                        %acquire the image from watermarkare
img_logo=varargin{2};                                   %acquire the image representing the watermark

dim=size(img_logo);                                     %get the size of the watermark


if prod(size(img)) >= (prod(dim)*8+32)                  %Control if img is sufficient to contain img_logo
        len=prod(dim)+4;                                %the watermark including 4 bytes of the header size (in bytes )


        im_w=img_logo(:);                               %Amount of the watermark image into a single column vector
        im=img(:);                                      %Amount of the image to be watermarkare , in a single column vector
        im=bitand(im,uint8(ones(length(im),1)*254));    %Septum 0 to the least significant bits of im

        %START input header ( size of the watermark )
        dim3=dec2bin(dim(3),2);                         %Convert binary third watermark image size
        for j=1:2                                       %For each of the first two dimensions
            bin=dec2bin(dim(j),15);                     %Convert to binary 15 bits the j -th dimension
            for i=1:15                                  %For each bit
                index=(j-1)*15 +i;                      %a linear index calculation
                if(bin(i)=='1')                         %Control if the i -th bit is equal to 1
                    if length(varargin)==3              %Control if you use a key:
                        im(p(index))=bitset(im(p(index)),1);    %If you are recovering from the p pseudo-random index and septal the least significant bit
                    else
                    im(index)=bitset(im(index),1);      %Otherwise use the linear index
                    end
                end
            end
            %
            if dim3(j)=='1'                             %Checking if the j - th bit of the third dimension is equal to 1
                if length(varargin)==3                  %Control if you use a key:
                    im(p(30+j))=bitset(im(p(30+j)),1);  %If you are recovering from the p pseudo-random index and septal the least significant bit
                else
                im(30+j)=bitset(im(30+j),1);            %Otherwise use the linear index
                end
            end
        end
        %END input header ( size of the watermark )
        
        k=4;                                            %place k=4 (32 pixels already modified!)
        if length(varargin)==3                          %Control if you use a key:
            p=randperm(length(im_w)*8)+32;              %Calculating the pseudo-random indexes for subsequent pixels
        end
        
        %START entering the actual image
        while k<len,                                    %Until you reach the entire length len                 
            k=k+1;                                      %Increment k (+1 pixel)
            for j=1:8                                   %For each bit of the k - th pixel
               index=(k-1)*8 + j;                       %Calculating the linear index of the pixels to be changed
               b=bitget(im_w(k-4),j);                   %I get the pixels from the j - th bit watermarkare
               if(b==1)                                 %If it is equal to 1
                   if length(varargin)==3               %Control if you use a key:
                       im(p(index-32))=bitset(im(p(index-32)),1);   %If you are recovering from the p pseudo-random index and septal the least significant bit
                   else
                   im(index)=bitset(im(index),1);       %Otherwise use the linear index
                   end
               end
            end

        end
        %FINE inserimento dell'immagine vera e propria
        
        [x,y,z]=size(img);                              %I get the size of the watermarked
        varargout{1}=reshape(im,x,y,z);                 %Reconstruct matrices
        varargout{2}='MESSAGE INSERTED';             %I do not restore any error
        
else    %If the image size is not sufficient to contain the watermark:
        varargout{2}='Cover Image insufficient for containing Message!'; %Return an error
end

end