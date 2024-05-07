*Ubuntu 22.04 LTS is an operating system that does not support video call sharing by default.*

*The operating system runs a display system by default called Wayland, which does not support screen-sharing on zoom calls. Xorg is another display system that does support it, however Linux pushes Wayland as it's default system. Disabling Wayland and enabling Xorg (X11) is a solution to get screensharing working.*

*The aim of the wayland_x11_switch script is to remove the friction of switching between the two.*

**The Problem**

As a user of Ubuntu 22.04 LTS, I struggle with screensharing with both Microsoft Teams and with Zoom.

This is down to Ubuntu 22.04 using Wayland as a default display feature - which (at the time of writing this) does not support screensharing.

Xorg (or x11) does support screensharing.

**Current Solutions**

Disabling Wayland from the command line and enabling XOrg is explained by this [really useful Stack Overflow thread](https://askubuntu.com/questions/1407494/screen-share-not-working-in-ubuntu-22-04-in-all-platforms-zoom-teams-google-m) and it goes something like this:

Check which display system is currently being used by entering the following command in the terminal.

`echo $XDG_SESSION_TYPE`

If the result of you running this command is Wayland, then that is the system you are using.

One way to be able to use screensharing, is to disable Wayland and enable xorg (or x11). To carry this out navigate to file which dictates this by entering the following command in the terminal

`sudo nano /etc/gdm3/custom.conf`

Uncomment the following line.

`WaylandEnable=false`

Now after restarting your computer, re-entering the folling command will show which display system is now being used.

`echo $XDG_SESSION_TYPE`

If x11 is still not being shown, you can run the following command.

`sudo systemctl restart gdm`

This solution is great is great for switching display systems on a rare occasion - however for me, one of the projects I run, relies on a docker environment that is dependent on Wayland.

Therefore I want a solution that allows switching to be more rapid.

**My Solution**

I wanted a solution that automates the process of uncommenting and commenting lines in a file to switch between display systems.

I wrote a script that carries out the following in the command line.

1. Checks which display system is being used.
2. Tells you which one is being used.
3. Asks if you want to switch to the other.
4. If you respond with "Y" switches accordingly.
5. Tells you on completion of switching, and asks if you want to restart your computer now.
6. If you respond with "Y" it restarts your computer.

To execute the script, navigate to the directory wayland_x11_switch. You can do this by executing the following command in the terminal.

`cd ~/wayland_x11_switch`

Then run the command in sudo. In order for this script to run correctly, you may have to run it while preserving the user environment by sending "-E" after sudo, as outline below.

`sudo -E ./wayland_x11_switch.sh`

If you want to try it without preserving the environment first, then send the following command instead.

`sudo ./wayland_x11_switch.sh`

If your display system is Wayland, the program will return the following message.

`Switch to Xorg (X11)? This will disable Wayland. (y/n):`

If you respond with "y", the program will return with the following message.

``Switched to Xorg. Please reboot your system for the change to take effect.
Would you like to reboot now? (y/n):``

If you respond with "y" the system will restart.

Conclusion and Further Work

In conclusion, the program succeeds in switching between Wayland and x11 effectively.

For future, being able to switch between them without having to preserve the user environment (running with -E) or without having to restart the computer to take effect, will be good improvements to make.
