# Create unload.txt with <ENTER> content
Set-Content -Path "C:\unload.txt" -Value "<ENTER>"

# Run the Trend Micro command with the password
& "C:\Program Files (x86)\Trend Micro\Security Agent\PccNTMon.exe" -n 

# Wait for 10 seconds
Start-Sleep -Seconds 10

# Simulate pressing the Enter key
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

# Wait for 10 seconds
Start-Sleep -Seconds 10


# Loop to check if the ntrtscan service is stopped
while ($true) {
    $serviceStatus = (Get-Service -Name ntrtscan).Status
    if ($serviceStatus -eq 'Stopped') {
        Write-Host "ntrtscan stopped"
        break
    } else {
        Write-Host "ntrtscan service still running"
        Start-Sleep -Seconds 10
    }
}

# Wait for 10 seconds
Start-Sleep -Seconds 10

# Change directory and start PccNTMon.exe
Set-Location "C:\Program Files (x86)\Trend Micro\Security Agent\"
Start-Process "PccNTMon.exe"
