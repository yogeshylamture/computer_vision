function varargout=watermark_k(varargin)
%This feature adds a watermark of characters ( string) inside
%a past image as an input argument . You ' can specify
%Also a numeric key among the input arguments .
%Obligatory to have at least two input parameters:
%               [img_w,str]=watermark_k(img,stringa);
%Returns the watermarked " img_w " image and an optional string of
%" Str " error. Accepts the input image to which you would
%watermarking and the input string . And ' possible to add a third
%input parameter that represents the numeric key:
%                   watermark_k(img,stringa,key);


if length(varargin)<2           %Control the number of parameters passed in input
    return
elseif length(varargin)==3      %If a third parameter was specified:
    rand('seed',varargin{3});   %Fixed the seed of the rand
end

img=varargin{1};                %I acquire the first input parameter
stringa=varargin{2};            %I acquire the second input parameter


im=img(:);                      %Amount the image into a single column vector
if (length(stringa)+1)<=(length(im)/8)              %Check if the size is sufficient to accommodate the string
    im=bitand(im,uint8(ones(length(im),1)*254));    %Septum 0 to the least significant bit of each element of im
    t_im=uint8(zeros(length(im),1));                %I create a support carrier to temporarily make the changes
    
    if length(varargin)==3      %Check if there is a key:
        k=randperm(length(im)); %I create a vector of indices use randperm
    end
    
    for i=1:length(stringa)     %For each character in the string:
        for j=1:8                                   %For each bit of the single character:
            if length(varargin)==3                  %Check if it is a key presenre:
                index=k((i-1)*8 + j);               %Calculating the pixel index to edit
            else                                    %If there is the key:
                index=(i-1)*8 + j;                  %Calculating the pixel index to edit
            end
            b=bitget(uint8(stringa(i)),j);          %I acquire the j - th bit of the i -th character
            if(b==1)                                %If it is equal to 1:
                t_im(index)=bitset(t_im(index),1);  %Septum bit less significance of the pixels indicated by index
            end
        end
    end
    
    %Inserting a plug character ( string end ).
    for j=1:8                                       %For each bit of the cap character
            if length(varargin)==3                  %Control if you use a key:
                index=k(length(stringa)*8 + j);     %the index calculation
            else
                index=length(stringa)*8 + j;        %Calculating the indece without key
            end
            t_im(index)=bitset(t_im(index),1);      %Upgrading the bit t_im
    end

    r_im=bitor(im,t_im);                            %a bit or bits between bearing carrier and image carrier
    [x,y,z]=size(img);                              %acquire the image size
    img_w=reshape(r_im,x,y,z);                      %reconstruct the image watermarked
    
    varargout{1}=img_w;                             %return img_w
    varargout{2}='MESSAGE INSERTED!';             %do not restore errors
    
else                                                %If the image size is not sufficient to contain " string ":
        varargout{2}='String too long for selected Image!';       %Return an error 
end

end