function y=im2jpeg2k(x,n,q)

% IM2JPEG2K Compresses an image wsing a JPEG 2000 approximation.
%  Y=IM2JPEG2K(X,N,Q) compresses image X using an N-scale JPEG
%  2K wavelet transform,implicit or explicit coefficient
%  quantization, and Huffman sybol coding augmented by zero
%  run-length coding. IF quantization vector Q contains two
%  elementers, they are assumed to be implicit quantization
%  parameters; else, it is assumed to contain explicit subband step
%  sizes. Y is an encoding structure containing Huffman-encoded
%  data and additional parameters needed by JPEG2K2IM for decoding
%
%  See also JPEG2K2IM.

global RUNS

error(nargchk(3, 3, nargin));      %Check input arguments
if ndims(x) ~= 2 | ~isreal(x) | ~isnumeric(x) | ~isa(x, 'uint8')
    error('The input must be a UINT8 image.');
end

if length(q) ~= 2 & length(q) ~= 3 * n + 1
    error('The quantization step size vector is bad.');
end

% Level shift the input and compute its wavelet transform

x = double(x) - 128;

[c,s] = wavefast(x, n, 'haar');

%Quantize the wavelet coefficients.
q = stepsize(n,q);
sgn = sign(c); 
sgn(find(sgn==0)) = 1;
c = abs(c);

for k = 1:n
    qi = 3 * k -2
    c = wavepaste('h',c,s,k,wavecopy




in the table.Return the index of the run.

global RUNS

y = find(RUNS == x);

if length(y) ~= 1

    RUNS = [RUNS; x];

    y = length(RUNS);

end



%-------------------------------------------------------------------------%

function q = stepsize(n, p)

% Create a subband quantization array of stepsizes ordered by

% decomposition (first to last) and subband (herizontal, vertical'

% diagonal, and for final decomposition the approximation subband).



if length(p) == 2            % Implicit Quantization

    q = [];

    qn = 2 ^ (8 - p(2) + n) * (1+ p(1) / 2 ^ 11);

    for k = l:n

        qk = 2 ^ - k * qn;

        q = [q (2 * qk) (2 * qk) (4 * qk)];

    end

    q = [q qk];

else                         % Explicit Quantization      

    q = p;

end



q = round(q * 100) / 100;    % Round to 1/100th place

if any(100 * q > 65535)

    error('The quantizing steps are not UNIT16 representable.');

end

if any(q == 0)

    error('A quantizing step of 0 is not allowed.');

end    