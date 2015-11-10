% Sheepdog Simulator 4M20 Robotics

% Initialise
NSheep = input('How many sheep de ye wante ladde?\n');

% define agents
herd = swarm(NSheep,1);
pack = swarm(1,2);

% Index and timestep
t=1;
dt=0.1;

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
              herd.agent_container(i).agent.shepherd(pack,herd,dt);
        end
        pack.agent_container(1).agent.shepherd(herd,dt)
        rectangle('Position',[-50,-50,100,100],'FaceColor',[0.4,1,0.4],'EdgeColor',[0.8,0.8,0.1],'LineWidth',5)
        rectangle('Position',[20,20,15,15],'FaceColor',[0.6,1,0.6],'EdgeColor',[0.5,0.5,0.5],'LineWidth',1)
        for i=1:NSheep
            plot(herd.agent_container(i).agent.position(1),herd.agent_container(i).agent.position(2),herd.agent_container(i).agent.state, 'MarkerSize',25)
        end
        plot(pack.agent_container(1).agent.position(1),pack.agent_container(1).agent.position(2),'.k', 'MarkerSize',10)
        pause(0.001);
        t=t+1;

        if ~ishghandle(fig) %Kill loop when closing figure
            break
        end
    end