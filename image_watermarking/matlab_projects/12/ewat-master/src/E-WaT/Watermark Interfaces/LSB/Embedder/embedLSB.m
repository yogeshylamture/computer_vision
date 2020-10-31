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

%embedLSB: embeds the watermark in the cover image
%@cover: cover work
%@wm: watermark
%@BP: bitplanes to watermark

%% Embeding of the watermark

function im_WM = embedLSB(cover, wm, BP)

if (max(cover) <= 1)                                   %make sure im_ori and wm are of range 0..255
    cover = cover*255;
end
if(max(wm) <= 1)
    wm = wm*255;
end

im_WM = cover;
for j=1:1:8                                     %embed watermark in selected bitplanes by replacing the right bit
    if(BP(j) ~= 0)
        n = BP(j);
            im_WM = bitset(im_WM, 9-n, bitget(wm, n));
    end
end

                                          %Turn off all axis labeling

