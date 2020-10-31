function[new,b,c]=watermark(a)
wm=[1 1 1 1 1 1 1 1;
    1 1 2 2 2 2 1 1;
    1 1 1 2 2 1 1 1;
    1 1 1 2 2 1 1 1;
    1 1 1 2 2 1 1 1;
    1 1 1 2 2 1 1 1;
    1 1 1 2 2 1 1 1;
    1 1 1 1 1 1 1 1];
d=dct(wm);
[p q r]=size(a);
n=0;
n=int32(n);
if r==3
    ('Watermark embedding in Colour Image');
else
    ('Watermark embedding in GrayCode Image');
end
for i=1:p
    for j=1:q
        n=n+int32(a(i,j,1));
    end
end
if ((p/8)*(q/8))>10000
    c=rem(n,10000);
elseif ((p/8)*(q/8))>1000
    c=rem(n,1000);
elseif ((p/8)*(q/8))>100
    c=rem(n,100);
end
count=0;
for i=1:p/8
    for j=1:q/8
        count=count+1;
        if count==c
            break;
        end
    end
    if count==c
        break;
    end
end
i=i-1;
j=j-1;
b=a(i*8+1:i*8+8,j*8+1:j*8+8,1);
new=a;
for i1=1:8
    for j1=1:8
        new(i*8+i1,j*8+j1,1)=new(i*8+i1,j*8+j1,1)+wm(i1,j1,1);
    end
end

