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

%searchImage: search dynamically for a image message in the passed image
%@handles: current set of handles
%@L: message heigth (nr of pixels)
%@K: message width
%@cover: bitplane of cover work
%@blocksize: current blocksize
%@key: the user defined key
%§message: detected message
%§maxCounts: nr of pixel matched for the returned character

function [message maxCounts] = searchImage_key(handles, L, K, blocksize, cover, key)

[cH cW cD] = size(cover);                                               %get size of cover work
H = L;                                                                  %assign search height and width to 'embed-variabel' heigth and length (this function was largely copied from the embedder, therefore...)
W = K;
factor = get_root_data('factor');
if (floor((cH - H*blocksize*factor)/2) >= 1)
    offsetH = floor((cH - H*blocksize*factor)/2);                       %compute vertical offset to assure center align vertically
else
    offsetH = 0;
end
if(floor((cW - W*blocksize*factor)/2) >= 1)
    offsetW = floor((cW - W*blocksize*factor)/2);                       %compute horizontal offset so that text apears centered
else
    offsetW = 0;
end
randn('state', key);                                         %reset state of random generator to key
M_0 = im2bw(randn(blocksize*factor));                                          %define M_0 and M_1, representing a bit value of 0 and 1
M_1 = im2bw(randn(blocksize*factor));
if(H*blocksize*factor >= cH)                                            %determine max possible part of messageFile that could be embedded
    a = floor(cH/(blocksize*factor));
else
    if(H < cH/(blocksize*factor))
        a = H;
    else
        a = ceil(H/(blocksize*factor));
    end
end
if(W*blocksize*factor >= cW)
    b = floor(cW/(blocksize*factor));
else
    if(W < cW/(blocksize*factor))
        b = W;
    else
        b = ceil(W/(blocksize*factor));
    end
end
message = zeros(L, K);                                          %initialize empty message
maxCounts = zeros(L, K);                                        %initialize empty maxCounts
for i=1:a
    for j=1:b
        M = cover((i-1)*blocksize*factor+1 + offsetH : i*blocksize*factor + offsetH, (j-1)*blocksize*factor+1 + offsetW: j*blocksize*factor + offsetW);
        [MH, MW, MD] = size(M);
        count0 = 0;
        count1 = 0;
        for k=1:MH
            for l=1:MW                                          %count the nr of matching pixels between M andd M_0 or M_1
                if(M(k,l) == M_0(k,l))
                    count0 = count0+1;
                end
                if(M(k,l) == M_1(k,l))
                    count1 = count1 + 1;
                end
            end
        end
        countMax = max(count0, count1);                         %take max of matches
            maxCounts(i,j) = countMax(1);                       
        if(countMax == count1)
            message(i,j) = 1;                                   %set detected bit in message
       else
            message(i,j) = 0;                                   %set nr of detecte matches
        end
    end
end


