
function FloorWeekend {
    [CmdletBinding()]
    param(Parameter(Mandatory=$true)[DateTime] $date)
    while($date.DayOfWeek -match "Sunday|Saturday") {
        $date = $date.AddDays(-1)
    }
    return $date
}

function ReplaceDates {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)][String] $str,
        [Parameter(Mandatory=$true)][String] $format)
    $today = Get-Date
    $yesterday = $Today.AddDays(-1)
    $str = $str -replace '<TODAY>', $today.ToString($format)
    $str = $str -replace '<YESTERDAY>', $yesterday.ToString($format)
    return $str
}

function StrToBool {
    [CmdletBinding()]
    param([Parameter(Mandatory=$true)][String] $value)
    $value = $value.ToLower()
    if($value.Equals('true')) {
        return $true
    }
    return $false
}

Export-ModuleMember -Function '*'
