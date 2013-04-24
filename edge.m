
clear all
I=imread('lena.bmp');
I=double(I);
figure;imshow(uint8(I));
im=I;
[M,N]=size(I);
im_o=zeros(M,N);
sigma=18;
for t=1:1
    for i=2:M-1
        for j=2:N-1
%            tmp=(im(i-1,j)+im(i+1,j)+im(i,j-1)+im(i,j+1))/4;
%            tmp=abs(im(i,j)-tmp);
           if (abs(im(i-1,j)-im(i,j))<sigma)&(abs(im(i+1,j)-im(i,j))<sigma)& (abs(im(i,j-1)-im(i,j))<sigma)& (abs(im(i,j+1)-im(i,j))<sigma)
               im_o(i,j)=0;
           else
               im_o(i,j)=im(i,j);
           end
%            im_o(i,j)=min(im(i,j),tmp);
       end
   end
   im=im_o;
   figure;imshow(uint8(im));
end
index=find(im==I);
tt=ones(256,256);
tt(index)=255;
figure;imshow(uint8(tt))
% im(im>0)=255;
% figure;imshow(uint8(im))