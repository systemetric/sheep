---
title: Servos
category: Programming
position: 4
---
# Servos

Servos are a bit like motors, except their position is fixed. This is useful for building an arm mechanism that grabs cubes, or anything else that has fixed states that it needs to be in.

Similarly to motors, the position of a servo is expressed as a percentage. This can be negative.

Servos are plugged into the **Servo** ports on the BrainBox. The numbers present on each port correspond to the index used in your code.

## Python

You can control servos using the `servos` property of the `Robot` object. To set the first servo to the 50% position use:

```python
R.servos[0] = 50
```

To control the fourth servo instead, replace `servos[0]` with `servos[3]`. Again, remember that indexes start at 0.

Here's a more complete example:

```python
import robot

R = robot.Robot()

# set servo 0 to the 50% position
R.servos[0] = 50

# set servo 2 to the -100% position
R.servos[2] = -100

# set servos 0 & 2 to the default positions
R.servos[0] = 0
R.servos[2] = 0
```

## Blockly

Blocks for controlling servos can be found in the **Movement** section.

# Default positions

Servos default to a starting position 1/2 way through their travel, for some uses teams may need to start with a different resting position to ensure their robot fits within the set sizes, you can set the position that the servo holds while waiting for the start button to be pressed by initilizing the robot object with `servo_defaults=((servo_number,position)...,(servo_number,position))`

E.g. to set servo 0 to `100%` and servo 2 to `50%` use
```python
import robot

servo_values = {
    0: 100,
    2: 50
}

R = robot.Robot(servo_defaults=servo_values)
```

