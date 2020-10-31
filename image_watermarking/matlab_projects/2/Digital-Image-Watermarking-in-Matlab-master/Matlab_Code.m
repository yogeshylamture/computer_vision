a=imread('medium_key.jpg');% Original image
% a=imresize(a,[512,512]);
ac=im2double(a);
red=ac(:,:,3);% blue component of the original image
w=imread('high_key.jpg'); 
% w=imresize(w,[512,512]);% Watermark
wc=im2double(w);
% Level 1 Decomposition
[A1 H1 V1 D1]=dwt2(red,'haar');
sa1=wcodemat(A1);
sh1=wcodemat(H1);
sv1=wcodemat(V1);
sd1=wcodemat(D1);
% level 2 Decomposition
[A2 H2 V2 D2]=dwt2(A1,'haar');
sh2=wcodemat(H2);
sv2=wcodemat(V2);
sd2=wcodemat(D2);
% level 3 Decomposition
[A3 H3 V3 D3]=dwt2(A2,'haar');
sa3=wcodemat(A3);
sh3=wcodemat(H3);
sv3=wcodemat(V3);
sd3=wcodemat(D3);
s3=[sa3,sh3;sv3,sd3];
s2=[s3,sh2;sv2,sd2];
s1=[s2,sh1;sv1,sd1];
image(s1); % image showing the 3 level decomposition

M=zeros();

 frame=D3;
 I =double(frame);
sigma=0.5; Thrshold=52000; r=6; disp=1;
dx=[-1 0 1;-1 0 1;-1 0 1];
dy=dx;


 Ix = conv2(I, dx, 'same');  
 Iy = conv2(I, dy, 'same');
 g = fspecial('gaussian',max(1,fix(6*sigma)), sigma); %%%%%% Gaussian Filter
    
    %%%%% 
 Ix2 = conv2(Ix.^2, g, 'same');  
 Iy2 = conv2(Iy.^2, g, 'same');
 Ixy = conv2(Ix.*Iy, g,'same');
 k = 0.05;
 R11 = (Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2;
 R11=(1000/max(max(R11)))*R11;
 R=R11;
 ma=max(max(R));
 MX = ordfilt2(R,900,ones(30,30));
 R11 = (R==MX)&(R>Thrshold); 
    %count=sum(sum(R11(5:size(R11,1)-5,5:size(R11,2)-5)));
 R=R*0;
 R(5:size(R11,1)-5,5:size(R11,2)-5)=R11(5:size(R11,1)-5,5:size(R11,2)-5);
 [r1,c1] = find(R);
 PIP=[r1,c1];%% IP 
   



 Size_PI=size(PIP,1);
for r=1: Size_PI
   I(PIP(r,1)-2:PIP(r,1)+2,PIP(r,2)-2)=255;
   I(PIP(r,1)-2:PIP(r,1)+2,PIP(r,2)+2)=255;
   I(PIP(r,1)-2,PIP(r,2)-2:PIP(r,2)+2)=255;
   I(PIP(r,1)+2,PIP(r,2)-2:PIP(r,2)+2)=255;
   
end
j=uint8(I);
imshow(j);

 minx=min(r1(:));
 maxx=max(r1(:));
 miny=min(c1(:));
 maxy=max(c1(:));
 display(maxx);
w=imread('high_key.jpg');
% w=imresize(w,[512,512]);
w1=im2double(w);
r2=r1;
c2=c1;
for i=1:2498
    k1=unidrnd(100,1,2);
    h1=k1(1,1);
    h2=k1(1,2);
    x=floor(minx*(h1/200)+maxx*(1-(h1/200)));
    y=floor(miny*(h2/200)+maxy*(1-(h2/200)));
    r2(i+2)=x;
    c2(i+2)=y;
end


T3=D3;

k=1;
for i=1:50
    for j=1:50
        D3(r2(k),c2(k))=T3(r2(k),c2(k))+0.15*w1(i,j);
        a1(i,j)=D3(r2(k),c2(k));
        k=k+1;
    end
end

[l,m]=size(D3); 
[l1,m1]=size(wc);
p=floor(l/l1);
q=floor(m/m1);
i=1:floor(l/l1);
j=1:floor(m/m1);
for i1=1:l1
    for j1=1:m1
        temp=i1+(i-1)*l1;
        temp1=j1+(j-1)*m1;
        M(i1,j1)=a1(temp,temp1);
    end
end
[l3,m3]=size(M);
for i2=1:l3
    
    for j2=1:m3
        
        temp=i2+(i-1)*l3;
        temp1=j2+(j-1)*m3;
        newmatrix(temp,temp1)=M(i2,j2);
    end
end
[l4,m4]= size(newmatrix);
i=rem(l,l1);
j=rem(m,m1);
for i=1:l4
    for j=1:m4
        p1(i,j)=newmatrix(i,j);
    end
end
for i=(l4+1):l
    for j=1:m4
        p1(i,j)=D3(i,j);
    end
end
for j=(m4+1):m
    for i=1:l
       p1(i,j)=D3(i,j);
    end
end



new9=p1;
awk1= idwt2(A3,H3,V3,new9,'haar');
awk2= idwt2(awk1,H2,V2,D2,'haar');
finalimage= idwt2(awk2,H1,V1,D1,'haar');
newimage12(:,:,3)=finalimage;
green=ac(:,:,2);
newimage12(:,:,2)=green;
red=ac(:,:,1);
newimage12(:,:,1)=red;
Imwrite(newimage12 ,'newimage14.bmp');
imshow('newimage14.bmp');

a=imread('medium_key.jpg');% Original image
% a=imresize(a,[512,512]);
ac1=im2double(a);
redo=ac1(:,:,3);% blue component of the original image
newimage12=imscale(newimage12,1);
imshow(newimage12);
k=(newimage12+1)/100;
j1=(k*100)-1;

b=im2double(j1);

redw=b(:,:,3);

w=imread('high_key.jpg');% Watermark
% w=imresize(w,[512,512]);

wc=im2double(w);

[l1 m1]=size(wc);

display(size(wc));
original=redo;
watermarked=redw;
% DWT2 on original image
[A1 H1 V1 D1]=dwt2(original,'haar');
[A2 H2 V2 D2]=dwt2(A1,'haar');
[A3 H3 V3 D3]=dwt2(A2,'haar');
%display(H3);
display(size(D3));
% DWT2 on watermarked image
[aw1 hw1 vw1 dw1]=dwt2(watermarked,'haar');
[aw2 hw2 vw2 dw2]=dwt2(aw1,'haar');
[aw3 hw3 vw3 dw3]=dwt2(aw2,'haar');

k=1;
for i=1:50
    
    for j=1:50
        w2(i,j)=(dw3(r2(k),c2(k))-D3(r2(k),c2(k)))/0.15;
        k=k+1;
    end
end

imager=w1;
imwrite(imager,'water4.png');

imshow('water4.png');
