# Script to enter the most recently modified directory within a source root directory
# and copy an enclosed .exe file and a subdirectory to a destination directory
# eg: copy 'newscript.exe' and 'ReferenceImages' folder from Output folder into Scripts folder
# This will also copy the files to the clipboard, for pasting into VMs for instance

# Variable Declarations
$sourceRoot = 'C:\Users\Kyle\OneDrive\Automation\output'
$destination = 'C:\Users\Kyle\OneDrive\Automation\_Automation\Automatic_Python_Scripts'
$copyFileType = '*.exe'
$copySubDirName = 'ReferenceImages'

# Get file path of the most recently updated folder in sourceRoot
$updatedFolderPath = Get-ChildItem $sourceRoot | sort-Object -descending -property LastWriteTime | Select-Object -first 1 | ForEach-Object {$_.FullName}

# Get .exe file path from within updatedFolderPath
$sourceEXEFile = Get-ChildItem $updatedFolderPath -filter $copyFileType | ForEach-Object {$_.FullName}

# Get file path of the sub folder to be copied
$sourceSubDir = Get-ChildItem $updatedFolderPath -Filter $copySubDirName | Select-Object -first 1 | ForEach-Object {$_.FullName}
$subDirFullContents = Join-Path -Path $sourceSubDir -ChildPath '*'
$destinationSubDir = Join-Path -Path $destination -ChildPath $copySubDirName

# Copy file to destination
Copy-Item $sourceEXEFile -Destination $destination
Set-Clipboard -path $sourceEXEFile
Copy-Item $subDirFullContents -Destination $destinationSubDir
Set-Clipboard -Path $sourceSubDir -Append