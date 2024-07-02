# credit: https://github.com/AutoDarkMode/Windows-Auto-Night-Mode/discussions/835

param(
	[int]$b
)

if ($b -lt 0 -or $b -gt 100) {
	Write-Host "Error: Brightness level must be between 0 and 100."
	exit
}

$namespace = "root\WMI"
$query = "SELECT * FROM WmiMonitorBrightnessMethods"
$monitor = Get-WmiObject -Namespace $namespace -Query $query
$monitor.WmiSetBrightness(1, $b)
Write-Output "Brightness set to $b%."