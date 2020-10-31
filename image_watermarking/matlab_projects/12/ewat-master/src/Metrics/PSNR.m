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
 
%%
%PSNR: calculates the PSNR between two images
%cover_work: the original image
%watermarked_image: the distorted image
%psnr_value: the PSNR value in dB

%% PSNR
function [psnr_value] = PSNR(cover_work,watermarked_image)

        Mc = size(cover_work,1);
        Nc = size(cover_work,2);
        
        cover_work = double(cover_work);
        watermarked_image = double(watermarked_image);
        
        sum = 0;
        for i = 1:Mc
            for j = 1:Nc
                sum = sum + (cover_work(i,j)-watermarked_image(i,j))^2;
            end
        end
        mse = sum/(Mc*Nc);

        psnr_value = 10*log10(255^2/mse);
%%
