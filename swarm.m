classdef swarm
    % Swarm class representing a set of agents
    %
    % Agents can be of any type, recommended to not mix types
    
    properties
        n_agents;
        agent_container;
    end
    
    properties(Constant)
        Threshold = 2;
    end
    
    
    methods
        function ele = swarm(n,agent_type);
            ele.agent_container
            switch agent_type
                case 1 % Make Sheep
                    for i=1:n
                        ele.agent_container(i).agent=sheep(i);
                    end
                case 2 % Make Dogs
                    for i=1:n
                        ele.agent_container(i).agent=dog(i);
                    end
            end
            ele.n_agents = n;
        end
        
        function CoM = getCenterOfMass(swarm);
            CoM = [0 0]';
            for i = 1:swarm.n_agents
                CoM = CoM+swarm.agent_container(i).agent.position;
            end
            CoM = CoM/swarm.n_agents;
        end
        
        function bool = isClumped(swarm);
            CoM = swarm.getCenterOfMass;
            acc = 0;
            for i=1:swarm.n_agents
                acc = acc + norm(swarm.agent_container(i).agent.position-CoM);
            end
            acc = acc/swarm.n_agents;
            if acc < swarm.Threshold
                bool = 1;
            else
                bool =0;
            end
        end
        
    end
end
                