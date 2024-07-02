param (
	[string]$cursorName,
	[string]$cursorPath
)

if (-not $cursorPath -or -not (Test-Path -Path $cursorPath)) {
	Write-Error "Please provide a valid path to the cursor files."
	exit 1
}

if (-not $cursorName) {
	$cursorName = "(Default)"
}

$cursorSchemes = @{
	"(Default)"   = "$cursorName"
	"Arrow"       = "$cursorPath\pointer.cur"
	"Help"        = "$cursorPath\help.cur"
	"AppStarting" = "$cursorPath\working.ani"
	"Wait"        = "$cursorPath\busy.ani"
	"Crosshair"   = "$cursorPath\precision.cur"
	"IBeam"       = "$cursorPath\beam.cur"
	"NWPen"       = "$cursorPath\handwriting.cur"
	"No"          = "$cursorPath\unavailable.cur"
	"SizeNS"      = "$cursorPath\vert.cur"
	"SizeWE"      = "$cursorPath\horz.cur"
	"SizeNWSE"    = "$cursorPath\dgn1.cur"
	"SizeNESW"    = "$cursorPath\dgn2.cur"
	"SizeAll"     = "$cursorPath\move.cur"
	"UpArrow"     = "$cursorPath\alternate.cur"
	"Hand"        = "$cursorPath\link.cur"
	"Person"      = "$cursorPath\person.cur"
	"Pin"         = "$cursorPath\pin.cur"
}

function Set-CursorScheme {
	param (
		[string]$name,
		[string]$path
	)
	$regPath = "HKCU:\Control Panel\Cursors"
	Set-ItemProperty -Path $regPath -Name $name -Value $path
}

foreach ($cursor in $cursorSchemes.Keys) {
	Set-CursorScheme -name $cursor -path $cursorSchemes[$cursor]
}

rundll32.exe user32.dll, UpdatePerUserSystemParameters
Start-Sleep -Seconds 1

function RefreshCursorScheme {
	Add-Type @"
using System;
using System.Runtime.InteropServices;
public class RefreshCursorFunction
{
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern IntPtr LoadCursorFromFile(string fileName);
    [DllImport("user32.dll")]
    public static extern bool SystemParametersInfo(uint action, uint param, string vparam, uint init);
    const uint SPI_SETCURSORS = 0x0057;
    public static void Refresh(string cursorPath)
    {
        SystemParametersInfo(SPI_SETCURSORS, 0, null, 0);
    }
}
"@
	[RefreshCursorFunction]::Refresh($cursorPath)
}

RefreshCursorScheme
Write-Output "Cursor scheme updated successfully."