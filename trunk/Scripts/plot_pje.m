%plot missing spikes as a function of intensity



ft30sg=fit(table_y30px(4,:)',table_y30px(7,:)','poly1');
figure
plot(table_y30px(4,:),table_y30px(7,:),'x');
hold on
plot(ft30sg);
title('Sagittal stripes, 30px')

ft60sg=fit(table_y60px(4,:)',table_y60px(7,:)','poly1');
figure
plot(table_y60px(4,:),table_y60px(7,:),'x');
hold on
plot(ft60sg);
title('Sagittal stripes, 60px')

ft90sg=fit(table_y90px(4,:)',table_y90px(7,:)','poly1');
figure
plot(table_y90px(4,:),table_y90px(7,:),'x');
hold on
plot(ft90sg);
title('Sagittal stripes, 90px')

ft30ml=fit(table_x30px(4,:)',table_x30px(7,:)','poly1');
figure
plot(table_x30px(4,:),table_x30px(7,:),'x');
hold on
plot(ft30ml);
title('Mediolateral stripes, 30px')

ft60ml=fit(table_x60px(4,:)',table_x60px(7,:)','poly1');
figure
plot(table_x60px(4,:),table_x60px(7,:),'x');
hold on
plot(ft60ml);
title('Mediolateral stripes, 60px')

ft90ml=fit(table_x90px(4,:)',table_x90px(7,:)','poly1');
figure
plot(table_x90px(4,:),table_x90px(7,:),'x');
hold on
plot(ft90ml);
title('Mediolateral stripes, 90px')

%plot response amplitudes as a function of intensity, for stripes and for
%squares on the same graph

ft300_resp=fit(table_y300px(4,:)',table_y300px(5,:)','poly1');

%only fit for intensities below 100 uW (where most data points are):
inds=find(table_y300px(4,:)<=100);
ft300_x100_resp=fit(table_y300px(4,inds)',table_y300px(5,inds)','poly1');


ft30sag_resp=fit(table_y30px(4,:)',table_y30px(5,:)','poly1');
figure
plot(table_y30px(4,:),table_y30px(5,:),'or');
hold on
plot(table_y300px(4,:),table_y300px(5,:),'ok');
xlim([0 100])
hold on
plot(ft30sag_resp,'r');
% hold on
% plot(ft300_resp,'k');
hold on
plot(ft300_x100_resp,'k--');
title('Sagittal stripes vs. Squares, 30px');

ft60sag_resp=fit(table_y60px(4,:)',table_y60px(5,:)','poly1');
figure
plot(table_y60px(4,:),table_y60px(5,:),'or');
hold on
plot(table_y300px(4,:),table_y300px(5,:),'ok');
xlim([0 100])
hold on
plot(ft60sag_resp,'r');
% hold on
% plot(ft300_resp,'k');
hold on
plot(ft300_x100_resp,'k--');
title('Sagittal stripes vs. Squares, 60px');

ft90sag_resp=fit(table_y90px(4,:)',table_y90px(5,:)','poly1');
figure
plot(table_y90px(4,:),table_y90px(5,:),'or');
hold on
plot(table_y300px(4,:),table_y300px(5,:),'ok');
xlim([0 100])
hold on
plot(ft90sag_resp,'r');
% hold on
% plot(ft300_resp,'k');
hold on
plot(ft300_x100_resp,'k--');
title('Sagittal stripes vs. Squares, 90px');

ft30ml_resp=fit(table_x30px(4,:)',table_x30px(5,:)','poly1');
figure
plot(table_x30px(4,:),table_x30px(5,:),'or');
hold on
plot(table_x300px(4,:),table_x300px(5,:),'ok');
xlim([0 100])
hold on
plot(ft30ml_resp,'r');
% hold on
% plot(ft300_resp,'k');
hold on
plot(ft300_x100_resp,'k--');
title('Mediolateral stripes vs. Squares, 30px');

ft60ml_resp=fit(table_x60px(4,:)',table_x60px(5,:)','poly1');
figure
plot(table_x60px(4,:),table_x60px(5,:),'or');
hold on
plot(table_x300px(4,:),table_x300px(5,:),'ok');
xlim([0 100])
hold on
plot(ft60ml_resp,'r');
% hold on
% plot(ft300_resp,'k');
hold on
plot(ft300_x100_resp,'k--');
title('Mediolateral stripes vs. Squares, 60px');

ft90ml_resp=fit(table_x90px(4,:)',table_x90px(5,:)','poly1');
figure
plot(table_x90px(4,:),table_x90px(5,:),'or');
hold on
plot(table_x300px(4,:),table_x300px(5,:),'ok');
xlim([0 100])
hold on
plot(ft90ml_resp,'r');
% hold on
% plot(ft300_resp,'k');
hold on
plot(ft300_x100_resp,'k--');
title('Mediolateral stripes vs. Squares, 90px');

%
figure
plot(table_y60px(4,:),table_y60px(5,:),'or');
hold on
plot(table_x60px(4,:),table_x60px(5,:),'ob');
hold on
plot(table_y300px(4,:),table_y300px(5,:),'ok');
xlim([0 100])
title('All stripes vs. Squares, 60px');

