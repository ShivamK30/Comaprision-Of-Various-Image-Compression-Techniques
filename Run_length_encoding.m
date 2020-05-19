clc; 
clear; 
close all; 
quantizedvalue=10; 
InputImage=imread('rsz_lighthouse.jpg'); 
[row col p]=size(InputImage); 
[LL LH HL HH]=dwt2(InputImage,'haar'); 
WaveletDecomposeImage=[LL,LH;HL,HH]; 
imshow(WaveletDecomposeImage,[]); 
QuantizedImage= WaveletDecomposeImage/quantizedvalue; 
QuantizedImage= round(QuantizedImage); 
ImageArray=zigzag(QuantizedImage); 
j=1; 
a=length(ImageArray); 
count=0; 
for n=1:a 
b=ImageArray(n); 
if n==a 
count=count+1; 
c(j)=count; 
s(j)=ImageArray(n); 
elseif ImageArray(n)==ImageArray(n+1) 
count=count+1; 
elseif ImageArray(n)==b
count=count+1; 
c(j)=count; 
s(j)=ImageArray(n); 
j=j+1; 
count=0; 
end 
end 
g=length(s); 
j=1; 
l=1; 
for i=1:g 
v(l)=s(j); 
if c(j)~=0 
w=l+c(j)-1; 
for p=l:w 
v(l)=s(j); 
l=l+1; 
end 
end 
j=j+1; 
end 
ReconstructedImageArray=v; 
ReconstructedImage=invzigzag(ReconstructedImageArray,row,p/row); 
ReconstructedImage=ReconstructedImage*quantizedvalue; 
sX = size(ReconstructedImage);
cA1 = ReconstructedImage(1:(sX(1)/2), 1:(sX(1)/2)); 
cH1 = ReconstructedImage(1:(sX(1)/2), (sX(1)/2 + 1):sX(1)); 
cV1 = ReconstructedImage((sX(1)/2 + 1):sX(1), 1:(sX(1)/2)); 
cD1 = ReconstructedImage((sX(1)/2 + 1):sX(1), (sX(1)/2 + 1):sX(1)); 
ReconstructedImage = idwt2(cA1,cH1,cV1,cD1,'haar'); 
subplot(1,2,1);imshow(InputImage);title('Input Image'); 
subplot(1,2,2);imshow(ReconstructedImage,[]);title('Reconstructed Image'); 
imwrite(ReconstructedImage,'constructed.jpg'); 
xx=dir('constructed.jpg'); 
s1=xx.bytes 
yy=dir('rsz_lighthouse.jpg'); 
s2=yy.bytes 
compression_ratio=s2/s1;
