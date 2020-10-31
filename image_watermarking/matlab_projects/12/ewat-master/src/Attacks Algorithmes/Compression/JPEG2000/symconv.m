function y=symconv(x,h,type,fl,keep)
if strcmp(type, 'row')
    y=conv2(x,h);
    y=y(:,1:2:end);
    y=y(:,fl/2+1:fl/2+keep(2));
else
    y=conv2(x,h');
    y=y(1:2:end,:);
    y=y(fl/2+1:fl/2+keep(2),:);
end