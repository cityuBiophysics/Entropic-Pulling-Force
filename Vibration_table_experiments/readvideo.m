clear
[frame, Color, xx, yy]= readvars('./4cmsingle.csv');
f_length = max(frame);
figure (1)
outputVideo = VideoWriter('4cmsingle.avi');
outputVideo.FrameRate = 100;
open(outputVideo);
% 设置图形属性的默认值
set(groot, 'DefaultFigureColor', 'white'); % 设置默认图框颜色为白色
set(groot, 'DefaultAxesFontSize', 13); % 设置默认坐标轴字体大小为12

for n = 1
   xxi1 = xx(frame==n);
   yyi1 = yy(frame==n);
   ci =  Color(frame==n);
   xxb(n) = mean(xxi1(ci==2));
   yyb(n) = mean(yyi1(ci==2));
end
lastX = xxb(1);
lastY = yyb(1);
xxq = [];
yyq = [];
for n = 2:f_length
   xxi1 = xx(frame==n);
   yyi1 = yy(frame==n);
   ci =  Color(frame==n);
   xxb(n) = mean(xxi1(ci==2));
   yyb(n) = mean(yyi1(ci==2));
   xxq(n) = mean(xxi1(ci==2));
   yyq(n) = mean(yyi1(ci==2));
   if abs(xxb(n)- lastX)> 60
     xxb(n) = NaN;
     yyb(n) = NaN;
   end
      if abs(yyb(n)-lastY) > 90
     xxb(n) = NaN;
     yyb(n) = NaN;
      end
   if ~isnan(xxb(n))
       lastX = xxb(n);
       lastY = yyb(n);
   end
end
yb = (fillmissing(yyb,'linear')-370)/660*30;
xb = (fillmissing(xxb,'linear')-120)/660*30;
for i = 1:f_length
   xxi1 = xx(frame==i);
   yyi1 = yy(frame==i);
   ci =  Color(frame==i);
   xxS = (xxi1(ci==1)-120)/660*30;
   yyS = (yyi1(ci==1)-375)/660*30;
   plot(-yyS,-xxS,'ko','MarkerSize',5);
   hold on
   plot(-yb(i),-xb(i),'bo','MarkerSize',5,'MarkerFaceColor','b')
   plot(-[yb(i) yyS(34)],-[xb(i) xxS(34)],'LineWidth',1.5)
   hold off
   ylim([-6,6]);
   xlim([-16,16]);
   xlabel('X-displacement (cm) ')
   ylabel('Y-displacement (cm)')
   writeVideo(outputVideo,getframe(gcf));
end
close(outputVideo);
