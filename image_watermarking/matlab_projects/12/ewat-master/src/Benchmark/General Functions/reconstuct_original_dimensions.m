function image_to_save = reconstuct_original_dimensions(watermarked_image,original_image,layer_selected)


[H_image W_image D_image] = size(original_image);

if D_image == 1
    image_to_save = watermarked_image;
else
    %layer_selected = input.layer;
    switch layer_selected
        case 'Red Layer'
            RGB_image = original_image;
            layer2 = RGB_image(:,:,2);
            layer3 = RGB_image(:,:,3);
            image_to_save = cat(3,watermarked_image,layer2,layer3);
        case 'Green Layer'
            RGB_image = original_image;
            layer1 = RGB_image(:,:,1);
            layer3 = RGB_image(:,:,3);
            image_to_save = cat(3,layer1,watermarked_image,layer3);
        case 'Blue Layer'
            RGB_image = original_image;
            layer1 = RGB_image(:,:,1);
            layer2 = RGB_image(:,:,2);
            image_to_save = cat(3,layer1,layer2,watermarked_image);
        %YIQ reconstruction    
        case 'NTSC Layer'
            YIQ_image = rgb2ntsc(original_image);
            layer2 = YIQ_image(:,:,2);
            layer3 = YIQ_image(:,:,3);
            image_YIQ = cat(3,watermarked_image,layer2,layer3);
            image_to_save = ntsc2rbg(image_YIQ);
        case 'I Layer'
            YIQ_image = rgb2ntsc(original_image);
            layer1 = YIQ_image(:,:,1);
            layer3 = YIQ_image(:,:,3);
            image_YIQ = cat(3,layer1,watermarked_image,layer3);
            image_to_save = ntsc2rbg(image_YIQ);
        case 'Q Layer'
            YIQ_image = rgb2ntsc(original_image);
            layer1 = YIQ_image(:,:,1);
            layer2 = YIQ_image(:,:,2);
            image_YIQ = cat(3,layer1,layer2,watermarked_image);
            image_to_save = ntsc2rbg(image_YIQ);
        %YCbCr reconstructions
        case 'Y Layer' 
            YCbCr_image = rgb2ycbcr(original_image);
            layer2 = YCbCr_image(:,:,2);
            layer3 = YCbCr_image(:,:,3);
            image_YCbCr = cat(3,watermarked_image,layer2,layer3);
            image_to_save = ycbcr2rgb(image_YCbCr);
        case 'Cb Layer'
            YCbCr_image = rgb2ycbcr(original_image);
            layer1 = YCbCr_image(:,:,1);
            layer3 = YCbCr_image(:,:,3);
            image_to_save = cat(3,layer1,watermarked_image,layer3);
        case 'Cr Layer'
            YCbCr_image = rgb2ycbcr(original_image);
            layer1 = YCbCr_image(:,:,1);
            layer2 = YCbCr_image(:,:,2);
            image_YCbCr = cat(3,layer1,layer2,watermarked_image);
            image_to_save = ycbcr2rgb(image_YCbCr);
        %HSV reconstructions    
        case 'Hue Layer'
            HSV_image = rgb2hsv(original_image);
            layer2 = HSV_image(:,:,2);
            layer3 = HSV_image(:,:,3);
            image_HSV = cat(3,watermarked_image,layer2,layer3);
            image_to_save = hsv2rgb(image_HSV);
        case 'Saturation Layer'
            HSV_image = rgb2hsv(original_image);
            layer1 = HSV_image(:,:,1);
            layer3 = HSV_image(:,:,3);
            image_HSV = cat(3,layer1,watermarked_image,layer3);
            image_to_save = hsv2rgb(image_HSV);
        case 'Value Layer'
            HSV_image = rgb2hsv(original_image);
            layer1 = HSV_image(:,:,1);
            layer2 = HSV_image(:,:,2);
            image_HSV = cat(3,layer1,layer2,watermarked_image);
            image_to_save = hsv2rgb(image_HSV);
    end
end
