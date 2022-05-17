function Show-Meter ($percentage){
    $display = "["
    1..$percentage | ForEach-Object { $display += "|" }
    $percentage..100 | ForEach-Object { $display += " " }
    $display += "]"
    return $display
}

$total_memory = [Math]::Round((Get-WmiObject -Class win32_operatingsystem -Property TotalVisibleMemorySize).TotalVisibleMemorySize / 1MB)

while ($True){
    $cpu_avg = [Math]::Round((Get-Counter -Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue, 0)
    $used_memory = [Math]::Round((Get-Counter -Counter '\Memory\Available Bytes').CounterSamples[0].CookedValue / 1GB)

    [Console]::Clear()

    # $display_text = "CPU: "
    # $display_text += Show-Meter $cpu_avg
    # $display_text += " $cpu_avg%"
    # $display_text += "`n"
    # $display_text += "Mem: "
    # $display_text += Show-Meter $(($used_memory / $total_memory) * 100)
    # $display_text += " $used_memory GB / $total_memory GB"
    # $display_text += "`n"
    # Write-Host $display_text

    [Console]::Write("CPU: ")
    [Console]::Write($(Show-Meter $cpu_avg))
    [Console]::WriteLine(" $cpu_avg%")
    [Console]::Write("Mem: ")
    [Console]::Write($(Show-Meter $(($used_memory / $total_memory) * 100)))
    [Console]::WriteLine(" $used_memory GB / $total_memory GB")
}