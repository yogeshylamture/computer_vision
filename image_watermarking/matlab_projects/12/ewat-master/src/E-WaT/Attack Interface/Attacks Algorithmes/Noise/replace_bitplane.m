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


%replace_bitplane: replaces bitplane with noise
%@im: image of which a bitplane will be replace
%@N: array indicating the bitplanes to replace (e.g. 14600000 will replace
%bitplane 1, 4 and 6



function im_bp_replaced = replace_bitplane(im, N, RGBYCbCr)

[H W D] = size(im);                                 %get size of image
randn('state', sum(100*clock));                     %initialise random generator
noise_bp = (randn(H, W) < 0);                          %generate random pattern)
im_bp_replaced = im;

if (N(1) == 0.0 && N(2) == 0.0 && N(3) == 0.0 && N(4) == 0.0 && N(5) == 0.0 && N(6) == 0.0 && N(7) == 0.0 && N(8) == 0.0...
    && RGBYCbCr(1) == 0.0 && RGBYCbCr(2) == 0.0 && RGBYCbCr(3) == 0.0 && RGBYCbCr(4) == 0.0 && RGBYCbCr(5) == 0.0 && RGBYCbCr(6) == 0.0)
    msgbox('No bitplanes and no components selected to replace');
    pause
elseif(N == 0.0)
    msgbox('No bitplanes selected to replace');
    pause
elseif (RGBYCbCr == 0.0)
    msgbox('No components selected to replace');
    pause
else
    if(RGBYCbCr(1) == 1.0)
        for j=1:1:8                                     %embed watermark in selected bitplanes by replacing the right bit
            if(N(j) ~= 0)
                n = N(j);
                im_bp_replaced(:,:,1) = bitset(im_bp_replaced(:,:,1), 9-n, bitget(im2double(noise_bp), n));
            end
        end
    end
    if(RGBYCbCr(2) == 1.0)
        for j=1:1:8                                     %embed watermark in selected bitplanes by replacing the right bit
            if(N(j) ~= 0)
                n = N(j);
                im_bp_replaced(:,:,2) = bitset(im_bp_replaced(:,:,2), 9-n, bitget(im2double(noise_bp), n));
            end
        end
    end
    if(RGBYCbCr(3) == 1.0)
        for j=1:1:8                                     %embed watermark in selected bitplanes by replacing the right bit
            if(N(j) ~= 0)
                n = N(j);
                im_bp_replaced(:,:,3) = bitset(im_bp_replaced(:,:,3), 9-n, bitget(im2double(noise_bp), n));
            end
        end
    end
    if(RGBYCbCr(4) == 1.0 ||  RGBYCbCr(5) == 1.0 || RGBYCbCr(6) == 1.0)
        im_bp_replaced = rgb2ycbcr(im_bp_replaced);
        if(RGBYCbCr(4) == 1.0)
            for j=1:1:8                                     %embed watermark in selected bitplanes by replacing the right bit
                if(N(j) ~= 0)
                    n = N(j);
                    im_bp_replaced(:,:,1) = bitset(im_bp_replaced(:,:,1), 9-n, bitget(im2double(noise_bp), n));
                end
            end
        end
        if(RGBYCbCr(5) == 1.0)
            for j=1:1:8                                     %embed watermark in selected bitplanes by replacing the right bit
                if(N(j) ~= 0)
                    n = N(j);
                    im_bp_replaced(:,:,2) = bitset(im_bp_replaced(:,:,2), 9-n, bitget(im2double(noise_bp), n));
                end
            end
        end
        if(RGBYCbCr(6) == 1.0)
            for j=1:1:8                                     %embed watermark in selected bitplanes by replacing the right bit
                if(N(j) ~= 0)
                    n = N(j);
                    im_bp_replaced(:,:,3) = bitset(im_bp_replaced(:,:,3), 9-n, bitget(im2double(noise_bp), n));
                end
            end
        end
    end
end