% figure(1)
% clf
% plot(globx.Data,globy.Data)
% xlabel('X')
% ylabel('Y')
% legend('carloc')
% grid on
% figure(2)
% clf
% plot(phi.time,phi.Data)
% xlabel('time')
% ylabel('r')
% legend('vel')
% grid on
loss(1)=std2(forstd.Data);
loss(2)=std2(heading_error.Data)  % u=5,10,15,20,25,30,35,40
figure(3)
clf
plot(x_fine,y_fine)
hold on;
plot(x_fine_real.Data,y_fine_real.Data)
hold off;
xlim([0 180]);
ylim([-10 30]);
legend('desire path','car path');
pbaspect([4.5 1 1]);
grid on 
xlabel('x(m)')
ylabel('y(m)')
% 5 - 0.1455