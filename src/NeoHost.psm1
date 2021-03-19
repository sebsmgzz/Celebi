
function NeoWrite {
    [CmdletBinding()]
    param(
        [Parameter(Position=0, Mandatory=$true)]
        [String]$Message,
        [Parameter(Position=1, Mandatory=$false)]
        [ConsoleColor]$Foreground = (Get-Host).UI.RawUI.ForegroundColor,
        [Parameter(Position=2, Mandatory=$false)]
        [ConsoleColor]$Background = (Get-Host).UI.RawUI.BackgroundColor)
    process { 
        $Message | Write-Host -ForegroundColor $Foreground -BackgroundColor $Background
    }
}

function NeoError {
    param([Parameter(Mandatory=$true)][System.String] $Message)
    NeoWrite -Message $Message -Foreground Red -Background Black
}

function NeoWarning {
    param([Parameter(Mandatory=$true)][System.String] $Message)
    NeoWrite -Message $Message -Foreground Yellow -Background Black
}

function NeoInform {
    param([Parameter(Mandatory=$true)][System.String] $Message)
    NeoWrite -Message $Message -Foreground Cyan
}

function NeoSuccess {
    param([Parameter(Mandatory=$true)][System.String] $Message)
    NeoWrite -Message $Message -Foreground Green
}

function NeoRead {
    param([Parameter(Mandatory=$true)][System.String] $Message)
    return read-host $Message
}

Export-ModuleMember -Function '*'
