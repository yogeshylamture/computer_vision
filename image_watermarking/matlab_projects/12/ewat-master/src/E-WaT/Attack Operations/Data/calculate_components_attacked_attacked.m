function calculate_components_attacked_attacked(handles,im)
%% initialization
type = get_root_data('image_type');
set_root_data(handles,'attacked_attacked',im);
wavelet = 'bior1.1';

switch type
    case 'grayscale'
%% Grayscale calculations
%% Working Calculations
        workbar(10/100,'Performing Calclations for working image','Step 1');
        current_figure = get(0,'CurrentFigure');
        working_image = im(:,:,1);
        set_root_data(handles,'attacked_attacked_working_grayscale',working_image);
        set_root_data(handles,'attacked_decode_working_grayscale',working_image);
%% DCT calculations        
        figure(current_figure);
        workbar(20/100,'Performing calclation Discrete Cosinus Transformation','Step 2');
        
        blocksize = 8;
        DCT = @dct2;

        image_dct = blkproc(im2double(working_image),[blocksize blocksize], DCT);
        set_root_data(handles,'attacked_attacked_dct_grayscale',image_dct);
        set_root_data(handles,'attacked_decode_dct_grayscale',image_dct);
        
%% DWT Calculations
        figure(current_figure);
        workbar(30/100,'Performing Calclation Discrete Wavelet tranformation','Step 3'); 
        
        [AC,AS]=wavedec2(im2double(working_image),5,wavelet);

        AcA5=appcoef2(AC,AS,wavelet,5);

        [AcH1,AcV1,AcD1] = detcoef2('all',AC,AS,1);
        [AcH2,AcV2,AcD2] = detcoef2('all',AC,AS,2);
        [AcH3,AcV3,AcD3] = detcoef2('all',AC,AS,3);
        [AcH4,AcV4,AcD4] = detcoef2('all',AC,AS,4);
        [AcH5,AcV5,AcD5] = detcoef2('all',AC,AS,5);

        level_five_merge = [AcD5,AcH5;AcV5,AcA5];
        level_four_merge = [AcD4,AcH4;AcV4,level_five_merge];
        level_three_merge = [AcD3,AcH3;AcV3,level_four_merge];
        level_two_merge = [AcD2,AcH2;AcV2,level_three_merge];
        merge = [AcD1,AcH1;AcV1,level_two_merge];
       
        set_root_data(handles,'attacked_attacked_dwt_grayscale',im2uint8(merge));
        set_root_data(handles,'attacked_decode_dwt_grayscale',im2uint8(merge));
        
%% Plotting calculations
        set_root_data(handles,'attacked_attacked_plot_grayscale',im);
        set_root_data(handles,'attacked_decode_plot_grayscale',im);
        
        figure(current_figure);
        workbar(99/100,'Done','Finished'); 
        workbar(100/100,'Done','Finished'); 
%% End grayscale settings
%%
    case 'layered'
        
