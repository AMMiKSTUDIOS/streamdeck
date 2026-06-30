Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "schtasks /run /tn ""Ethernet Toggle""", 0, False