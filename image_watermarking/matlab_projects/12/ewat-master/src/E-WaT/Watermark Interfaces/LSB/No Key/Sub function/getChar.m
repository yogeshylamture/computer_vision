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

function [c maxCount] = getChar(handles, im)

A = uint8(alphabet('a'));                      %for eacht charachter in alphabet.m, get matrix represenation
B = uint8(alphabet('b'));
C = uint8(alphabet('c'));
D = uint8(alphabet('d'));
E = uint8(alphabet('e'));
F = uint8(alphabet('f'));
G = uint8(alphabet('g'));
H = uint8(alphabet('h'));
I = uint8(alphabet('i'));
J = uint8(alphabet('j'));
K = uint8(alphabet('k'));
L = uint8(alphabet('l'));
M = uint8(alphabet('m'));
N = uint8(alphabet('n'));
O = uint8(alphabet('o'));
P = uint8(alphabet('p'));
Q = uint8(alphabet('q'));
R = uint8(alphabet('r'));
S = uint8(alphabet('s'));
T = uint8(alphabet('t'));
U = uint8(alphabet('u'));
V = uint8(alphabet('v'));
W = uint8(alphabet('w'));
X = uint8(alphabet('x'));
Y = uint8(alphabet('y'));
Z = uint8(alphabet('z'));
space = uint8(alphabet(' '));
point = uint8(alphabet('.'));
comma = uint8(alphabet(','));
question = uint8(alphabet('?'));

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
[aH aW aD] = size(alphabet('a'));            %get size of character matrix

for ii=1:min(aH,cH)                          %for each pixel in im, check if it has the same value as the matching pixel in the character matrix, if zo, higher count with one
    for jj=1:min(aW,cW)
        if im(ii,jj) == A(ii,jj)
            countA = double(countA) + 1;
        end
        if im(ii,jj) == B(ii,jj)
            countB = double(countB) + 1;
        end
        if im(ii,jj) == C(ii,jj)
            countC = double(countC) + 1;
        end
        if im(ii,jj) == D(ii,jj)
            countD = double(countD) + 1;
        end
        if im(ii,jj) == E(ii,jj)
            countE = double(countE) + 1;
        end
        if im(ii,jj) == F(ii,jj)
            countF = double(countF) + 1;
        end
        if im(ii,jj) == G(ii,jj)
            countG = double(countG) + 1;
        end
        if im(ii,jj) == H(ii,jj)
            countH = double(countH) + 1;
        end
        if im(ii,jj) == I(ii,jj)
            countI = double(countI) + 1;
        end
        if im(ii,jj) == J(ii,jj)
            countJ = double(countJ) + 1;
        end
        if im(ii,jj) == K(ii,jj)
            countK = double(countK) + 1;
        end
        if im(ii,jj) == L(ii,jj)
            countL = double(countL) + 1;
        end
        if im(ii,jj) == M(ii,jj)
            countM = double(countM) + 1;
        end
        if im(ii,jj) == N(ii,jj)
            countN = double(countN) + 1;
        end
        if im(ii,jj) == O(ii,jj)
            countO = double(countO) + 1;
        end
        if im(ii,jj) == P(ii,jj)
            countP = double(countP) + 1;
        end
        if im(ii,jj) == Q(ii,jj)
            countQ = double(countQ) + 1;
        end
        if im(ii,jj) == R(ii,jj)
            countR = double(countR) + 1;
        end
        if im(ii,jj) == S(ii,jj)
            countS = double(countS) + 1;
        end
        if im(ii,jj) == T(ii,jj)
            countT = double(countT) + 1;
        end
        if im(ii,jj) == U(ii,jj)
            countU = double(countU) + 1;
        end
        if im(ii,jj) == V(ii,jj)
            countV = double(countV) + 1;
        end
        if im(ii,jj) == W(ii,jj)
            countW = double(countW) + 1;
        end
        if im(ii,jj) == X(ii,jj)
            countX = double(countX) + 1;
        end
        if im(ii,jj) == Y(ii,jj)
            countY = double(countY) + 1;
        end
        if im(ii,jj) == Z(ii,jj)
            countZ = double(countZ) + 1;
        end
        if im(ii,jj) == space(ii,jj)
            countSpace = double(countSpace) + 1;
        end
        if im(ii,jj) == point(ii,jj)
            countPoint = double(countPoint) + 1;
        end
        if im(ii,jj) == comma(ii,jj)
            countComma = double(countComma) + 1;
        end
        if im(ii,jj) == question(ii,jj)
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
if (maxCount == 0)               %make sure that only a character is returned when the nr of pixel matches is bigger than threshold    
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
