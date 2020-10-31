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

%getChar: searches for a match between the passed image and the character
%matrices in alphabet.m. Returns the character of the best match
%@handles: curren set of handles
%@im: image, possible representing a character
%§c: character with best match
%§maxCount: nr of pixels matches for c

function [c maxCount] = getChar_key(handles, im)

type_key = get_root_data('chosen_key');
switch type_key
    case 'text'
        key = get_root_data('chosen_key_text');
        
    case 'imag'
        key = get_root_data('chosen_key_image');
end;

switch type_key                  %computes the key
    case 'text'
        key = sum(key);
    case 'imag'
        key = sum(sum(sum(key)));
    otherwise
        msgbox('Problem with key...', 'Error', 'error');
end

[aH aW aD] = size(alphabet('a'));                                           %determine size of matrix representation              
patterns = gen_patterns(key, aH, aW);

countA = 0;                         %initialize charachter counts to zero (represents the number of matched pixels between an image and a charachter
countB = 0;
countC = 0;
countD = 0;
countE = 0;
countF = 0;
countG = 0;
countH = 0;
countI = 0;
countJ = 0;
countK = 0;
countL = 0;
countM = 0;
countN = 0;
countO = 0;
countP = 0;
countQ = 0;
countR = 0;
countS = 0;
countT = 0;
countU = 0;
countV = 0;
countW = 0;
countX = 0;
countY = 0;
countZ = 0;
countSpace = 0;
countPoint = 0;
countComma = 0;
countQuestion = 0;

[cH cW cD] = size(im);                       %get size of passed image            

for ii=1:min(aH,cH)                          %for each pixel in im, check if it has the same value as the matching pixel in the character matrix, if zo, higher count with one
    for jj=1:min(aW,cW)
        if im(ii,jj) == patterns(ii,jj,1)
            countA = double(countA) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,2)
            countB = double(countB) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,3)
            countC = double(countC) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,4)
            countD = double(countD) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,5)
            countE = double(countE) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,6)
            countF = double(countF) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,7)
            countG = double(countG) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,8)
            countH = double(countH) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,9)
            countI = double(countI) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,10)
            countJ = double(countJ) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,11)
            countK = double(countK) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,12)
            countL = double(countL) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,13)
            countM = double(countM) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,14)
            countN = double(countN) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,15)
            countO = double(countO) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,16)
            countP = double(countP) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,17)
            countQ = double(countQ) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,18)
            countR = double(countR) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,19)
            countS = double(countS) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,20)
            countT = double(countT) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,21)
            countU = double(countU) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,22)
            countV = double(countV) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,23)
            countW = double(countW) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,24)
            countX = double(countX) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,25)
            countY = double(countY) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,26)
            countZ = double(countZ) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,27)
            countSpace = double(countSpace) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,28)
            countPoint = double(countPoint) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,29)
            countComma = double(countComma) + 1;
        end
        if im(ii,jj) == patterns(ii,jj,30)
            countQuestion = double(countQuestion) + 1;
        end
    end
end

counts = zeros(1,30);               %put all counts toghether in one array
counts(1) = countA;
counts(2) = countB;
counts(3) = countC;
counts(4) = countD;
counts(5) = countE;
counts(6) = countF;
counts(7) = countG;
counts(8) = countH;
counts(9) = countI;
counts(10) = countJ;
counts(11) = countK;
counts(12) = countL;
counts(13) = countM;
counts(14) = countN;
counts(15) = countO;
counts(16) = countP;
counts(17) = countQ;
counts(18) = countR;
counts(19) = countS;
counts(20) = countT;
counts(21) = countU;
counts(22) = countV;
counts(23) = countW;
counts(24) = countX;
counts(25) = countY;
counts(26) = countZ;
counts(27) = countSpace;
counts(28) = countPoint;
counts(29) = countComma;
counts(30) = countQuestion;

maxCount = max(counts);                         %determine maximum of counts (most likely, this is the right character)
[H W D] = size(im);                             %get size of passed image
if (maxCount <= 0)               %make sure that only a character is returned when the nr of pixel matches is bigger than threshold    
    maxCount = -1;
end

switch maxCount
    case countA
        c = 'A';
    case countB
        c = 'B';
    case countC
        c = 'C';
    case countD
        c = 'D';
    case countE
        c = 'E';
    case countF
        c = 'F';
    case countG
        c = 'G';
    case countH
        c = 'H';
    case countI
        c = 'I';
    case countJ
        c = 'J';
    case countK
        c = 'K';
    case countL
        c = 'L';
    case countM
        c = 'M';
    case countN
        c = 'N';
    case countO
        c = 'O';
    case countP
        c = 'P';
    case countQ
        c = 'Q';
    case countR
        c = 'R';
    case countS
        c = 'S';
    case countT
        c = 'T';
    case countU
        c = 'U';
    case countV
        c = 'V';
    case countW
        c = 'W';
    case countX
        c = 'X';
    case countY
        c = 'Y';
    case countZ
        c = 'Z';
    case countSpace
        c = ' ';
    case countPoint
        c = '.';
    case countComma
        c = ',';
    otherwise               %when character is ? or unknown
        c = '?';
end
c = char(c);   %convert c to char
