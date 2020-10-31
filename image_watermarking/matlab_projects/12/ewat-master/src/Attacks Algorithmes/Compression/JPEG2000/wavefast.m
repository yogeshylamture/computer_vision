function [c,s]=wavefast(x,n,varargin)

error(nargchk(3,4,nargin));

if nargin==3
    if ischar(varargin{1})
        [lp,hp]=wavefilter(varargin{1},'d');
    else 
        error('Missing wavelet name.');
    end
else 
    lp=varargin{1}; hp=varargin{2};
end

fl=length(lp);sx=size(x);
if (ndims(x)~=2) || (min(sx)<2) || ~isreal(x) || ~isnumeric(x)
    error('X must be a real ,numeric matric.');
end

if(ndims(lp)~=2) || ~ isreal(lp) || ~isnumeric(lp) || (ndims(hp) ~=2) || ~ isreal(hp) || ~isnumeric(hp) || (fl~=length(hp)) || rem(fl,2)~=0
    error('LP and HP must be ever and equal length real numeric filter vector.');
end

if ~isreal(n) || ~isnumeric(n) ||(n<1) ||(n>log2(max(sx)))
    error('N must be a real scalar between 1 and log2(max(size(X))).');
end

c=[];s=sx;app=double(x);
for i=1:n
    [app,keep]=symextend(app,fl);
    rows=symconv(app,hp,'row',fl,keep);
    coefs=symconv(rows,hp,'col',fl,keep);
    c=[coefs(:)' c]; s=[size(coefs);s];
    coefs=symconv(rows,lp,'col',fl,keep);
    c=[coefs(:)' c];
    rows=symconv(app,lp,'row',fl,keep);
    coefs=symconv(rows,hp,'col',fl,keep);
    c=[coefs(:)' c];
    app=symconv(rows,lp,'col',fl,keep);
end
c=[app(:)' c]; s=[size(app);s];



