$accion = New-ScheduledTaskAction -Execute "powershell.exe" `
  -Argument '-WindowStyle Hidden -ExecutionPolicy Bypass -Command "Start-Sleep -Seconds 120; & ''C:\Users\Acer\quartz\publicar.ps1''"' `
  -WorkingDirectory "C:\Users\Acer\quartz"
$disparador = New-ScheduledTaskTrigger -Daily -At 2:00AM
$config = New-ScheduledTaskSettingsSet -StartWhenAvailable -WakeToRun -RunOnlyIfNetworkAvailable -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
Register-ScheduledTask -TaskName "Publicar cancionero" -Action $accion -Trigger $disparador -Settings $config -Force
