% Modified DH
% Ske robot
clear;
clc;

th(1) = 0; d(1) = 0;       a(1) = 0;     alp(1) = 0;
th(2) = 0; d(2) = -188.76; a(2) = 0;     alp(2) = -pi/2;   
th(3) = 0; d(3) = -81.24;  a(3) = 0;     alp(3) = pi/2;
th(4) = 0; d(4) = 0;       a(4) = 0;     alp(4) = 4/9*pi;
th(5) = 0; d(5) = 113.03;  a(5) = 267.5; alp(5) = 0;
th(6) = 0; d(6) = 111.50;  a(6) = 0;     alp(6) = pi/2;
th(7) = 0; d(7) = 388.96;  a(7) = 0;     alp(7) = 0;
% DH parameters  th     d    a    alpha  sigma
L1 = Link([th(1), d(1), a(1), alp(1), 1], 'modified');L1.offset = 95.35;L1.qlim=[0, 150]; 
L2 = Link([th(2), d(2), a(2), alp(2), 0], 'modified');
L3 = Link([th(3), d(3), a(3), alp(3), 0], 'modified');
L4 = Link([th(4), d(4), a(4), alp(4), 0], 'modified');L4.offset = -pi/2;
L5 = Link([th(5), d(5), a(5), alp(5), 0], 'modified');L5.offset = pi/2;
L6 = Link([th(6), d(6), a(6), alp(6), 0], 'modified');
L7 = Link([th(7), d(7), a(7), alp(7), 0], 'modified');
robot = SerialLink([L1, L2, L3, L4, L5, L6, L7]); 
robot.name='SkeRobot-6-dof';
robot.display() %把建立机器人模型的一些相关信息展示出来
view(3);
% Forward Pose Kinematics
theta_d = [0, 0, -pi/2, pi/2, 0, 0, 0];
robot.teach();%画出机器人模型，并在图窗左侧出现一些可控元件
robot.plot(theta_d); 
t0 = robot.fkine(theta_d)    %末端执行器位姿
