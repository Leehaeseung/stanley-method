clear all

global x_des y_des heading_des r_des

b = 1.14; % distance c.g. to front axle (m)
L = 2.54; % wheel base (m)
m = 1500; % mass (kg)
Iz = 2420.0; % yaw moment of inertia (kg-m^2)
Car = 44000*2; % cornering stiffness--front axle (N/rad)
Caf = 47000*2; % cornering stiffness-- rear axle (N/rad)
a=L-b; g=9.81;
Kus = m*b/(L*Caf) - m*a/(L*Car); % (rad/(m/sec^2))
u0=10; % forward speed in m/sec
u = u0;

A = [-(Caf+Car)/(m*u0) (b*Car-a*Caf)/(m*u0)-u0;
(b*Car-a*Caf)/(Iz*u0) -(a*a*Caf+b*b*Car)/(Iz*u0)];
B = [Caf/m; a*Caf/Iz];
C = eye(2);
D = [0; 0];

theta1 = linspace(-0.5*pi, 3.5*pi, 340); % 첫 번째 원 (좌회전)
line2_x=linspace(0.5,50,100);
line2_y=linspace(0,0,100);

x1 = 10*theta1+5*pi;
y1 = 10*sin(theta1)+10;

x2= 40*pi+line2_x;
y2= line2_y;

x_des=[x1,x2];
y_des=[y1,y2];

x_fine=x_des;
y_fine=y_des;

% load path_DLC.mat
% 
% x_des=x_fine;
% y_des=y_fine;

heading_des = atan2([0 diff(y_des)],[0 diff(x_des)]);

r_des = u0*[0 diff(heading_des)]/0.5;