%%
%% Color calculations  
%% Initialzation
        set(handles.radiobutton_icon_ycbcr_original,'Value',1');
        set(handles.radiobutton_icon_rgb_original,'Value',0);
%% RGB Working
        workbar(1/100,'Performing Calclations for working image','Step 1');
        current_figure = get(0,'CurrentFigure');
        layer_red = im(:,:,1);
        layer_green = im(:,:,2);
        layer_blue = im(:,:,3);
        
        set_root_data(handles,'attacked_attacked_working_rgb',im);
        set_root_data(handles,'attacked_attacked_working_red',layer_red);
        set_root_data(handles,'attacked_attacked_working_green',layer_green);
        set_root_data(handles,'attacked_attacked_working_blue',layer_blue);
        
        set_root_data(handles,'attacked_decode_working_rgb',im);
        set_root_data(handles,'attacked_decode_working_red',layer_red);
        set_root_data(handles,'attacked_decode_working_green',layer_green);
        set_root_data(handles,'attacked_decode_working_blue',layer_blue);
       
%% RGB DCT
        figure(current_figure);
        workbar(30/100,'Calclate Discrete Cosinus tranformation for the image','Step 2');
        
        blocksize = 8;
        DCT = @dct2;

        image_dct_red = blkproc(im2double(layer_red),[blocksize blocksize], DCT);
        
        figure(current_figure);
        workbar(33/100,'Calclate Discrete Cosinus tranformation for the image','Step 2');
        
        image_dct_green = blkproc(im2double(layer_green),[blocksize blocksize], DCT);
        
        figure(current_figure);
        workbar(36/100,'Calclate Discrete Cosinus tranformation for the image','Step 2');
        
        image_dct_blue = blkproc(im2double(layer_blue),[blocksize blocksize], DCT);
        
        figure(current_figure);
        workbar(39/100,'Calclate Discrete Cosinus tranformation for the image','Step 2');
        
        set_root_data(handles,'attacked_attacked_dct_red',image_dct_red);
        set_root_data(handles,'attacked_attacked_dct_green',image_dct_green);
        set_root_data(handles,'attacked_attacked_dct_blue',image_dct_blue);
        
        set_root_data(handles,'attacked_decode_dct_red',image_dct_red);
        set_root_data(handles,'attacked_decode_dct_green',image_dct_green);
        set_root_data(handles,'attacked_decode_dct_blue',image_dct_blue);
%% RGB DWT
        figure(current_figure);
        workbar(40/100,'Calclate Discrete Wavelet tranformation for the image','Step 3');
        
        [AC_red,AS_red]=wavedec2(im2double(layer_red),5,wavelet);
        
        figure(current_figure);
        workbar(41/100,'Calclate Discrete Wavelet tranformation for the image','Step 3');
        
        [AC_green,AS_green]=wavedec2(im2double(layer_green),5,wavelet);
        
        figure(current_figure);
        workbar(42/100,'Calclate Discrete Wavelet tranformation for the image','Step 3');
        
        [AC_blue,AS_blue]=wavedec2(im2double(layer_blue),5,wavelet);
        
        figure(current_figure);
        workbar(43/100,'Calclate Discrete Wavelet tranformation for the image','Step 3');
        
        AcA5_red=appcoef2(AC_red,AS_red,wavelet,5);
        AcA5_green=appcoef2(AC_green,AS_green,wavelet,5);
        AcA5_blue=appcoef2(AC_blue,AS_blue,wavelet,5);
        
        figure(current_figure);
        workbar(44/100,'Calclate Discrete Wavelet tranformation for the image','Step 3');
        
        [AcH1_red,AcV1_red,AcD1_red] = detcoef2('all',AC_red,AS_red,1);
        [AcH2_red,AcV2_red,AcD2_red] = detcoef2('all',AC_red,AS_red,2);
        [AcH3_red,AcV3_red,AcD3_red] = detcoef2('all',AC_red,AS_red,3);
        [AcH4_red,AcV4_red,AcD4_red] = detcoef2('all',AC_red,AS_red,4);
        [AcH5_red,AcV5_red,AcD5_red] = detcoef2('all',AC_red,AS_red,5);
        
        figure(current_figure);
        workbar(45/100,'Calclate Discrete Wavelet tranformation for the image','Step 3');
        
        [AcH1_green,AcV1_green,AcD1_green] = detcoef2('all',AC_green,AS_green,1);
        [AcH2_green,AcV2_green,AcD2_green] = detcoef2('all',AC_green,AS_green,2);
        [AcH3_green,AcV3_green,AcD3_green] = detcoef2('all',AC_green,AS_green,3);
        [AcH4_green,AcV4_green,AcD4_green] = detcoef2('all',AC_green,AS_green,4);
        [AcH5_green,AcV5_green,AcD5_green] = detcoef2('all',AC_green,AS_green,5);

        [AcH1_blue,AcV1_blue,AcD1_blue] = detcoef2('all',AC_blue,AS_blue,1);
        [AcH2_blue,AcV2_blue,AcD2_blue] = detcoef2('all',AC_blue,AS_blue,2);
        [AcH3_blue,AcV3_blue,AcD3_blue] = detcoef2('all',AC_blue,AS_blue,3);
        [AcH4_blue,AcV4_blue,AcD4_blue] = detcoef2('all',AC_blue,AS_blue,4);
        [AcH5_blue,AcV5_blue,AcD5_blue] = detcoef2('all',AC_blue,AS_blue,5);
        
        figure(current_figure);
        workbar(46/100,'Calclate Discrete Wavelet tranformation for the image','Step 3');
        
        level_five_merge_red = [AcD5_red,AcH5_red;AcV5_red,AcA5_red];
        level_four_merge_red = [AcD4_red,AcH4_red;AcV4_red,level_five_merge_red];
        level_three_merge_red = [AcD3_red,AcH3_red;AcV3_red,level_four_merge_red];
        level_two_merge_red = [AcD2_red,AcH2_red;AcV2_red,level_three_merge_red];
        merge_red = [AcD1_red,AcH1_red;AcV1_red,level_two_merge_red];
        
        level_five_merge_green = [AcD5_green,AcH5_green;AcV5_green,AcA5_green];
        level_four_merge_green = [AcD4_green,AcH4_green;AcV4_green,level_five_merge_green];
        level_three_merge_green = [AcD3_green,AcH3_green;AcV3_green,level_four_merge_green];
        level_two_merge_green = [AcD2_green,AcH2_green;AcV2_green,level_three_merge_green];
        merge_green = [AcD1_green,AcH1_green;AcV1_green,level_two_merge_green];
        
        level_five_merge_blue = [AcD5_blue,AcH5_blue;AcV5_blue,AcA5_blue];
        level_four_merge_blue = [AcD4_blue,AcH4_blue;AcV4_blue,level_five_merge_blue];
        level_three_merge_blue = [AcD3_blue,AcH3_blue;AcV3_blue,level_four_merge_blue];
        level_two_merge_blue = [AcD2_blue,AcH2_blue;AcV2_blue,level_three_merge_blue];
        merge_blue = [AcD1_blue,AcH1_blue;AcV1_blue,level_two_merge_blue];
        
        figure(current_figure);
        workbar(47/100,'Calclate Discrete Wavelet tranformation for the image','Step 3');
        
        set_root_data(handles,'attacked_attacked_dwt_red',im2uint8(merge_red));
        set_root_data(handles,'attacked_attacked_dwt_green',im2uint8(merge_green));
        set_root_data(handles,'attacked_attacked_dwt_blue',im2uint8(merge_blue));
        
        set_root_data(handles,'attacked_decode_dwt_red',im2uint8(merge_red));
        set_root_data(handles,'attacked_decode_dwt_green',im2uint8(merge_green));
        set_root_data(handles,'attacked_decode_dwt_blue',im2uint8(merge_blue));
        
%% RGB Plotting
        figure(current_figure);
        workbar(50/100,'Calclate variables for plotting the images','Step 4');
        im_layer1 = get_layer(im,'rgb','layer1');
        
        figure(current_figure);
        workbar(51/100,'Calclate variables for plotting the images','Step 4');
        
        im_layer2 = get_layer(im,'rgb','layer2');
        
        figure(current_figure);
        workbar(52/100,'Calclate variables for plotting the images','Step 4');
        
        im_layer3 = get_layer(im,'rgb','layer3');
        
        figure(current_figure);
        workbar(53/100,'Calclate variables for plotting the images','Step 4');
        
        set_root_data(handles,'attacked_attacked_plot_rgb',im);
        set_root_data(handles,'attacked_decode_plot_rgb',im);
        
        figure(current_figure);
        workbar(54/100,'Calclate variables for plotting the images','Step 4');
        
        set_root_data(handles,'attacked_attacked_plot_red',im_layer1);
        set_root_data(handles,'attacked_decode_plot_red',im_layer1);
        
        figure(current_figure);
        workbar(55/100,'Calclate variables for plotting the images','Step 4');
        
        set_root_data(handles,'attacked_attacked_plot_green',im_layer2);
        set_root_data(handles,'attacked_decode_plot_green',im_layer2);
        
        figure(current_figure);
        workbar(56/100,'Calclate variables for plotting the images','Step 4');
        
        set_root_data(handles,'attacked_attacked_plot_blue',im_layer3);
        set_root_data(handles,'attacked_decode_plot_blue',im_layer3);
        
        figure(current_figure);
        workbar(57/100,'Calclate variables for plotting the images','Step 4');
%% YCbCr Working        
        figure(current_figure);
        workbar(60/100,'Calclate variables for the working image','Step 5');
        im_ycbcr = rgb2ycbcr(im);
        figure(current_figure);
        workbar(65/100,'Calclate variables for the working image','Step 5');
        
        layer_y = im_ycbcr(:,:,1);
        layer_cb = im_ycbcr(:,:,2);
        layer_cr = im_ycbcr(:,:,3);
        
        set_root_data(handles,'attacked_attacked_working_ycbcr',im_ycbcr);
        set_root_data(handles,'attacked_attacked_working_y',layer_y);
        set_root_data(handles,'attacked_attacked_working_cb',layer_cb);
        set_root_data(handles,'attacked_attacked_working_cr',layer_cr);
        
        set_root_data(handles,'attacked_decode_working_ycbcr',im_ycbcr);
        set_root_data(handles,'attacked_decode_working_y',layer_y);
        set_root_data(handles,'attacked_decode_working_cb',layer_cb);
        set_root_data(handles,'attacked_decode_working_cr',layer_cr);

%% YCbCr DCT         
        figure(current_figure);
        workbar(70/100,'Calculate Discrete Cosinus tranformation on the image','Step 6');
        
        blocksize = 8;
        DCT = @dct2;

        image_dct_y = blkproc(im2double(layer_y),[blocksize blocksize], DCT);
        
        figure(current_figure);
        workbar(73/100,'Calculate Discrete Cosinus tranformation on the image','Step 6');
        
        image_dct_cb = blkproc(im2double(layer_cb),[blocksize blocksize], DCT);
        
        figure(current_figure);
        workbar(76/100,'Calculate Discrete Cosinus tranformation on the image','Step 6');
        
        image_dct_cr = blkproc(im2double(layer_cr),[blocksize blocksize], DCT);
        
        figure(current_figure);
        workbar(79/100,'Calculate Discrete Cosinus tranformation on the image','Step 6');
        
        set_root_data(handles,'attacked_attacked_dct_y',image_dct_y);
        set_root_data(handles,'attacked_attacked_dct_cb',image_dct_cb);
        set_root_data(handles,'attacked_attacked_dct_cr',image_dct_cr);
        
        set_root_data(handles,'attacked_decode_dct_y',image_dct_y);
        set_root_data(handles,'attacked_decode_dct_cb',image_dct_cb);
        set_root_data(handles,'attacked_decode_dct_cr',image_dct_cr);
        
%% YCbCr DWT
        figure(current_figure);
        workbar(80/100,'Calclate Discrete Wavelet tranformation on the image','Step 7');
        
        [AC_y,AS_y]=wavedec2(im2double(layer_y),5,wavelet);
        
        figure(current_figure);
        workbar(81/100,'Calclate Discrete Wavelet tranformation on the image','Step 7');
        
        [AC_cb,AS_cb]=wavedec2(im2double(layer_cb),5,wavelet);
        
        figure(current_figure);
        workbar(82/100,'Calclate Discrete Wavelet tranformation on the image','Step 7');
        
        [AC_cr,AS_cr]=wavedec2(im2double(layer_cr),5,wavelet);
        
        figure(current_figure);
        workbar(83/100,'Calclate Discrete Wavelet tranformation on the image','Step 7');
        
        AcA5_y=appcoef2(AC_y,AS_y,wavelet,5);
        
        figure(current_figure);
        workbar(84/100,'Calclate Discrete Wavelet tranformation on the image','Step 7');
        
        AcA5_cb=appcoef2(AC_cb,AS_cb,wavelet,5);
        
        figure(current_figure);
        workbar(85/100,'Calclate Discrete Wavelet tranformation on the image','Step 7');
        
        AcA5_cr=appcoef2(AC_cr,AS_cr,wavelet,5);
        
        figure(current_figure);
        workbar(86/100,'Calclate Discrete Wavelet tranformation on the image','Step 7');
        
        [AcH1_y,AcV1_y,AcD1_y] = detcoef2('all',AC_y,AS_y,1);
        [AcH2_y,AcV2_y,AcD2_y] = detcoef2('all',AC_y,AS_y,2);
        [AcH3_y,AcV3_y,AcD3_y] = detcoef2('all',AC_y,AS_y,3);
        [AcH4_y,AcV4_y,AcD4_y] = detcoef2('all',AC_y,AS_y,4);
        [AcH5_y,AcV5_y,AcD5_y] = detcoef2('all',AC_y,AS_y,5);
        
        figure(current_figure);
        workbar(87/100,'Calclate Discrete Wavelet tranformation on the image','Step 7');
        
        [AcH1_cb,AcV1_cb,AcD1_cb] = detcoef2('all',AC_cb,AS_cb,1);
        [AcH2_cb,AcV2_cb,AcD2_cb] = detcoef2('all',AC_cb,AS_cb,2);
        [AcH3_cb,AcV3_cb,AcD3_cb] = detcoef2('all',AC_cb,AS_cb,3);
        [AcH4_cb,AcV4_cb,AcD4_cb] = detcoef2('all',AC_cb,AS_cb,4);
        [AcH5_cb,AcV5_cb,AcD5_cb] = detcoef2('all',AC_cb,AS_cb,5);

        [AcH1_cr,AcV1_cr,AcD1_cr] = detcoef2('all',AC_cr,AS_cr,1);
        [AcH2_cr,AcV2_cr,AcD2_cr] = detcoef2('all',AC_cr,AS_cr,2);
        [AcH3_cr,AcV3_cr,AcD3_cr] = detcoef2('all',AC_cr,AS_cr,3);
        [AcH4_cr,AcV4_cr,AcD4_cr] = detcoef2('all',AC_cr,AS_cr,4);
        [AcH5_cr,AcV5_cr,AcD5_cr] = detcoef2('all',AC_cr,AS_cr,5);
        
        figure(current_figure);
        workbar(88/100,'Calclate Discrete Wavelet tranformation on the image','Step 7');
        
        level_five_merge_y = [AcD5_y,AcH5_y;AcV5_y,AcA5_y];
        level_four_merge_y = [AcD4_y,AcH4_y;AcV4_y,level_five_merge_y];
        level_three_merge_y = [AcD3_y,AcH3_y;AcV3_y,level_four_merge_y];
        level_two_merge_y = [AcD2_y,AcH2_y;AcV2_y,level_three_merge_y];
        merge_y = [AcD1_y,AcH1_y;AcV1_y,level_two_merge_y];
        
        level_five_merge_cb = [AcD5_cb,AcH5_cb;AcV5_cb,AcA5_cb];
        level_four_merge_cb = [AcD4_cb,AcH4_cb;AcV4_cb,level_five_merge_cb];
        level_three_merge_cb = [AcD3_cb,AcH3_cb;AcV3_cb,level_four_merge_cb];
        level_two_merge_cb = [AcD2_cb,AcH2_cb;AcV2_cb,level_three_merge_cb];
        merge_cb = [AcD1_cb,AcH1_cb;AcV1_cb,level_two_merge_cb];
        
        level_five_merge_cr = [AcD5_cr,AcH5_cr;AcV5_cr,AcA5_cr];
        level_four_merge_cr = [AcD4_cr,AcH4_cr;AcV4_cr,level_five_merge_cr];
        level_three_merge_cr = [AcD3_cr,AcH3_cr;AcV3_cr,level_four_merge_cr];
        level_two_merge_cr = [AcD2_cr,AcH2_cr;AcV2_cr,level_three_merge_cr];
        merge_cr = [AcD1_cr,AcH1_cr;AcV1_cr,level_two_merge_cr];
        
        figure(current_figure);
        workbar(89/100,'Calclate Discrete Wavelet tranformation on the image','Step 7');
        
        set_root_data(handles,'attacked_attacked_dwt_y',im2uint8(merge_y));
        set_root_data(handles,'attacked_attacked_dwt_cb',im2uint8(merge_cb));
        set_root_data(handles,'attacked_attacked_dwt_cr',im2uint8(merge_cr));
        
        set_root_data(handles,'attacked_decode_dwt_y',im2uint8(merge_y));
        set_root_data(handles,'attacked_decode_dwt_cb',im2uint8(merge_cb));
        set_root_data(handles,'attacked_decode_dwt_cr',im2uint8(merge_cr));
        
%% YCbCr Plotting 
        figure(current_figure);
        workbar(90/100,'Calclate the images for plotting','Step 8');
        im_layer1 = get_layer(im,'ycbcr','layer1');
        
        figure(current_figure);
        workbar(93/100,'Calclate the images for plotting','Step 8');
        
        im_layer2 = get_layer(im,'ycbcr','layer2');
        
        figure(current_figure);
        workbar(96/100,'Calclate the images for plotting','Step 8');
        
        im_layer3 = get_layer(im,'ycbcr','layer3');
        
        figure(current_figure);
        workbar(99/100,'Calclate the images for plotting','Step 8');
        
        %set_root_data('attacked_attacked_plot_ycbcr',im);
        set_root_data(handles,'attacked_attacked_plot_y',im_layer1);
        set_root_data(handles,'attacked_attacked_plot_cb',im_layer2);
        set_root_data(handles,'attacked_attacked_plot_cr',im_layer3);
        
        set_root_data(handles,'attacked_decode_plot_y',im_layer1);
        set_root_data(handles,'attacked_decode_plot_cb',im_layer2);
        set_root_data(handles,'attacked_decode_plot_cr',im_layer3);
        
        figure(current_figure);
        workbar(100/100,'Done','Finished');
end
