Set-PSReadLineOption -Colors @{
	Command            = 'Black'
	Number             = 'DarkGray'
	Member             = 'DarkGray'
	Operator           = 'DarkGray'
	Type               = 'DarkGray'
	Variable           = 'DarkGreen'
	Parameter          = 'DarkGreen'
	ContinuationPrompt = 'DarkGray'
	Default            = 'DarkGray'
}

$p = $host.privatedata
$p.ErrorForegroundColor = "Red"
$p.ErrorBackgroundColor = "White"
$p.WarningForegroundColor = "Yellow"
$p.WarningBackgroundColor = "White"
$p.DebugForegroundColor = "Yellow"
$p.DebugBackgroundColor = "White"
$p.VerboseForegroundColor = "Black"
$p.VerboseBackgroundColor = "White"
$p.ProgressForegroundColor = "DarkGray"
$p.ProgressBackgroundColor = "White"