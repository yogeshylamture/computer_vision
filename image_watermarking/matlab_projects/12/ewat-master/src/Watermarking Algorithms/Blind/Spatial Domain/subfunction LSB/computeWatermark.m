%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                           Hogeschool Antwerpen                          %
%                Industriële Wetenschappen: Elektronica-ICT               %
%                      MultiMediaGroep - Watermarking                     %
%                                                                         %
%                                                                         %
%                             Bachelorproef 3.2                           %
%              Kevin Heylen - Tom Meesters - Luc Verstrepen               %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function wm = computeWatermark(message_binary, cover, key, blocksize)
%computeWatermark: computes the watermark that will be embedded
%@messageFile: image, source file for message
%@type: type of source file ('text' or 'image')
%@cover: image, cover work
%@key: integer, key used to become security
%@blocksize: integer, determines how many pixel of the cover work will be used to
%            embed one message bit or character
%@wm: image, watermark that will be embed


[cH cW cD] = size(cover);
%randn('state', key);
pattern1 = randn(blocksize) > 0;
pattern0 = pattern1';
% for j=1:blocksize
%     for k=1:blocksize
%         if(pattern1(j,k) == 1)
%             pattern0(j,k) = 0;
%         else
%             pattern0(j,k) = 1;
%         end
%     end
% end
wm = randn(cH, cW)>0;

% switch(type)
%     case 'image'
%         messageFile = im2bw(messageFile);
%         m = zeros(cH, cW);
%         m = messageFile(1:min(floor(cH/blocksize), end), 1:min(floor(cW/blocksize), end));
%         [mH mW mD] = size(m);
%         message = zeros(1,mH*mW);
%         %convert image to 1D vector
%         for i=1:mH
%             for j=1:mW
%                 message((i-1)*mW+j  ) = m(i,j);
%             end
%         end
%    case 'text'
        mx = floor(cH/blocksize)*floor(cW/blocksize);
%         message_ = dec2bin(messageFile);
         [mH mW mD] = size(message_binary);
%         message = '';
%         for i=1:mH
%             message = strcat(message, strcat(message_(i,:)));
%         end
        message = message_binary(1:min(mH*mW, mx));
        m = zeros(1,min(mH*mW, mx));
        for i=1:min(mH*mW, mx)
            m(i) = str2num(message(i));
        end
        message = m;
%end

for i=1:length(message)
    if(message(i) == 1)
        wm(floor((i*blocksize)/(cH+blocksize))*blocksize+1:floor((i*blocksize)/(cH+blocksize))*blocksize+blocksize, mod(i-1, floor(cH/blocksize))*blocksize+1:mod(i-1, floor(cH/blocksize))*blocksize+blocksize) = pattern1;
    else
        wm(floor((i*blocksize)/(cH+blocksize))*blocksize+1:floor((i*blocksize)/(cH+blocksize))*blocksize+blocksize, mod(i-1, floor(cH/blocksize))*blocksize+1:mod(i-1, floor(cH/blocksize))*blocksize+blocksize) = pattern0; 
    end
end


