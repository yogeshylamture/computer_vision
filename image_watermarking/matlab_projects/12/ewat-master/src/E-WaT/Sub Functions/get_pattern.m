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

%get_pattern: returns the right random noise pattern for the passed
%character
%@c: character for wicht matrix need to be returned
%@patterns: matrix containing the patterns
%§m = returned matrix
function m = get_pattern(ch, patterns)

switch ch
    case {'A' , 'a'}
        m = patterns(:,:,1);
    case {'B' , 'b'}
        m = patterns(:,:,2);
    case {'C' , 'c'}
        m = patterns(:,:,3);
    case {'D' , 'd'}
        m = patterns(:,:,4);
    case {'E' , 'e'}
        m = patterns(:,:,5);
    case {'F' , 'f'}
        m = patterns(:,:,6);
    case {'G' , 'g'}
        m = patterns(:,:,7);
    case {'H' , 'h'}
        m = patterns(:,:,8);
    case {'I' , 'i'}
        m = patterns(:,:,9);
    case {'J' , 'j'}
        m = patterns(:,:,10);
    case {'K' , 'k'}
        m = patterns(:,:,11);
    case {'L' , 'l'}
        m = patterns(:,:,12);
    case {'M' , 'm'}
        m = patterns(:,:,13);
    case {'N' , 'n'}
        m = patterns(:,:,14);
    case {'O' , 'o'}
        m = patterns(:,:,15);
    case {'P' , 'p'}
        m = patterns(:,:,16);
    case {'Q' , 'q'}
        m = patterns(:,:,17);
    case {'R' , 'r'}
        m = patterns(:,:,18);
    case {'S' , 's'}
        m = patterns(:,:,19);
    case {'T' , 't'}
        m = patterns(:,:,20);
    case {'U' , 'u'}
        m = patterns(:,:,21);
    case {'V' , 'v'}
        m = patterns(:,:,22);
    case {'W' , 'w'}
        m = patterns(:,:,23);
    case {'X' , 'x'}
        m = patterns(:,:,24);
    case {'Y' , 'y'}
        m = patterns(:,:,25);
    case {'Z' , 'z'}
        m = patterns(:,:,26);
    case {''}
        m = patterns(:,:,27);
    case {'.'}
        m = patterns(:,:,28);
    case {','}
        m = patterns(:,:,29);
    otherwise
        m = patterns(:,:,30);
end

        
      