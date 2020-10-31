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

%searchMessage: search dynamically for a message in the passed image
%@handles: current set of handles
%@L: message length
%@cover: bitplane of cover work
%§messageString: detected message
%§maxCounts: nr of pixel matched for the returned character

function [messageString maxCounts] = searchMessage_key(handles, L, cover)

[cH cW cD] = size(cover);                                                   %get size of cover work
[aH aW aD] = size(alphabet('a'));                                           %determine size of character matrices (all characters should have same size)

factor = 1;                                                                 %initialis factor to 1
nrR = floor(cH/(factor*aH));                                                %nr of rows possible = floor(cH,aH))
nrC = floor(cW/(factor*aW));                                                %nr of colums possible: floor(cW/aW) = nr of characters that fits in 1 row of the cover work
nrR_needed = ceil(L/nrC);                                                   %ceil(L/nrC)) = nr of rows needed
if(nrR >= nrR_needed && cW >= aW*nrC)                                       %if cover work is big enough for message (message is max when factor is one)
    n = mod(L,nrC);                                                         %use n so we can set n to nrC when mod() is zero
    if(n==0)
        n = nrC;
    end
    nrC_last_row = n;                                                       %nr of colums for last row
    while(nrR >= nrR_needed)                                                %as long as cover work is large enough, higher factor with one
        factor = factor + 1;                                                %recompute nrR, ...
        nrR = floor(cH/(factor*aH));                                        %nr of rows possible = floor(cH,aH))
        nrC = floor(cW/(factor*aW));                                        %nr of colums possible: floor(cW/aW) = nr of characters that fits in 1 row of the cover work
        nrR_needed = ceil(L/nrC);                                           %ceil(L/nrC)) = nr of rows needed
        n = mod(L,nrC);                                                     %use n so we can set n to nrC when mod() is zero
        if(n==0)
            n = nrC;
        end
        nrC_last_row = n;                                                   %nr of colums for last row
    end
    factor = factor - 1;                                                    %factor is now 1 too high, so do minus 1 and recompute nrR,..
    nrR = floor(cH/(factor*aH));                                            %nr of rows possible = floor(cH,aH))
    nrC = floor(cW/(factor*aW));                                            %nr of colums possible: floor(cW/aW) = nr of characters that fits in 1 row of the cover work
    nrR_needed = ceil(L/nrC);                                               %ceil(L/nrC)) = nr of rows needed
    n = mod(L,nrC);                                                         %use n so we can set n to nrC when mod() is zero
    if(n==0)
        n = nrC;
    end
    nrC_last_row = n;                                                       %nr of colums for last row
    message = zeros(aH,aW,L);                                               %create empty message with size depending on matrix size and lengthe
    offsetH = floor((cH - nrR_needed*aH*factor)/2);                         %compute vertical offset to assure center align vertically
    ind = 1;                                                                %index for indicating charachters in the message matrix
    for i=1:nrR_needed
        if (i == nrR_needed)                                                %last row
            for j=1:nrC_last_row
                offsetW = floor((cW - nrC_last_row*aW*factor)/2);           %compute horizontal offset so that text apears centered
                m = ones(aH,aW);                                            %empty matrix represenataion with size equale to other matris representation
                M = ones(aH*factor, aW*factor);                             %M = new (larger) empty matrix representation of the characters depending on factor
                M = cover((i-1)*aH*factor+1 + offsetH : i*aH*factor + offsetH, (j-1)*aW*factor+1 + offsetW : j*aW*factor + offsetW); %read one character from image to M
                for v = 1:aH                                                %copy date from M into m (cancel factor to become size of normal matrix represenatation
                    for w = 1:aW
                        m(v,w) = M((v-1)*factor+1,(w-1)*factor+1);
                    end
                end
                message(:,:,ind) = m;                                       %put all read characters in one matrix message
                ind = ind +1;                                               %higher ind with 1 to place next character at next index
            end
        else                                                                %other rows
            for j=1:nrC
                offsetW = floor((cW - nrC*aW*factor)/2);                    %compute horizontal offset so that text apears centered
                m = ones(aH,aW);                                            %empty matrix represenataion with size equale to other matris representation
                M = ones(aH*factor, aW*factor);                             %M = new (larger) empty matrix representation of the characters depending on factor
                M = cover((i-1)*aH*factor+1 + offsetH : i*aH*factor + offsetH, (j-1)*aW*factor+1 + offsetW : j*aW*factor + offsetW); %read one character from image to M
                for v = 1:aH                                                %copy date from M into m (cancel factor to become size of normal matrix represenatation
                    for w = 1:aW
                        m(v,w) = M((v-1)*factor+1,(w-1)*factor+1);
                    end
                end
                message(:,:,ind) = m;                                       %put all read characters in one matrix message
                ind = ind +1;                                               %higher ind with 1 to place next character at next index
            end
        end
    end
    messageString = char(L);
    maxCounts = zeros(1,L);
    for i=1:L
        [messageString(i) maxCounts(i)] = getChar_key(handles, message(:,:,i));
    end
else
    set(handles.textBoxMessage, 'Visible', 'off');
    set(handles.computingMessage, 'Visible', 'off');
    msgbox('Image is to small for containing a watermark that is embedded using computeWatermark.m.', 'Error', 'error');;
end
