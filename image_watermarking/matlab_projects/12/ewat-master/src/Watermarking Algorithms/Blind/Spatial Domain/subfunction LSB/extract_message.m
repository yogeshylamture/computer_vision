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

function extracted_message = extract_message(bps, messageFile, type, key, blocksize)
%@bps: 2/3D matrix containing the bitplanes that will scanned for
%      containing a message
%@messageFile: image or string, original message
%@type: type of message ('text' or 'string');
%@key: integer, key used to become security
%@blocksize: integer, determines how many pixel of the cover work will be used to
%            embed one message bit or character
%@extracted_message: image or string, containing extracted message

[H W D] = size(bps);
randn('state', key);
pattern1 = randn(blocksize) > 0;
pattern0 = pattern1;
for j=1:blocksize
    for k=1:blocksize
        if(pattern1(j,k) == 1)
            pattern0(j,k) = 0;
        else
            pattern0(j,k) = 1;
        end
    end
end

switch(type)
    case 'image'
        messageFile = im2bw(messageFile);
        m = zeros(H, W);
        m = messageFile(1:min(floor(H/blocksize), end), 1:min(floor(W/blocksize), end));
        [mH mW mD] = size(m);
        message_ori = zeros(1,mH*mW);
        %convert image to 1D vector
        for i=1:mH
            for j=1:mW
                message_ori((i-1)*mW+j  ) = m(i,j);
            end
        end
    case 'text'
        mx = floor(H/blocksize)*floor(W/blocksize);
        message_ = dec2bin(messageFile);
        [mH mW mD] = size(message_);
        message = '';
        for i=1:mH
            message = strcat(message, strcat(message_(i,:)));
        end
        message = message(1:min(mH*mW, mx));
        m = zeros(1,min(mH*mW, mx));
        for i=1:min(mH*mW, mx)
            m(i) = str2num(message(i));
        end
        message_ori = m;
end


extracted_message = zeros(1,mH*mW, D);

p = 1;
for k=1:D
    for i=1:blocksize:H
        for j=1:blocksize:W
            if(p<mH*mW)
                sum1 = sum(sum(bps(i, j, k) == pattern1));
                sum0 = sum(sum(bps(i, j, k) == pattern0));
                if(max(sum0, sum1) == sum1)
                    extracted_message(1, p, k) = 1;
                    p = p+1;
                else
                    extracted_message(1, p, k) = 0;
                    p = p+1;
                end
            end
        end
    end
end



a = 0;
c = -1;
for i=1:D
    b = sum(sum( message_ori==extracted_message(min(end, length(message_ori)),i)));
    if(b > a)
        a = b;
        c = i;
    end
end
if c~=-1
    extracted_message = extracted_message(:,:,c);
else
    extracted_message = zeros(H,W);
end

switch(type)
    case 'image'
        mes = zeros(mH, mW);
        for i=1:mH
            for j=1:mW
                mes(i,j) = extracted_message((i-1)*mW+j);
            end
        end
    case 'text'
        mes = '';
        for i=1:mW:length(extracted_message)
            c = '';
            for j=1:mW
                c = strcat(c, num2str(extracted_message(i+j-1)));
            end
            b = bin2dec(c);
            mes = strcat(mes, b);
        end
end
extracted_message = mes;


