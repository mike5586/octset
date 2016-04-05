clear; clc;
file=dir(['*.octraw']);
% pixe=[256,1024];%像素大小
forrm='short';
zz=length(file);
npic=15;%抽取第N张图片
filename=[file(1).name];
filename2=[file(3).name];
fid=fopen(filename);
OCTim=fread(fid,[1,inf],forrm);
fclose(fid);
fid2=fopen(filename2); 
OCTim_bg=fread(fid2,[1,inf],forrm);
fclose(fid2);
bnumber=length(OCTim)/2048;
ioct=reshape(OCTim,[2048,bnumber]);
ioct_bg = reshape(OCTim,[2048,bnumber]);
bg_mean = mean(ioct_bg,2);
roct=[];
spectrum_h=898;
spectrum_l=790;
% inte1=linspace(2*pi/790.293842050356,2*pi/897.859620778833,2048);
% inte2=2*pi./linspace(790.293842050356,897.859620778833,2048);
inte1=linspace(2*pi/spectrum_l,2*pi/spectrum_h,2048);
inte2=2*pi./linspace(spectrum_l,spectrum_h,2048);
inte=interp1(inte2,linspace(pi,-pi,2048),inte1);
for j=1:1024
    %         toct=fftshift(ioct(j,:));
    ioct(:,j)=ioct(:,j)-bg_mean;
    toct=interp1(inte2',ioct(:,j),inte1');
    toct2=interp1(inte2',ioct(:,j),inte1','PCHIP');
    
    roctl(:,j)=ifft(toct);
    roct(:,j)=ifft(ioct(:,j));
    roctc(:,j)=ifft(toct2);
    %         roctd(:,j) =dirft1d1(2048,inte,ioct(:,j),-1,2048);
    %         roctn(:,j)=nufft1d1(2048,inte,ioct(:,j),-1,1e-12,2048);
    %         roctd(:,j)=fftshift( roctd(:,j));
    %         roct(:,j)=ifftshift(roct(:,j));
end
figure
imshow(roctl(1:700,:))
% % % figure;
% % % imshow(roct(1:700,:));
% % % figure;
% % % imshow(abs(roctc(1:700,:)));


% figure;
% imshow(roctd(1:700,:));
% figure;
% imshow(fftshift(roctd(1:700,:)));
% 
% % imshow(roctl)
% % figure(2);
% % imshow(roct);
% % figure(3);
% % imshow(roctc);
% figure;
% % imshow(fftshift(roctd));
% figure;
% imshow(fftshift(roctn));