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


%blue: changes the blue component of the image
%@im: image of which chrominance will be changed
%@b: amount of change
%@setting: type of image (grayscale or layer)

function im_noise = noise(im, noiseType, mean, var, d)

switch (noiseType)
    case 2.0                                                                %Gaussian White Noise
        im_noise = imnoise(im, 'Gaussian', mean, var);                                  %add noise to image
    case 3.0                                                                %zero-mean Gaussian white noise
        var_ones = ones(size(im));
        var = var_ones*floor((var*10)/10);
        im_noise = imnoise(im, 'localvar', var);                            %add noise
    case 4.0                                                                %Poisson
        workbar(0.1, 'Adding poisson noise...', 'Poisson');
        im_noise = imnoise(im, 'Poisson');                                  %add noise
        workbar(1.0);
    case 5.0                                                                %salt & pepper
        im_noise = imnoise(im, 'salt & pepper', d);                         %add noise
    case 6.0
        im_noise = imnoise(im, 'speckle', var);                         %add noise
    otherwise
        msgbox('Specify noise type first...', 'Error', 'error');
        pause
end