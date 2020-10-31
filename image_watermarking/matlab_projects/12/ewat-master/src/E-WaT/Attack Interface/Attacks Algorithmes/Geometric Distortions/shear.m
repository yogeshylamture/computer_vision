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

%im_s: applies a shear to the image
%@im: image to apply shear
%@percent: percent shear
%@dir: direction of the shear ('WU', 'WD', 'HU', 'HD' for width up/down and
%height up/down.


function im_s = shear(im, percent, dir)

[H W D] = size(im);                                             %determine size of image

switch (dir)
    case 'WU'
        if(percent ~= 0)
            newH = H + abs(floor(percent*W)+H);                               %expand image to avoid negative indexing
            im_s = uint8(zeros(newH, W, D));                            %created empty sheared image
            for i = 1:H
                for j =1:W
                    for k =1:D                                          %for every pixel in every layer, apply chear
                        im_s(newH - floor(percent*j)+i, j,k) = im(i,j,k);
                    end
                end
                workbar(i/H);
            end
            im_s = removeEmptyBorders(im_s);                            %remove possible empty borders
        else
            im_s = im;
        end
    case 'WD'
        if(percent ~= 0)
            im_s = uint8(zeros(H, W, D));                               %created empty sheared image
            for i = 1:H
                for j =1:W
                    for k =1:D                                          %for every pixel in every layer, apply chear
                        im_s(floor(percent*j)+i, j,k) = im(i,j,k);
                    end
                end
                workbar(i/H);
            end
            im_s = removeEmptyBorders(im_s);                            %remove possible empty borders
        else
            im_s = im;
        end
    case 'HU'
        if(percent ~= 0)
            newW = W + abs(floor((H*percent)+W));                             %expand image to avoid negative indexing
            im_s = uint8(zeros(H, newW, D));                            %created empty sheared image
            for i = 1:H
                for j =1:W
                    for k =1:D                                          %for every pixel in every layer, apply chear
                        im_s(i, newW - floor(i*percent)+j, k) = im(i,j,k);
                    end
                end
                workbar(i/H);
            end
            im_s = removeEmptyBorders(im_s);                            %remove possible empty borders
        else
            im_s = im;
        end
    case 'HD'
        if(percent ~= 0)
            im_s = uint8(zeros(H, W, D));                               %created empty sheared image
            for i = 1:H
                for j =1:W
                    for k =1:D                                          %for every pixel in every layer, apply chear
                        im_s(i, floor(i*percent)+j, k) = im(i,j,k);
                    end
                end
                workbar(i/H);
            end
            im_s = removeEmptyBorders(im_s);                            %remove possible empty borders
        else
            im_s = im;
        end
end
