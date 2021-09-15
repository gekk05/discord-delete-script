$t = @"

███████████████╗█████╗███╗   ███╗     ██████╗██████╗██╗   ████╗    ██████████╗   ██╗█████████████╗
╚══██╔══██╔════██╔══██████╗ ████║    ██╔═══████╔══████║   ████║    ██╔════████╗  ████╔════██╔════╝
   ██║  █████╗ █████████╔████╔██║    ██║   ████████╔██║   ████║    █████╗ ██╔██╗ ████║    █████╗  
   ██║  ██╔══╝ ██╔══████║╚██╔╝██║    ██║   ████╔═══╝██║   ████║    ██╔══╝ ██║╚██╗████║    ██╔══╝  
   ██║  █████████║  ████║ ╚═╝ ██║    ╚██████╔██║    ╚██████╔████████████████║ ╚████╚█████████████╗
   ╚═╝  ╚══════╚═╝  ╚═╚═╝     ╚═╝     ╚═════╝╚═╝     ╚═════╝╚══════╚══════╚═╝  ╚═══╝╚═════╚══════╝
                                                                                                                                                                                                                                                                                                       
                                                                                                                                                     
"@

for ($i=0;$i -lt $t.length;$i++) {
if ($i%2) {
 $c = "red"
}
elseif ($i%5) {
 $c = "yellow"
}
elseif ($i%7) {
 $c = "green"
}
else {
   $c = "white"
}
write-host $t[$i] -NoNewline -ForegroundColor $c
}

#People who made this possible
$t = @"

shoutout to poppy, fcfc, dirt, dotathot, kms, conreppin, starfall
BwA, ted, mike virus, mr. vain, mcnugget
sending our <3 to all the incels & femcels in Opulence (https://discord.gg/sPtyuhUATG)  
                                                                                                                                           
"@

for ($i=0;$i -lt $t.length;$i++) {
if ($i%2) {
 $c = "darkgray"
}
elseif ($i%5) {
 $c = "magenta"
}
elseif ($i%7) {
 $c = "red"
}
else {
   $c = "darkgreen"
}
write-host $t[$i] -NoNewline -ForegroundColor $c
}

Write-host ""


#Download Python 3.8.0
Write-Host "Downloading Python 3.8.0..."
$url = "https://www.python.org/ftp/python/3.8.0/python-3.8.0-amd64.exe"
$output = "C:/tmp/python-3.8.0-amd64.exe"
New-Item -ItemType Directory -Force -Path C:/tmp | Out-Null
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile("$url", "$output")

#Install Python 3.8.0
Write-Host "Installing Python 3.8.0..."
Start-Process "$output" -argumentlist "/passive /norestart" -wait

#Download list of Python packages required to make the delete script function
Write-Host "Downloading requirements.txt..."
$url = "https://raw.githubusercontent.com/teamopulence/files/main/requirements.txt"
$output = "C:/tmp/requirements.txt"
New-Item -ItemType Directory -Force -Path C:/tmp | Out-Null
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile("$url", "$output")

#Check the Python package installer for updates
Write-Host "Checking for pip upgrade..."
Invoke-Expression -Command "py -3 -mpip install --upgrade pip" | Out-Null

#Install Python packages listed in requirements.txt
Write-Host "Installing requirements.txt..."
Invoke-Expression -Command "py -3 -mpip install -r $output"  | Out-Null

#Ask user for token that'll be inserted into the delete script
$askToken = Read-Host -Prompt 'Input your Discord token'

#Ask user for what delete command they'd like to use
$askDelPrefix = Read-Host -Prompt "Input the delete command you'd like to use (MUST include a period at the begining. Example: .del or .cum)"

#Download delete script and place it in the same location as this script
Write-Host "Downloading delete script..."
$url = "https://raw.githubusercontent.com/teamopulence/files/main/del.py"
$output = "$PSScriptRoot/Discord_Delete_Script.py"
New-Item -ItemType Directory -Force -Path $PSScriptRoot | Out-Null
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile("$url", "$output")
Write-Host "Your delete script is located at $output"

#Insert token into delete script
$file = $output
$find = 'INSERT_TOKEN_HERE'
$replace = $askToken
(Get-Content $file).replace($find, $replace) | Set-Content $file

#Insert preferred delete command into delete script
$file = $output
$find = '.del'
$replace = $askDelPrefix
(Get-Content $file).replace($find, $replace) | Set-Content $file

#Start delete script
Start-Process "$output" -argumentlist "/passive /norestart"

#Done
Pause 100
