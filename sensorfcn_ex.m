function [output] = sensorfcn_ex(input)

global x_des y_des heading_des r_des 

car_y = input(1);
car_x = input(2);
yaw = input(3);

b = 1.14; 
L = 2.54;
a = L-b;

tire_x=car_x+a*cos(yaw);
tire_y=car_y+a*sin(yaw);

new_dist = 0;
heading_diff = 0;
rd = 0;

%% 여기를 채우시오
% 차량의 전륜 중심으로부터 경로 최근접 점 찾기
% 해당 점까지의 거리 dist와 해당 점의 경로 heading과 차량의 yaw로부터 heading_diff 구하기
% 해당 점에서 yawrate desired(r_des) rd에 입력
n=0;
dist=inf;
for i=1:(length(x_des)-1)
    new_dist = sqrt((x_des(i) - tire_x)^2 + (y_des(i) - tire_y)^2);
    if dist>new_dist
        dist=new_dist;
        n=i;
    end
end

% 최단거리 점:n
point1=[tire_x-x_des(n),tire_y-y_des(n)];% 경로의 점에서 타이어 점까지
point2=[cos(heading_des(n)),sin(heading_des(n))];
%point2=[x_des(n),y_des(n)];%경로의 점
updown=point2(1) * point1(2) - point2(2) * point1(1);
if updown>0
    dist=-dist
end
path_heading=((y_des(n+1)-y_des(n))/(x_des(n+1)-x_des(n))+(y_des(n)-y_des(n-1))/(x_des(n)-x_des(n-1)))/2;

heading_diff = path_heading - yaw;

% if n < length(x_des)-1
%     path_heading_diff = diff(atan2(y_des(n+1:n+2) - y_des(n:n+1), x_des(n+1:n+2) - x_des(n:n+1)));
%     rd = path_heading_diff;
% else
%     rd = 0;
% end

rd = r_des(n);
output = [dist, heading_diff, rd];
