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


%% LSB embedder                                                          

function watermarked_image = embed_LSB(embedding_parameters)
%@cover: single layer image file
%@message_path: string, path of message file
%@key_path: string, path of key file
%@bp_string: string, indicates the bitplanes that have to be watermarked.
%            syntax: eg: '[7 8]' will watermark bitplane 7 and 8
%@blocksize: integer, determines how many pixels of the coverwork will be
%            used to embed 1 message bit
%@watermarked_image: image, watermarked image

%get primary paramters
cover = embedding_parameters.working_image;
message = embedding_parameters.message;
key = embedding_parameters.key;
% get secondary parameters
bp_string = embedding_parameters.var1;
blocksize = embedding_parameters.var2;
% var dependents on the number of paramters

wm = im2uint8(computeWatermark(message, cover, key, blocksize));

BP = eval(bp_string); 
im_WM = cover;
for j=1:length(BP)                                     
    if(BP(j) ~= 0)
        n = BP(j);
        im_WM = bitset(im_WM, 9-n, bitget(wm, n));
    end
end 
watermarked_image = im_WM;




