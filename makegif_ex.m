theta = linspace(0,2*pi,80);
veh_frame = [
    -1.5, 1.5;
    -1.5, -1.5;
    0, -1.5;
    0.75, -1.4;
    1.5, -1.2;
    1.875, -0.9;
    2, -0.4;
    2, 0.4
    1.875, 0.9;
    1.5, 1.2;
    0.75, 1.4;
    0, 1.5;
    0.8,1
    0.8,-1
    -1.0,1
    -1.0,-1
];

fig_1 = figure(1);
set(fig_1,'Position',[300 100 600 400])
clf
hold on
h_p1 = plot(x_fine, y_fine,'b', 'LineWidth', 1);
d_k = 1;
h_p2 = plot(x_fine(d_k), y_fine(d_k),'b', 'LineWidth', 1);
veh_frame_k = veh_frame*8;
for k = 1:length(veh_frame_k)
    veh_frame_x(k) = veh_frame_k(k,1)*cos(heading_angle.Data(d_k)) - veh_frame_k(k,2)*sin(heading_angle.Data(d_k));
    veh_frame_y(k) = veh_frame_k(k,1)*sin(heading_angle.Data(d_k)) + veh_frame_k(k,2)*cos(heading_angle.Data(d_k));
end

h_car = fill(veh_frame_x(1:end-4), veh_frame_y(1:end-4),'m');
R=[cos(steering_angle.Data(d_k)+heading_angle.Data(d_k)) -sin(steering_angle.Data(d_k)+heading_angle.Data(d_k));
    sin(steering_angle.Data(d_k)+heading_angle.Data(d_k)) cos(steering_angle.Data(d_k)+heading_angle.Data(d_k))];
rotated_x_y=R*[-1 1 1 -1;-0.4 -0.4 0.4 0.4];
rotated_x_y=rotated_x_y/2*8;
% 앞 바퀴
front_r_whl = fill((x_fine_real.Data(d_k)+rotated_x_y(1,:)+veh_frame_x(end-3)), (y_fine_real.Data(d_k)+rotated_x_y(2,:)+veh_frame_y(end-3)),'k');
front_l_whl = fill((x_fine_real.Data(d_k)+rotated_x_y(1,:)+veh_frame_x(end-2)), (y_fine_real.Data(d_k)+rotated_x_y(2,:)+veh_frame_y(end-2)),'k');
% 뒤 바퀴
back_r_whl =fill((x_fine_real.Data(d_k)+veh_frame_x(end-1)), (y_fine_real.Data(d_k)+veh_frame_y(end-1)),'k');
back_l_whl = fill((x_fine_real.Data(d_k)+veh_frame_x(end)), (y_fine_real.Data(d_k)+veh_frame_y(end)),'k');


grid on
axis equal
%%

simnum = 2;
filename = sprintf('new_line_u10.gif', simnum);  % 저장할 파일 이름
frnum = 2100;   %total frame number
frgap = 1/30;  % sec/frame
for k = 1:frnum
    % 그림데이터 수정
    d_k = k;
    set(h_p2,'Xdata',x_fine, 'Ydata', y_fine);
    R=[cos(steering_angle.Data(d_k)+heading_angle.Data(d_k)) -sin(steering_angle.Data(d_k)+heading_angle.Data(d_k));
        sin(steering_angle.Data(d_k)+heading_angle.Data(d_k)) cos(steering_angle.Data(d_k)+heading_angle.Data(d_k))];
    rotated_x_y=R*[-1 1 1 -1;-0.4 -0.4 0.4 0.4];
    rotated_x_y=rotated_x_y*1.5;%크기
    R_2=[cos(heading_angle.Data(d_k)) -sin(heading_angle.Data(d_k));sin(heading_angle.Data(d_k)) cos(heading_angle.Data(d_k))];
    rotated_x_y_2=R_2*[-1 1 1 -1;-0.4 -0.4 0.4 0.4];
    rotated_x_y_2=rotated_x_y_2*1.5;%크기
    veh_frame_k = veh_frame*2*1.5;%크기
    for kk = 1:(length(veh_frame_k))
        veh_frame_x(kk) = veh_frame_k(kk,1)*cos(heading_angle.Data(d_k)) - veh_frame_k(kk,2)*sin(heading_angle.Data(d_k));
        veh_frame_y(kk) = veh_frame_k(kk,1)*sin(heading_angle.Data(d_k)) + veh_frame_k(kk,2)*cos(heading_angle.Data(d_k));
    end
    set(h_car,'Xdata',x_fine_real.Data(d_k) + veh_frame_x(1:end-4), 'Ydata',y_fine_real.Data(d_k) + veh_frame_y(1:end-4));
    set(front_r_whl, 'XData', x_fine_real.Data(d_k) + rotated_x_y(1,:) + veh_frame_x(end-3), ...
        'YData', y_fine_real.Data(d_k) + rotated_x_y(2,:) + veh_frame_y(end-3));
    set(front_l_whl, 'XData', x_fine_real.Data(d_k) + rotated_x_y(1,:) + veh_frame_x(end-2), ...
        'YData', y_fine_real.Data(d_k) + rotated_x_y(2,:) + veh_frame_y(end-2));
    set(back_r_whl, 'XData', x_fine_real.Data(d_k) + rotated_x_y_2(1,:)+ veh_frame_x(end-1), ...
        'YData', y_fine_real.Data(d_k) +rotated_x_y_2(2,:)+ veh_frame_y(end-1));
    set(back_l_whl, 'XData', x_fine_real.Data(d_k) + rotated_x_y_2(1,:)+ veh_frame_x(end), ...
        'YData', y_fine_real.Data(d_k) +rotated_x_y_2(2,:)+ veh_frame_y(end));
    
    drawnow 
    frame = getframe(fig_1);   % figure에서의 frame을 가져옴
    img = frame2im(frame);     % 가져온 frame을 image로 변화시킴
    [imind, cm] = rgb2ind(img,256); % index화된 이미지로 변화시킴
    if k == 1
        % n 회 반복 + 1/24초의 딜레이를 가지는 gif 생성. 무한 반복은 inf로 함
        imwrite(imind,cm,filename,'gif','Loopcount',1,'DelayTime',frgap);                
    else
        % 똑같은 파일에 추가를 할 것이므로 append로 함
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',frgap); 
    end
end
