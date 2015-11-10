% Sheepdog Simulator 4M20 Robotics

% Initialise
NSheep = input('How many sheep de ye wante ladde?\n');

% define agents
herd = sheep.empty(NSheep,0);
pack = dog.empty(1,0);
for i=1:NSheep
    herd(i)=sheep(i);
end
pack(1) = dog(1);

% Index and timestep
t=1;
dt=0.1;

% Defnition of field and target area. No semicolons so 
field = [-50 -50 100 100]
pen = [20 20 15 15]


minXField = field(1,1);
minYField = field(1,2);
maxXField = field(1,1)+field(1,3);
maxYField = field(1,2)+field(1,4);

%Figure
fig=figure('Name','Simulator');
    hold on
    % Hide and set axis
    axis([-50,50,-50,50])
    set(findobj(gcf, 'type','axes'), 'Visible','off')
    % Background colour
    set(gcf, 'Color', [0.4,1,0.4]);
    
    % Plot
    while(1)
        for i=1:NSheep
              herd(i).shepherd(pack,herd,dt);
        end
        pack(1).shepherd(herd,dt)
        rectangle('Position',[field],'FaceColor',[0.4,1,0.4],'EdgeColor',[0.8,0.8,0.1],'LineWidth',5)
        rectangle('Position',[pen],'FaceColor',[0.6,1,0.6],'EdgeColor',[0.5,0.5,0.5],'LineWidth',1)
        for i=1:NSheep
            plot(herd(i).position(1),herd(i).position(2),herd(i).get.state, 'MarkerSize',25)
        end
        plot(pack(1).position(1),pack(1).position(2),'.k', 'MarkerSize',10)
        pause(0.0005);
        t=t+1;

        if ~ishghandle(fig) %Kill loop when closing figure
            break
        end
    end