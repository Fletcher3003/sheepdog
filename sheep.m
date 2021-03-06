classdef sheep < agent
    %   sheep - Class representing the 'sheep' or 'prey'
    
    properties
        type = 1;
        
        % Set weightings for target priorities
        dog_priority = -15;
        sheep_priority = 5;
        wall_priority = 100;
        safeDist = 40;
        state = '.w';
    end 
    
    methods
        function ele = sheep(id)
            % Calls the agent constructor          
            ele@agent(id);
            ele.type = 0;
            % Assign sheep fitness, including randomness
            stochast = normrnd(0.5,0.25);
            ele.fitness = stochast;
            % Position sheep, including randomness
            ele.position = [-50;-50] + 100*rand(2,1);
        end
        
        function shepherd(object,pack,herd,timestep)
            bearing = [0 0]';
            
            % Get vectors to herd of agents // CURRENTLY NO OTHER DOGS
            dogLocs = zeros(2,length(pack.agent_container(i)));
            dogDist = zeros(length(pack));
            dogVec = zeros(2,1);
            sheepLoc = zeros(2,1);
            
            for i = 1:length(pack)
                dogLocs(:,i) = object.getVector(pack(i));
                dogDist(i)=norm(object.getVector(pack(i)));
                dogVec = dogVec + dogLocs(:,i)/norm(dogLocs(:,i))^3; % r^2 weighting
%                 bearing = bearing + object.get.dog_priority*dogLoc/(norm(dogLoc)^2); %not sure what you're doing
            end
            for i = 1:length(herd)
                sheepLoc = sheepLoc + object.getVector(herd(i))/length(herd);
%                 bearing = bearing + object.get.dog_priority*dogLoc/(norm(dogLoc)^2); %not sure what you're doing
            end
            if (min(dogDist) > object.safeDist) % safe so random walk
                object.state = '.w';
                bearing = [-0.5;-0.5]+rand(1,2)';
                bearing = bearing/norm(bearing); 
            else
                object.state = '.r';
                bearing = bearing + object.get.dog_priority*dogVec + object.get.sheep_priority*sheepLoc;
            end
        
            
            
            % Get wall properties
            % Currently square box
            locus = object.get.position;
            
            % Check x direction
            if locus(1) < -40
                bearing = bearing + object.get.wall_priority*[1 0]';
            elseif locus(1) > 40
                bearing = bearing + object.get.wall_priority*[-1 0]';
            end
            
            % Check y direction
            if locus(2) < -40
                bearing = bearing + object.get.wall_priority*[0 1]';
            elseif locus(2) > 40
                bearing = bearing + object.get.wall_priority*[0 -1]';
            end
            
            % Normalise bearing
            bearing = bearing/norm(bearing);
            
            % Update heading
            object.heading = (object.heading + bearing)/2;
            
            % Step forward
            object.move(timestep);
        end
    end
end

