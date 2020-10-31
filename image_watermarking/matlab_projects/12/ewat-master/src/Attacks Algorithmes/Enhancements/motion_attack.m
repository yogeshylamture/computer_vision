%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %  
%                           Hogeschool Antwerpen                          %
%                Industriële Wetenschappen: Elektronica-ICT               %
%                      MultiMediaGroep - Watermarking                     %
%                                                                         %
%                                                                         %
%                             Masterthesis 4.2                            %
%                               Kevin Heylen                             %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%motion: applies motion blur to the image
%@im: image to blur
%@nrOfPixels: nr of pixels to blur

function im_mot = motion_attack(im, nrOfPixels)
try
    h = fspecial('motion',nrOfPixels,45);                            %create motion filter
    im_mot = imfilter(im, h);                                           %apply filter
catch
    im_mot = im;
end
