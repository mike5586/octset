clear; clc;
close all;
file=dir(['*.csv']);
raw_test_bg=csvread('010a.csv');%背景文件
for j=1:10%数据数量
    raw_test_tr=csvread(file(j).name);
    raw_test=raw_test_tr;
    raw_no_sub=raw_test_tr(:,2);
   
    raw_test(:,2)=raw_test_tr(:,2)-raw_test_bg(:,2);
    OCTim=raw_test(:,2);
    inte3=raw_test(:,1);%频谱坐标
    
    [pox_max pox_inte]=find(inte3<=710);
    [pox_min pox_inte]=find(inte3>=650);
    oct_range=[pox_min(1):pox_max(end)];
    raw_no_sub=raw_no_sub(oct_range)%原始未减去背景
    ioct=OCTim(oct_range)';
    inte2=fliplr(2*pi./inte3(oct_range)');
    inte1=linspace(min(inte2),max(inte2),303);
    toct=interp1(inte2,ioct,inte1);
    % inte2=2*pi./linspace(spectrum_l,spectrum_h,2048);
    %  subplot(4,4,3)
    
%     h=figure%显示去直流信号后的频域图
%     plot(inte3(oct_range),ioct);
%     saveas(h,num2str(j),'jpg')
%     h1=figure
%     offt=ifft(toct);%显示空间域图像
%     offt=ifftshift(offt);
%     plot(abs(offt));
%     saveas(h1,[num2str(j),'s'],'jpg');
    h2=figure;%原始信号
    
    plot(inte3(oct_range),raw_no_sub);
    saveas(h2,[num2str(j),'raw'],'jpg')
  
    %test version1
end
%   subplot(4,1)