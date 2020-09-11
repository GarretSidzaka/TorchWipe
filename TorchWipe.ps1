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
   | | (_) | | | (__| | | \ V  V / | | |_) |  __/      | ||____
   |_|\___/|_|  \___|_| |_|\_/\_/  |_| .__/ \___|      |_ `    )
                                     |_|                _) __(_
"@  
Get-Funky $text
Write-host " "
Write-Host "Author: GarretSidzaka https://expanse.2enp.com"
Write-Host " "
start-sleep -s 2
$executableFilePath = $PSScriptRoot + "\Torch.Server.exe"
$mapStorageFilePath =  $PSScriptRoot + "\map.zip"
$currentLiveMapFilePath = $PSScriptRoot + "\Instance\Saves"
Write-Host "Server executable = " + $executableFilePath
Write-Host "Path for backup map.zip = " + $mapStorageFilePath
Write-Host "Live server map folder = " + $currentLiveMapFilePath
Write-Host "YOU MUST RECOGNIZE THAT THIS PROGRAM WILL COMPLETELY"
Write-Host "DELETE YOUR MAP IN 120 MINUTES! DO NOT CONTINUE WITHOUT"
Write-Host "READING THE INSTRUCTIONS AND BACKING UP YOUR MAP"
Read-Host -Prompt "Press Enter to AGREE TO DELETION OF MAP, Control-C to cancel"
Write-Host " "
start-sleep -s 2
Write-Host "Starting server at " + $executableFilePath


start-process $executableFilePath


while($true){
    Write-Host "Starting fresh map loop"

        Write-Host " "
        for ($a=0; $a -le 7200; $a++) {
        #for ($a=0; $a -le 120; $a++) {

            Write-Host -NoNewLine "`r0$a"
            Start-Sleep -Seconds 1
        }
		 Write-Host "first killing the server process"

	     $doomedServer = Get-Process | Where-Object {$_.Path -like "$executableFilePath"}
		 Write-Host $doomedServer
         Get-Process | Where-Object {$_.Path -like "$executableFilePath"} | Stop-Process -Force -processname {$_.ProcessName}
		 Get-Funky $text


		for ($a=0; $a -le 5; $a++) {
            Write-Host -NoNewLine "`r0$a"
            Start-Sleep -Seconds 1
        }
		
	    Write-Host "delete the map files"
            Start-Sleep -Seconds 1
	     Get-ChildItem -Path $currentLiveMapFilePath -Include *.* -File -Recurse | foreach { $_.Delete()}
		             Start-Sleep -Seconds 1
		 Get-ChildItem -Path $currentLiveMapFilePath -Include * -File -Recurse | foreach { $_.Delete()}
		            Start-Sleep -Seconds 1
          Write-Host "extract the original backup map"
	
		Expand-Archive -LiteralPath $mapStorageFilePath -DestinationPath $currentLiveMapFilePath

	    for ($a=0; $a -le 10; $a++) {
            Write-Host -NoNewLine "`r0$a"
            Start-Sleep -Seconds 1
        }
		
		
		
		
	     start-process $executableFilePath

}

Read-Host -Prompt "Press Enter to exit"
