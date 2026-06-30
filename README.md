STREAM DECK ETHERNET TOGGLE

This allows you to toggle the internet connection on your PC, without having to mess about in the control panel. Calling a VBS file avoids a Command window opening, so the whole thing is silent in the background. 

On your PC create the following directory.

        C:\StreamDeck

Download these files into the directory:


`ethernet-hidden.vbs`,
`ethernet.bat`,
`run-toggle-ethernet-task.vbs`


You need to open `ethernet.bat` in notepad and change the adapter name:

        set "ADAPTER=Ethernet"

Change `Ethernet` to match the exact name of the network adapter on the PC.

For example, if the adapter is called Ethernet 2, change it to:

        set "ADAPTER=Ethernet 2"

You can check the adapter name by going to:

        Settings → Network & internet → Advanced network settings

Next, you need to create the Windows task that lets it run properly in the background.

Open Windows PowerShell as Administrator and paste this in:



        $Action = New-ScheduledTaskAction `
                -Execute "C:\Windows\System32\wscript.exe" `
                -Argument "C:\StreamDeck\ethernet-hidden.vbs" `
                -WorkingDirectory "C:\StreamDeck"

        $Principal = New-ScheduledTaskPrincipal `
                -UserId "$env:USERDOMAIN\$env:USERNAME" `
                -LogonType Interactive `
                -RunLevel Highest

        $Settings = New-ScheduledTaskSettingsSet `
                -AllowStartIfOnBatteries `
                -DontStopIfGoingOnBatteries `
                -ExecutionTimeLimit (New-TimeSpan -Minutes 1)

        Register-ScheduledTask `
                -TaskName "Ethernet Toggle" `
                -Action $Action `
                -Principal $Principal `
                -Settings $Settings


Then test it by running this in the same PowerShell window:

        Start-ScheduledTask -TaskName "Ethernet Toggle"

That should toggle the Ethernet connection. You'll just see a subtle change to the Network icon in the Sytem Tray (next to your clock).

After that, open the Stream Deck app and add a new button:

        System → Open

Set it to open this file:

        C:\StreamDeck\run-toggle-ethernet-task.vbs

That's it. 

Pressing the Stream Deck button should now toggle the Ethernet connection on and off without popping up a command window. 

Enjoy.


