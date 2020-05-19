X=imread('lh.jpg'); 
X=X(1:256,1:256); 
imshow(uint8(X)); 
[a1,a2]=size(X); 
disp('The number of rows in input image are'); 
disp(a1); 
disp('The number of coloums in input image are'); 
disp(a2); 
title('Input image'); 
[cA1,cH1,cV1,cD1] = dwt2(X,'haar'); 
[C,S] = wavedec2(X,1,'haar'); 
A1 = wrcoef2('a',C,S,'haar',1); 
H1 = wrcoef2('h',C,S,'haar',1); 
V1 = wrcoef2('v',C,S,'haar',1); 
D1 = wrcoef2('d',C,S,'haar',1); 
colormap(gray); 
subplot(2,2,1); image(wcodemat(A1,192)); 
title('Approximation A1') 
subplot(2,2,2); image(wcodemat(H1,192)); 
title('Horizontal Detail H1') 
subplot(2,2,3); image(wcodemat(V1,192)); 
title('Vertical Detail V1') 
subplot(2,2,4); image(wcodemat(D1,192)); 
title('Diagonal Detail D1') 
re_ima1 = idwt2(cA1,cH1,cV1,cD1,'haar'); 
re_ima=uint8(re_ima1); 
figure; 
subplot(2,1,1); 
imshow(uint8(X)); 
title('Input image'); 
subplot(2,1,2); 
imshow(re_ima); 
title('1-level reconstructed image') 
[C,S] = wavedec2(X,2,'haar'); 
A2 = wrcoef2('a',C,S,'haar',2); 
A1 = wrcoef2('a',C,S,'haar',1); 
H1 = wrcoef2('h',C,S,'haar',1); 
V1 = wrcoef2('v',C,S,'haar',1); 
D1 = wrcoef2('d',C,S,'haar',1); 
H2 = wrcoef2('h',C,S,'haar',2); 
V2 = wrcoef2('v',C,S,'haar',2); 
D2 = wrcoef2('d',C,S,'haar',2); 
colormap(gray); 
subplot(2,4,1);image(wcodemat(A1,192)); 
title('Approximation A1') 
subplot(2,4,2);image(wcodemat(H1,192)); 
title('Horizontal Detail H1') 
subplot(2,4,3);image(wcodemat(V1,192));
title('Vertical Detail V1') 
subplot(2,4,4);image(wcodemat(D1,192)); 
title('Diagonal Detail D1') 
subplot(2,4,5);image(wcodemat(A2,192)); 
title('Approximation A2') 
subplot(2,4,6);image(wcodemat(H2,192)); 
title('Horizontal Detail H2') 
subplot(2,4,7);image(wcodemat(V2,192)); 
title('Vertical Detail V2') 
subplot(2,4,8);image(wcodemat(D2,192)); 
title('Diagonal Detail D2');
dec2d = [A2,A1,H1,V1,D1,H2,V2,D2]; 
re_ima1 = waverec2(C,S,'haar'); 
re_ima=uint8(re_ima1); 
figure; 
subplot(2,1,1); 
imshow(uint8(X)); 
title('Input image'); 
subplot(2,1,2); 
imshow(re_ima); 
title('2-level reconstructed image'); 
n=input('enter the decomposition level'); 
X=imread('lh.jpg'); 
X=X(1:256,1:256); 
X=double(X)-128; 
[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters('haar'); 
[c,s]=wavedec2(uint8(X),n,Lo_D,Hi_D); 
disp('Decomposition vector of size 1*524288 is stored in c'); 
disp('Coressponding book keeeping matrix'); 
disp(s); 
[thr,nkeep] = wdcbm2(uint8(dec2d),1.5,prod(s(1,:))); 
[THR,SORH,KEEPAPP,CRIT] = ddencmp('cmp','wp',uint8(X)); 
[XC,TREED,PERF0,PERFL2] =wpdencmp(X,SORH,2,'haar',CRIT,THR,KEEPAPP); 
disp('Level-dependent thresholds');
disp(THR); 
disp('The entropy used is'); 
disp(CRIT); 
disp('The type of thersholding is'); 
if SORH==s 
disp('Soft Thresholding'); else 
disp('Hard Thresholding'); end 
disp('Approximation coefficients are'); 
disp(KEEPAPP); 
disp('Wavelet packet best tree decomposition of XD'); 
disp(TREED); 
disp('The L^2 recovery'); 
disp(PERFL2); 
disp('The compression scores in percentages'); 
disp(PERF0); 
XC=double(X)+128; 
XO=uint8(XC); 
imshow(XO); 
title('Output image'); 
[b1,b2]=size(XC); 
disp('The number of rows in compressed image are');
disp(b1); 
disp('The number of coloums in image are'); 
disp(b2); 
imshow(XO) 
title('output') 
imwrite(XO,'cathaarcomp.jpg');
