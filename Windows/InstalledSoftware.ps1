$a = New-Object -comobject Excel.Application
$a.visible = $True 

$b = $a.Workbooks.Add()
$c = $b.Worksheets.Item(1)

$c.Cells.Item(1,1) = "Name"
$c.Cells.Item(1,2) = "Version"
$c.Cells.Item(1,3) = "Publisher"
$c.Cells.Item(1,4) = "InstalledOn"
$c.Cells.Item(1,5) = "HelpLink"
$c.Cells.Item(1,6) = "UninstallString"

$d = $c.UsedRange
$d.Interior.ColorIndex = 19
$d.Font.ColorIndex = 11
$d.Font.Bold = $True

$intRow = 2

$Keys = Get-ChildItem HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall

$Items = $keys |foreach-object {Get-ItemProperty $_.PsPath}

foreach ($item in $items)
{
$c.Cells.Item($intRow,1) = $item.Displayname
$c.Cells.Item($intRow,2) = $item.DisplayVersion
$c.Cells.Item($intRow,3) = $item.Publisher
$c.Cells.Item($intRow,4) = $item.InstallDate
$c.Cells.Item($intRow,5) = $item.HelpLink
$c.Cells.Item($intRow,6) = $item.UninstallString

$intRow = $intRow + 1
}

$d.EntireColumn.AutoFit()