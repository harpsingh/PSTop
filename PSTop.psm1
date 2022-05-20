function Show-Bar {
    param (
        [String]$Header,
        [Float]$Percentage,
        [String]$Footer
    )

    $bar_units = [Math]::Round($Percentage / 2)
    Write-Host $Header -NoNewline
    Write-Host "[" -NoNewline
    $bar = ""
    if ($Percentage -eq 0){
        1..50 | ForEach-Object { $bar += " " }
        Write-Host $bar -NoNewline
    }
    else{
        if ($Percentage -lt 70){
            $bar_color = "Green"
        }
        elseif ($Percentage -lt 90){
            $bar_color = "Yellow"
        }
        else{
            $bar_color = "Red"
        }
        1..$bar_units | ForEach-Object { $bar += "|" }
        $bar_units..50 | ForEach-Object { $bar += " " }
        Write-Host $bar -ForegroundColor $bar_color -NoNewline
    }
    Write-Host "]" -NoNewline
    Write-Host $Footer
}

function PSTop {
    $total_memory = [Math]::Round((Get-WmiObject -Class win32_operatingsystem -Property TotalVisibleMemorySize).TotalVisibleMemorySize / 1MB, 2)

    while ($True){
        $cpu_avg = [Math]::Round((Get-Counter -Counter '\Processor(_Total)\% Processor Time').CounterSamples[0].CookedValue, 0)
        $available_memory = [Math]::Round((Get-WmiObject win32_operatingsystem -Property FreePhysicalMemory).FreePhysicalMemory / 1MB, 2)
        $used_memory = $total_memory - $available_memory
        $processes = Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 | Format-Table
    
        [Console]::Clear()
    
        Show-Bar -Header "CPU: " -Percentage $cpu_avg -Footer " $cpu_avg%"
        Show-Bar -Header "Mem: " -Percentage $(($used_memory / $total_memory) * 100) -Footer " $used_memory GB / $total_memory GB"
        $processes
        Start-Sleep 1
    }
}

Export-ModuleMember PSTop