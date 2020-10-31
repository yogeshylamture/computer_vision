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

%removeEmptyBorders: removes rows and colums at the borders of the image
%that are empty (all zeros).
%@im: im to remove borders from
%§im_rescaled: clean image

function im_rescaled = removeEmptyBorders(im)
workbar(0.1, 'Reading image','Rescaling');
[H W D] = size(im);                                         %get size of image
nrRowsTop = 0;                                              %initialize nr of empty rows/colums to zero
nrRowsBottom = 0;
nrColumsLeft = 0;
nrColumsRight = 0;
ok = false;                                                 %initialize OK to false
i = 1;                                                      %initialize i (heigth) to zero
while(~ok && i <= H)                                        %while only empty rows/colums found and end of image not reached,
    count = 0;                                              %(re)set count to zero
    for j=1:W
        if(im(i,j,:) == 0)                                  %check if all values of a row/colums are zero
            count = count + 1;
        end
    end
    if(count == W)
        nrRowsTop = nrRowsTop + 1;                          %if so, higher the nr of empty rows by one
        i = i + 1;
    else
        ok = true;                                          %if first not empyt row/columd found, set ok to true
        workbar(0.2, 'rescaling...', 'Rescaling');
    end
end
i = H;                                                      %analogue...
ok = false;
while(~ok && i > 0)
    count = 0;
    for j=1:W
        if(im(i,j,:) == 0)
            count = count + 1;
        end
    end
    if(count == W)
        nrRowsBottom = nrRowsBottom + 1;
        i = i - 1;
    else
        ok = true;
        workbar(0.3, 'rescaling...', 'Rescaling');
    end
end
j = 1;
ok = false;
while(~ok && j <= W)
    count = 0;
    for i=1:H
        if(im(i,j,:) == 0)
            count = count + 1;
        end
    end
    if(count == H)
        nrColumsLeft = nrColumsLeft + 1;
        j = j + 1;
    else
        ok = true;
        workbar(0.4, 'rescaling...', 'Rescaling');
    end
end
j = W;
ok = false;
while(~ok && i > 0)
    count = 0;
    for i=1:H
        if(im(i,j,:) == 0)
            count = count + 1;
        end
    end
    if(count == H)
        nrColumsRight = nrColumsRight + 1;
        j = j - 1;
    else
        ok = true;
        workbar(0.5, 'rescaling...', 'Rescaling');
    end
end
if(nrRowsTop ~= 0 || nrRowsBottom ~=0 || nrColumsLeft ~= 0 || nrColumsRight ~= 0)   %if empty row or column found
    newH = H - (nrRowsTop + nrRowsBottom);                                          %determine size of new image
    newW = W - (nrColumsLeft + nrColumsRight);
    im_rescaled = uint8(zeros(newH, newW,3));                                    %create new empty image
    for j = nrColumsLeft+1:W-nrColumsRight                                          %put right values in it
        for i = nrRowsTop+1:H-nrRowsBottom
            im_rescaled(i-nrRowsTop,j-nrColumsLeft,:) = im(i,j,:);
        end
    workbar(0.5 + 0.5*ceil((j/(W-nrColumsRight))), 'rescaling...', 'Rescaling');
    end
else
    im_rescaled = zeros(H,W,3);
    im_rescaled = im;
    workbar(1.0, 'rescaling...', 'Rescaling');
end
