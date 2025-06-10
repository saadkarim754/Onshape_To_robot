local sim = require('sim')

function sysCall_init()
    -- Get joint handles
    r1 = sim.getObject('/r1')
    r2 = sim.getObject('/r2')
    r3 = sim.getObject('/r3')
    r4 = sim.getObject('/r4')
    r5 = sim.getObject('/r5')
    r6 = sim.getObject('/r6')

    -- Store joints in array for easy access
    joints = {r1, r2, r3, r4, r5, r6}

    -- Set target positions for each joint
    targetPositions = {0.5, -0.5, 0.4, -0.4, 0.3, -0.3}  -- in radians

    -- Control variables
    currentJoint = 1
    lastSwitchTime = sim.getSimulationTime()
    waitTime = 2.0  -- seconds delay between joint switches

    sim.addLog(sim.verbosity_scriptinfos, "Initialization complete. Starting joint movement sequence...")
end

function sysCall_actuation()
    local currentTime = sim.getSimulationTime()

    -- Reset all joints except the current one
    for i = 1, #joints do
        if i ~= currentJoint then
            sim.setJointTargetPosition(joints[i], 0)
            sim.addLog(sim.verbosity_scriptinfos, string.format("Joint r%d reset to 0", i))
        end
    end

    -- Move the current joint to its target position
    sim.setJointTargetPosition(joints[currentJoint], targetPositions[currentJoint])
    sim.addLog(sim.verbosity_scriptinfos, string.format("Moving Joint r%d to %.2f radians", currentJoint, targetPositions[currentJoint]))

    -- Check if it's time to move to the next joint
    if currentTime - lastSwitchTime > waitTime then
        sim.addLog(sim.verbosity_scriptinfos, string.format("Switching from Joint r%d to next joint", currentJoint))
        
        currentJoint = currentJoint + 1
        if currentJoint > #joints then
            currentJoint = 1
            sim.addLog(sim.verbosity_scriptinfos, "Restarting sequence from Joint r1")
        end

        lastSwitchTime = currentTime
    end
end
