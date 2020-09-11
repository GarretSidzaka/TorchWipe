$Logfile = ".\TorchWatchdog.log"

Function LogWrite
{
   Param ([string]$logstring)
   $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
   $logline = "$Stamp $logstring"
   Add-content $Logfile -value $logline
}



function Get-Funky{
    param([string]$Text)

    # Use a random colour for each character
    $Text.ToCharArray() | ForEach-Object{
        switch -Regex ($_){
            # Ignore new line characters
            "`r"{
                break
            }
            # Start a new line
            "`n"{
                Write-Host " ";break
            }
            # Use random colours for displaying this non-space character
            "[^ ]"{
                # Splat the colours to write-host
                $writeHostOptions = @{
                    ForegroundColor = ([system.enum]::GetValues([system.consolecolor])) | get-random
                    # BackgroundColor = ([system.enum]::GetValues([system.consolecolor])) | get-random
                    NoNewLine = $true
                }
                Write-Host $_ @writeHostOptions
                break
            }
            " "{Write-Host " " -NoNewline}

        } 
    }
}

$text = @"
  _____              _  __        ___            
 |_   _|__  _ __ ___| |_\ \      / (_)_ __   ___        _
   | |/ _ \| '__/ __| '_ \ \ /\ / /| | '_ \ / _ \      [_]|
   | | (_) | | | (__| | | \ V  V / | | |_) |  __/      | ||
   |_|\___/|_|  \___|_| |_|\_/\_/  |_| .__/ \___|      |_ `````)
                                     |_|                _) __(_
"@  
Get-Funky $text
Write-host " "
Write-Host "Author: GarretSidzaka https://expanse.2enp.com"
Write-Host " "
start-sleep -s 2
$executableFilePath = $PSScriptRoot + "\Torch.Server.exe"
$mapStorageFilePath =  $PSScriptRoot + "\Instance\Saves"
$currentLiveMapFilePath = $PSScriptRoot + "\map.zip"


while($true){
    Write-Host "Starting at top of loop"

        Write-Host "Beginning 30 second delay before checking again."
        Write-Host " "
        for ($a=0; $a -le 30; $a++) {
            Write-Host -NoNewLine "`r0$a"
            Start-Sleep -Seconds 1
        }

	     $executableFilePath.kill()
        
		
		for ($a=0; $a -le 30; $a++) {
            Write-Host -NoNewLine "`r0$a"
            Start-Sleep -Seconds 1
        }
		
		
		
		
		
		
		
		
		
	     start-process $executableFilePath

}

Read-Host -Prompt "Press Enter to exit"
