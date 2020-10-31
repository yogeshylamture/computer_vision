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

%im_rem: removes a pixel row or column
%@im: image from wich a row or column will be removed
%@row: 1 = remove row, 0 = remove column
%@nr: nr of pixel rows/columns to remove
%@offset: offset from the left or top

function im_rem = remove_row_column(im, row, nr, offset)
[H W D] = size(im);                                 %determine size of image
if (row == 1)
    im_rem = uint8(zeros(H-nr, W, D));                          %create empty image with new size
    im_rem(1:offset,:,:) = im(1:offset,:,:);                    %replace upper part (above removed pixel rows)
    im_rem(offset+1:H-nr,:,:) = im(offset+nr+1:H,:,:);          %replace lower part (below removed pixel rows)
else
    im_rem = uint8(zeros(H, W-nr, D));                          %create empty image with new size
    im_rem(:,1:offset,:) = im(:,1:offset,:);                    %replace left part (left of removed pixel rows)
    im_rem(:,offset+1:H-nr,:) = im(:,offset+nr+1:H,:);          %replace right part (right of removed pixel rows)
end