function [y, keep]=symextend(x,fl)

keep=floor((fl+size(x)-1)/2);

y=padarray(x,[(fl-1) (fl-1)],'symmetric','both');