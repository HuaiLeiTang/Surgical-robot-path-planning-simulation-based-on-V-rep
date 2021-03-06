function [ output_args ] = vrep_setQ( q,clientID, opmod )
%VREP_SETQ Summary of this function goes here
%   Detailed explanation goes here
if iscolumn(q)
      q = q';
 end
global prismaticJointS22 prismaticJointS21 prismaticJointS11 
global prismaticJointS12 prismaticJointS00 prismaticJointS01
global revoluteJointS21 revoluteJointS22 revoluteJointS11
global vrep

if (clientID>-1)
   
    if opmod~= vrep.simx_opmode_blocking
    [returnCode]=vrep.simxPauseCommunication(clientID,1); 
    if returnCode ~= vrep.simx_return_ok 
          vrep_checkReturnCode( returnCode, 'simxPauseCommunication');
    end
    end
    
    
%q6
Vrep_setJointTargetPos(clientID,prismaticJointS00,-q(1,6), opmod);


%q5
Vrep_setJointTargetPos(clientID,prismaticJointS01,q(1,5), opmod);

%q4 rotational joint
%Vrep_setJointTargetPos(clientID,revoluteJointS11,q(1,4), opmod);
Vrep_setJointTargetPos(clientID,prismaticJointS12,-getL2(q(1,3),q(1,4)),opmod);

%q3
%l1
Vrep_setJointTargetPos(clientID,prismaticJointS11,q(1,3), opmod);
Vrep_setJointTargetPos(clientID,prismaticJointS12,-q(1,3), opmod);

%q2 rotational joint
%Vrep_setJointTargetPos(clientID,revoluteJointS21,q(1,2),opmod);
Vrep_setJointTargetPos(clientID,prismaticJointS22,getL2(q(1,1),q(1,2)),opmod);

% q1
% l1
Vrep_setJointTargetPos(clientID,prismaticJointS21,-q(1,1),opmod);
Vrep_setJointTargetPos(clientID,prismaticJointS22,q(1,1),opmod);

if opmod~= vrep.simx_opmode_blocking
[returnCode]=vrep.simxPauseCommunication(clientID,0); 
if returnCode ~= vrep.simx_return_ok 
      vrep_checkReturnCode( returnCode, 'simxPauseCommunication');
end
end

else
    disp('no valid ClientID provided');
end
end

