# Linux Automation Mini Project --- Welcome Chetan Popup

## Project Overview

A simple Linux automation project built in **WSL2** that displays a
Windows popup saying **"Welcome Chetan!"** when the Linux environment
starts.

This project demonstrates:

-   Bash scripting
-   Executing Windows commands from WSL
-   Basic Linux automation
-   Creating and using a `systemd` service
-   Using `systemctl` to manage a service


------------------------------------------------------------------------

## Environment

-   OS: Ubuntu on WSL2
-   Architecture: x86_64
-   Shell: Bash
-   Automation tool: systemd
-   Windows integration: PowerShell

------------------------------------------------------------------------

## Project Structure

``` text
~/AUTOMATIONS/
└── welcome.sh
```

The systemd service is stored separately:

``` text
/etc/systemd/system/welcome.service
```

------------------------------------------------------------------------

## Step 1 --- Create the Script

The script was created at:

``` bash
~/AUTOMATIONS/welcome.sh
```

The script uses PowerShell from Windows to display a popup.

``` bash
#!/bin/bash

/mnt/c/windows/System32/WindowsPowerShell/v1.0//powershell.exe -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('Welcome Chetan!','Linux Automation')"
```

The script was made executable with:

``` bash
chmod +x ~/AUTOMATIONS/welcome.sh
```

------------------------------------------------------------------------

## Step 2 --- Test the Script

The script can be executed manually with:

``` bash
./welcome.sh
```

This successfully displayed:

``` text
Welcome Chetan!
```

------------------------------------------------------------------------

## Step 3 --- Why `notify-send` Was Not Used

Initially, `notify-send` was tested:

``` bash
notify-send "Welcome Chetan!" "Your Linux system is ready"
```

It failed with:

``` text
org.freedesktop.DBus.Error.ServiceUnknown:
The name org.freedesktop.Notifications was not provided
```

The reason was that WSL2 does not provide a normal Linux desktop
notification service in this environment.

Instead, PowerShell was used to display a Windows popup.

------------------------------------------------------------------------

## Step 4 --- Find PowerShell

The location of PowerShell was checked with:

``` bash
which powershell.exe
```

Output:

``` text
/mnt/c/windows/System32/WindowsPowerShell/v1.0//powershell.exe
```

The absolute path was used in `welcome.sh` so that the script could also
be executed correctly by systemd.

------------------------------------------------------------------------

## Step 5 --- Create the systemd Service

A service file was created at:

``` bash
/etc/systemd/system/welcome.service
```

Configuration:

``` ini
[Unit]
Description=Welcome Chetan Automation
After=network.target

[Service]
Type=oneshot
User=chetan
ExecStart=/home/chetan/AUTOMATIONS/welcome.sh

[Install]
WantedBy=multi-user.target
```

### Important parts

``` ini
ExecStart=/home/chetan/AUTOMATIONS/welcome.sh
```

Tells systemd which script to execute.

``` ini
Type=oneshot
```

Means the script runs once and then the service finishes.

``` ini
User=chetan
```

Runs the script as the `chetan` user.

------------------------------------------------------------------------

## Step 6 --- Reload systemd

After creating the service file:

``` bash
sudo systemctl daemon-reload
```

This makes systemd read the newly created service configuration.

------------------------------------------------------------------------

## Step 7 --- Enable the Service

The service was enabled with:

``` bash
sudo systemctl enable welcome.service
```

This configures the service to start automatically when the appropriate
systemd boot target is reached.

------------------------------------------------------------------------

## Step 8 --- Test the Service

The service was manually started with:

``` bash
sudo systemctl start welcome.service
```

Its status was checked with:

``` bash
systemctl status welcome.service
```

The successful result included:

``` text
status=0/SUCCESS
```

The service showed:

``` text
Active: inactive (dead)
```

This is expected because the service uses:

``` ini
Type=oneshot
```

The script executes once, finishes successfully, and the service exits.

------------------------------------------------------------------------

## Final Architecture

``` text
                    WSL2
                     |
                     v
                  systemd
                     |
                     v
             welcome.service
                     |
                     | ExecStart
                     v
          ~/AUTOMATIONS/welcome.sh
                     |
                     v
              powershell.exe
                     |
                     v
             Windows Popup
                     |
                     v
             "Welcome Chetan!"
```

------------------------------------------------------------------------

## Useful Commands

### Run the script manually

``` bash
~/AUTOMATIONS/welcome.sh
```

### Make the script executable

``` bash
chmod +x ~/AUTOMATIONS/welcome.sh
```

### Reload systemd configuration

``` bash
sudo systemctl daemon-reload
```

### Start the service now

``` bash
sudo systemctl start welcome.service
```

### Enable automatic startup

``` bash
sudo systemctl enable welcome.service
```

### Check service status

``` bash
systemctl status welcome.service
```

### Reset a failed service

``` bash
sudo systemctl reset-failed welcome.service
```

------------------------------------------------------------------------

## What I Learned

1.  A Bash script can automate a task.
2.  WSL allows Linux commands to interact with Windows.
3.  `powershell.exe` can be executed from WSL.
4.  A `systemd` service can be created to run a script.
5.  `systemctl start` runs a service immediately.
6.  `systemctl enable` configures a service for automatic startup.
7.  `Type=oneshot` is useful for tasks that should execute once and
    finish.
8.  `systemctl status` can be used to troubleshoot services.

------------------------------------------------------------------------

## Future Improvements

Possible upgrades for this project:

-   Add a timestamp to a log file.
-   Display CPU and memory information.
-   Display disk usage.
-   Record each execution in a log.
-   Create a system health-check script.
-   Send an alert when disk usage exceeds a threshold.

------------------------------------------------------------------------

## Project Status

**Completed:** Basic Linux automation with a startup welcome popup.

**Next learning topic:** Understand `systemd` and `systemctl` in depth.
