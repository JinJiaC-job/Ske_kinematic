clear;close all;clc;
%% link([theta d a alpha])
%  theta 连杆关节角度
%  d 连杆偏距
%  a 连杆长度
%  alpha 连杆扭转角
% fv = stlread('data_arm_assembly_Adams_simu.stl');
[F,V] = stlread('data_arm_assembly_Adams_simu.stl');
% 指定机械臂的连接方式和关节参数
L(1) = Link('a', 0, 'alpha', 0, 'theta',0,'prismatic');
L(2) = Link('d', -188.76, 'a', 0, 'alpha', -pi/2);
L(3) = Link('d', -81.24,  'a', 0, 'alpha', pi/2);
L(4) = Link('d', 0,       'a', 0,   'alpha', 4/9*pi);
L(5) = Link('d', 113.03,  'a', 267.5, 'alpha', 0);
L(6) = Link('d', 111.50,  'a', 0,   'alpha', pi/2);
L(7) = Link('d', 388.96,  'a', 0,   'alpha', 0);

skeletonArm = SerialLink(L,'name','skeletonArm');
W = [-700 700 -800 800 -800 800];
%需要修改输入角度范围2023/05/11
for i = 0:0.1:1000   %随机生成
    d1 = 150*rand()+95.35;
    theta2 = 2*pi/3*rand()-pi/2;%-90du~30du
    theta3 = 2*pi/3*rand()-pi/6;%-30du~90du
    theta4 = -pi/2*rand();%0du~90du,-90du初始位置
    theta5 = pi/2*rand()+pi/2;%0du~90du
    theta6 = pi*rand()-pi/2;%-90du~90du
    theta7 = 0;

    %运动学正解
    T = skeletonArm.fkine([d1 theta2 theta3 theta4 theta5 theta6 theta7]);
    %取其末端点坐标
    qn = T.t;
    %画出机器人当前姿态
    %skeletonArm.plot([theta1 theta2 theta3 theta4 theta5 theta6 theta7 theta8 theta9],'workspace',W);
    %画出机器人当前末端点位置
    plot3(qn(1),qn(2),qn(3),'.','color',[1 0 0]);
    hold on
end

hold on
% 将模型沿x轴平移10个单位
V(:,1) = V(:,1) - 200;
% 将模型沿y轴平移20个单位
V(:,2) = V(:,2) - 600;
% % 将模型沿z轴平移30个单位
V(:,3) = V(:,3) - 230;

patch('Faces',F,'Vertices',V,'FaceColor',       [1.0 1.0 1.0], ...
         'EdgeColor',       'none',        ...
         'FaceLighting',    'gouraud',     ...
         'AmbientStrength', 0.15);

% Add a camera light, and tone down the specular highlighting
camlight('headlight');
material('dull');

axis equal;

xlabel('X');
ylabel('Y');
zlabel('Z');
title('Model and Point Cloud');

% hold on;
% patch('Faces', f, 'Vertices', v, 'FaceColor', 'blue');%, 'EdgeColor', 'none', 'FaceAlpha', 2
% %patch('Faces', faces, 'Vertices', vertices, 'FaceVertexCData', colors, 'FaceColor', 'flat', 'EdgeColor', 'none')
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Model and Point Cloud');
% hold off;
