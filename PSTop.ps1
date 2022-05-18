function Show-Bar ($percentage){
    Write-Host "[" -NoNewline
    $display = ""
    if ($percentage -eq 0){
        1..100 | ForEach-Object { $display += " " }
        Write-Host $display -NoNewline
    }
    else{
        if ($percentage -lt 70){
            $bar_color = "Green"
        }
        elseif ($percentage -lt 90){
            $bar_color = "Yellow"
        }
        else{
            $bar_color = "Red"
        }
        1..$percentage | ForEach-Object { $display += "|" }
        $percentage..99 | ForEach-Object { $display += " " }
        Write-Host $display -ForegroundColor $bar_color -NoNewline
    }
    Write-Host "]" -NoNewline
}

$total_memory = [Math]::Round((Get-WmiObject -Class win32_operatingsystem -Property TotalVisibleMemorySize).TotalVisibleMemorySize / 1MB, 2)

while ($True){
    $cpu_avg = [Math]::Round((Get-Counter -Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue, 0)
    $available_memory = [Math]::Round((Get-Counter -Counter '\Memory\Available Bytes').CounterSamples[0].CookedValue / 1GB, 2)
    $used_memory = $total_memory - $available_memory
    $processes = Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 | Format-Table

    [Console]::Clear()

    Write-Host "CPU: " -NoNewline
    Show-Bar $cpu_avg
    Write-Host " $cpu_avg%"
    Write-Host "Mem: " -NoNewline
    Show-Bar $(($used_memory / $total_memory) * 100)
    Write-Host " $used_memory GB / $total_memory GB"
    $processes
}