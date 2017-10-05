hFig = figure(1);
hold on
set(hFig, 'Position', [500 50 800 800])
[x,y,z]=sphere;
s = hgtransform;
mesh(0.15*x,0.15*y,0.15*z,'FaceColor',[0.2 0.6 1],'EdgeColor',[0.2 0.6 1],'Parent',s);
x = [-0.6,0.6,0.6,-0.6;-0.05,0.05,0.05,-0.05];
y = [-0.05,-0.05,0.05,0.05;-0.6,-0.6,0.6,0.6];
z = [0 0 0 0;0 0 0 0];
patch('XData',x','YData',y','ZData',z','FaceColor',[0.2 0.6 1],'EdgeColor',[0.2 0.6 1],'Parent',s);
th = 0:pi/50:2*pi;
x = [0.1*cos(th)+0.6;0.1*cos(th)-0.6;0.1*cos(th);0.1*cos(th)];
y = [0.1*sin(th)+0;0.1*sin(th)+0;0.1*sin(th)-0.6;0.1*sin(th)+0.6];
z = [0*x;0*x;0*x;0*x];
patch('XData',x','YData',y','ZData',z','FaceColor','None','LineWidth',3,'LineStyle','-','Parent',s);
a1 = animatedline('Color','red');
scatter3([5 0 2],[2 5 -1],[2 4 6],'red*')
axis equal
grid on
box on
view(-201,28)
xlim([-1 6])
ylim([-2 6])
zlim([-1 7])
legend('traveled path','target points','location','north')
for j=1:10:length(res.x.data)
  s.Matrix = makehgtform('translate',[res.x.data(j),res.y.data(j),res.z.data(j)])*...
  makehgtform('xrotate',res.theta.data(j))*...
  makehgtform('yrotate',res.phi.data(j))*...
  makehgtform('xrotate',res.psi.data(j));
  addpoints(a1,res.x.data(j),res.y.data(j),res.z.data(j));
  drawnow
end
