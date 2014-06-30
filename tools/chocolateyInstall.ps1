#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'SeleniumServer' # arbitrary name for the package, used in messages
$installPath="c:\$packageName"

try {
  Install-ChocolateyZipPackage "TanukiWrapper" "http://wrapper.tanukisoftware.com/download/3.5.25/wrapper-windows-x86-32-3.5.25.zip" $installPath "$null"
  Copy-Item "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\wrapper.conf" "$installPath\wrapper-windows-x86-32-3.5.25\conf\wrapper.conf"
  Get-ChocolateyWebFile "SeleniumServerStandalone" "$installPath\wrapper-windows-x86-32-3.5.25\lib\selenium-server-standalone-latest.jar" "http://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.2.jar"
  iex "$installPath\wrapper-windows-x86-32-3.5.25\bin\InstallTestWrapper-NT.bat"
  iex "$installPath\wrapper-windows-x86-32-3.5.25\bin\StartTestWrapper-NT.bat"
  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw
}
