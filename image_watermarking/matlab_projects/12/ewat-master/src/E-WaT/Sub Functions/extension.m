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
%extension: used for determing wich extension has to be used for saving
%index: determs wich extion is selected

function ext = extension(index)
switch index
    case 1
        ext = '.bmp';
    case 2
        ext = '.jpg';
    case 3
        ext = '.gif';
    case 4
        ext = '.png';
    case 5
        ext = '.tif';
    otherwise
        ext = '.jpg';
end