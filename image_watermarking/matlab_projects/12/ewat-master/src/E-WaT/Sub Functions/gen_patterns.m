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

%gen_patterns: generates random patterns with the passed arguments
%@key: key used to set initialisation state of random gen
%@aH: height of pattern
%@aW: widt of pattern
%§pattern matrix: matrix containing all the different patterns
function pattern_matrix = gen_patterns(key, aH, aW)

randn('state', key);                %reset state of random generator to the value of key
A =  im2bw(randn(aH, aW), 0.4);     %generate patterns for each of the necessary characters
B =  im2bw(randn(aH, aW), 0.4);
C =  im2bw(randn(aH, aW), 0.4);
D =  im2bw(randn(aH, aW), 0.4);
E =  im2bw(randn(aH, aW), 0.4);
F =  im2bw(randn(aH, aW), 0.4);
G =  im2bw(randn(aH, aW), 0.4);
H =  im2bw(randn(aH, aW), 0.4);
I =  im2bw(randn(aH, aW), 0.4);
J =  im2bw(randn(aH, aW), 0.4);
K =  im2bw(randn(aH, aW), 0.4);
L =  im2bw(randn(aH, aW), 0.4);
M =  im2bw(randn(aH, aW), 0.4);
N =  im2bw(randn(aH, aW), 0.4);
O =  im2bw(randn(aH, aW), 0.4);
P =  im2bw(randn(aH, aW), 0.4);
Q =  im2bw(randn(aH, aW), 0.4);
R =  im2bw(randn(aH, aW), 0.4);
S =  im2bw(randn(aH, aW), 0.4);
T =  im2bw(randn(aH, aW), 0.4);
U =  im2bw(randn(aH, aW), 0.4);
V =  im2bw(randn(aH, aW), 0.4);
W =  im2bw(randn(aH, aW), 0.4);
X =  im2bw(randn(aH, aW), 0.4);
Y =  im2bw(randn(aH, aW), 0.4);
Z =  im2bw(randn(aH, aW), 0.4);
space =  im2bw(randn(aH, aW), 0.4);
point =  im2bw(randn(aH, aW), 0.4);
comma =  im2bw(randn(aH, aW), 0.4);
question =  im2bw(randn(aH, aW), 0.4);

pattern_matrix = zeros(aH,aW,30);
pattern_matrix(:,:,1) = A;
pattern_matrix(:,:,2) = B;
pattern_matrix(:,:,3) = C;
pattern_matrix(:,:,4) = D;
pattern_matrix(:,:,5) = E;
pattern_matrix(:,:,6) = F;
pattern_matrix(:,:,7) = G;
pattern_matrix(:,:,8) = H;
pattern_matrix(:,:,9) = I;
pattern_matrix(:,:,10) = J;
pattern_matrix(:,:,11) = K;
pattern_matrix(:,:,12) = L;
pattern_matrix(:,:,13) = M;
pattern_matrix(:,:,14) = N;
pattern_matrix(:,:,15) = O;
pattern_matrix(:,:,16) = P;
pattern_matrix(:,:,17) = Q;
pattern_matrix(:,:,18) = R;
pattern_matrix(:,:,19) = S;
pattern_matrix(:,:,20) = T;
pattern_matrix(:,:,21) = U;
pattern_matrix(:,:,22) = V;
pattern_matrix(:,:,23) = W;
pattern_matrix(:,:,24) = X;
pattern_matrix(:,:,25) = Y;
pattern_matrix(:,:,26) = Z;
pattern_matrix(:,:,27) = space;
pattern_matrix(:,:,28) = point;
pattern_matrix(:,:,29) = comma;
pattern_matrix(:,:,30) = question;

