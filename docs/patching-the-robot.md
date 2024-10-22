---
title: Patching the Robot
category: Tools
position: 6
---
# Patching the Robot

An important part of looking after your robot is making sure its software is up to date. Over time **RoboCon** may release patches that allow you to update your robot. Follow the steps below to bring your robot up to date.

## Steps to Patch

1. Download the patch from the email we sent, or our [blog](https://robocon.uk/blog), onto the computer you will be connecting your BrainBox to. 
2. [Turn on](/turning-everything-on.md) and [connect](/connecting.md) to your robot. 
3. Navigate to the editor by visiting <http://robot.local/> and clicking the orange button 
4. Click the upload button (indicated below). 

   ![](/images/upload-button.png)
5. Navigate to where you have saved the patch and click OK. 
6. Select the patch file in the left-hand panel. The patch will show on the code view as Base64 encoded data (random-looking text characters). 
7. Click the "Run" button (green arrow on the right-hand panel). 

   ![](/images/run-button.jpg)
8. After a few moments, your BrainBox should reboot, and the LED will either turn off or remain on. You will lose connection with it while it does this. **Do not turn off your BrainBox** - the LED may stay off for a couple minutes.
9. The BrainBox LED will eventually start flashing again to show it has rebooted successfully. 
10. If your PC has not automatically connected, connect to it using the WiFi. Once reconnected, refresh your browser and open a project from the left-hand side of the editor. Check that the patch version is correct in the right-hand panel.  
11. If you have any issues, please [contact us](mailto:robotics@hrsfc.ac.uk). 

:::tip
Your robot will restart as part of the patching process, so you will lose connectivity with it for about half a minute. Your laptop should automatically reconnect to the robot when it turns back on. If you cannot connect to your robot, please [contact us](mailto:robotics@hrsfc.ac.uk).
:::

### This patch's passphrase is:
Why are dragons good at music?
They know lots of scales