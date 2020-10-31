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

%jpeg: applies jpeg compression to the passed image
%@im: RGB image (format uint8, 0..255) to compress
%@Q_factor: scaling factor for quantizer
%@typ: type of passed image (grayscale or color)
%§im_compr: compressed RGB image (format YCbCr uint8, 0..255)

function im_compr = jpeg(im, Q_factor, type)
switch (type)
    case 'color'
        im = jpgycbcr(im);
        %im = double(im)-128;                                                  %convert image to YCbCr
        im_dct = zeros(size(im));
        for i=1:3
            im_dct(:,:,i) = blkproc(im(:,:,i), [8 8], 'dct2');                            %apply blockwise discrete cosinus transformation
        end
        workbar(0.6);
        Q_Y = [16 11 10 16  24  40  51  61;                             %definde quantization table (limunance)
            12 12 14 19  26  58  60  55;
            14 13 16 24  40  57  69  56;
            14 17 22 29  51  87  80  62;
            18 22 37 56  68 109 103  77;
            24 35 55 64  81 104 113  92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103  99];
        Q_CbCr = [17 18 24 47 99 99 99 99;                              %definde quantization table (chrominances)
            18 21 26 66 99 99 99 99;
            24 26 56 99 99 99 99 99;
            47 66 99 99 99 99 99 99;
            99 99 99 99 99 99 99 99;
            99 99 99 99 99 99 99 99;
            99 99 99 99 99 99 99 99;
            99 99 99 99 99 99 99 99];
        Q_Y = Q_Y.*((100-Q_factor)/10);                                 %scale quantizers
        Q_CbCr = Q_CbCr.*((100-Q_factor)/10);
        im_Q = zeros(size(im));                                         %create empty image
        quantization_Y = @(X) round(X./Q_Y);                            %quantization function: divide every DCT value by the corresponding value int the quantization matrix
        im_Q(:,:,1) = blkproc(im_dct(:,:,1), [8, 8], quantization_Y);   %apply quantisation
        quantization_CbCr = @(X) round(X./Q_CbCr);                      %quantization function: divide every DCT value by the corresponding value int the quantization matrix
        im_Q(:,:,2) = blkproc(im_dct(:,:,2), [8, 8], quantization_CbCr);    %apply quantisation
        im_Q(:,:,3) = blkproc(im_dct(:,:,3), [8, 8], quantization_CbCr);    %apply quantisation
        im_resc = zeros(size(im));                                      %create empty image
        rescale_Y = @(X) (round(X.*Q_Y));                               %rescale function
        im_resc(:,:,1) = blkproc(im_Q(:,:,1), [8,8], rescale_Y);        %rescale image
        rescale_CbCr = @(X) (round(X.*Q_CbCr));                         %rescale function
        im_resc(:,:,2) = blkproc(im_Q(:,:,2), [8,8], rescale_CbCr); %rescale image
        im_resc(:,:,3) = blkproc(im_Q(:,:,3), [8,8], rescale_CbCr); %rescale image
        %workbar(0.7);
        im_compr = zeros(size(im_resc));
        for i=1:3
            im_compr(:,:,i) = blkproc(im_resc(:,:,i), [8,8], 'idct2');                    %inverse IDCT
        end
       workbar(0.95);
        im_compr = (im_compr+128)./255;
        im_compr = ycbcr2rgb(im_compr);                                 %convert to RGB
    case 'grayscale'
%         im_1 = double(im(:,:,1))-128;                                                  %convert image to YCbCr
        im_dct = blkproc(im, [8 8], 'dct2');                            %apply blockwise discrete cosinus transformation
         workbar(0.6);
        Q_Y = [16 11 10 16  24  40  51  61;                             %definde quantization table (limunance)
            12 12 14 19  26  58  60  55;
            14 13 16 24  40  57  69  56;
            14 17 22 29  51  87  80  62;
            18 22 37 56  68 109 103  77;
            24 35 55 64  81 104 113  92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103  99];
        Q_Y = Q_Y.*((100-Q_factor)/10);                                 %scale quantizers
        quantization_Y = @(X) round(X./Q_Y);                            %quantization function: divide every DCT value by the corresponding value int the quantization matrix
        im_Q = blkproc(im_dct, [8, 8], quantization_Y);                 %apply quantisation
        rescale_Y = @(X) (round(X.*Q_Y));                               %rescale function
        im_resc = blkproc(im_Q, [8,8], rescale_Y);                      %rescale image
%         workbar(0.7);
        im_compr = blkproc(im_resc, [8,8], 'idct2');                    %inverse IDCT
%         workbar(0.95);
%         im_compr = (im_compr+128)./255;
%         im_compr = cat(3, im_compr, im_compr, im_compr);              %convert to 3 layers
    otherwise
        msgbox('Unsupported image format...', 'Error', 'error');
end
% workbar(1.0);
