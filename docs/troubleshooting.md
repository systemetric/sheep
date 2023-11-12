---
title: Troubleshooting
category: Tools
position: 5
---
# Troubleshooting

Here are a few *common* issues you might have and some solutions to them. Student Robotics has a [similar section](https://studentrobotics.org/docs/troubleshooting/) on their website which is also relevant.

## I've connected a battery and the power switch to the black connector but never get any lights on The BrainBox.

Unless the battery is really very low the front led will blink very briefly when the switch is first pressed. If this happens you need to charge the battery. The BrainBox will not switch on at all when the voltage of the battery is very low. If the battery is freshly charged, it's possible that the switch has failed or become internally disconnected. For testing purposes, you can swap the power switch for a single piece of wire. NOTE: at the competition, you must have a red power switch to control your robot as per the rules. Finally - in exceptional circumstances the fuse in the cable may have failed, if this has happened then there must have been some terminal problem internal to the BrainBox - Contact us on robotics@hillsroad.ac.uk for instructions.

## The BrainBox appears to power up, but I can't connect to the website and the blue LED lights up but never starts flashing.

This can happen if erroneous code which does not start with `R = robot.Robot()` is uploaded to The BrainBox. If you think this may have happened, download [this file](/main.py) and place it on a USB stick. Put the USB stick into The BrainBox and turn the robot on normally. Wait 5 minutes, if you do not at this point get the flashing blue light, contact us through the [contact us](mailto:robotics@hrsfc.ac.uk).

:::warning
Using this file will overwrite the current robot code. It will not touch any files you have stored in the editor.
:::

## I've connected a battery and the power switch to the black connector but never get any lights on the Brainbox
If the battery is fresh, it's possible that the switch has failed or become internally disconnected. For testing purposes, you can swap the power switch for a single piece of wire. NOTE: at the competition, you must have a red power switch to control your robot as per the rules. Finally - in exceptional circumstances the fuse in the cable may have failed, if this has happened then there must have been some terminal problem internal to the BrainBox - Contact us on <mailto:robotics@hillsroad.ac.uk> for instructions. 

## The BrainBox appears to power up, the blue LED light flashes but I cannot connect to it using the WiFi.

We apologise for the poor choice of font, zeroes and capital-o's can be confused as can capital-i's and number ones. Try swapping these.

## The BrainBox appears to power up, I can connect to it with WiFi, but am unable to reach the web interface.

Some modern browsers default to a web search if they do not understand the web address. Try putting `http://` in front of the address, e.g. `http://robot.local`  instead of `robot.local`.

## I've connected to the web interface and can run code, but my motors never turn on.

The BrainBox will automatically cut power to the 12V socket and the motor outputs if it every detects a current surge exceeding 20A. When this happens, the LED viewable next to where the battery lead enters the BrainBox will appear red rather than primarily green. If the LED is not green, first disconnect the motors and power cycle The BrainBox to see if this resolves the problem. If it does, then your motors are probably too large.

It is possible to enable/disable this power output from software. When the output is disabled, there will be no light at all visible through this hole. If you can see no light through the hole when the robot is running code check that you have not disabled the motor output by uploading a [simple file](/simple.py).

## I'm trying to read an analog value from GPIOs, but I'm getting strange values.

Check  you're actually reading the pin you're trying to read. `R.gpio[0]` is Pin 0, `R.gpio[3]` is Pin 3, etc. If everything's connected correctly, try setting the other pins to output and writing `False` to them.

## R.see() doesn't seem to work.

When you call R.see() the camera preview in the top right should show you what the camera can see. If this image is consistently blurred, incorrect looking, or not loading, try placing some markers in front of the camera and try:
```py
print(R.see())
```
If this prints out the markers you placed in front of the robot, the issue is most likely just with the camera preview itself. Contact us, but this shouldn't prevent your robot from running the code. 
However, if the robot cannot find markers, the camera itself is having problems. Contact us about changing the focus of the camera. Note that the robot being in motion may add blur to the images taken.

:::tip
Calling `R.see()` at a high rate (with a sleep of less than 2 seconds between each call, or no sleep at all) may result in issues with the camera preview such as frames being dropped or blurred. Try slowing down your loop to see if this helps with the issue.
:::


## Can you post a kit to or from Hills Road

We can post kits from Hills Road however you will need to cover the costs of shipping

## What is the patch and how do I install it?

The patch is an update which improve your BrainBox, by adding more docs, more blocks to blocky, faster boot times and more! To patch your robot please follow the instructions [here](/docs/patching-the-robot.md).

## Why is the time wrong

The Raspberry Pi does not keep time when it is off and so has no way of knowing how much time has passed since it was turned off.

