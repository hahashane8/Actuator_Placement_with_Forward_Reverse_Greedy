# Actuator_Placement_with_Forward_Reverse_Greedy

With the m file included in this repository, one can test both forward and reverse greedy algorithms on a the IEEE 118-bus system. The aim is to find an actuator set that minimizes the average control costs while guaranteeing the resulting network is structurally controllable.
A description for the algorithm can be found at https://arxiv.org/abs/1912.05149.

We utilize and revise the octave network toolbox at https://aeolianine.github.io/octave-networks-toolbox/. The revision is to make the files compatible with Matlab.

Instructions to run the code:
1. Run /Forward_greedy/forward_greedy_on_118_bus.m to implement forward greedy algorithm.
2. Run /Reverse_greedy/Reverse_Greedy_on_118_bus.m to implement reverse greedy algorithm.
3. Run /Forward_greedy/randomSampling.m to calculate the energy costs given by actuator set randomly generated.
