$last = @{}
while ($true) {
    Clear-Host
    Write-Host "Monitoring files larger than 50 MB in C:\ ..."
    Get-ChildItem C:\ -Recurse -ErrorAction SilentlyContinue |
        Where-Object { $_.Length -gt 50MB } |
        Sort-Object Length -Descending |
        Select-Object -First 15 FullName, @{Name="Size(MB)";Expression={[math]::Round($_.Length/1MB,2)}} |
        ForEach-Object {
            $full = $_.FullName
            $size = $_."Size(MB)"
            if ($last.ContainsKey($full) -and $last[$full] -ne $size) {
                Write-Host "$($full)  -  $($size) MB  (CHANGED)" -ForegroundColor Yellow
            } else {
                Write-Host "$($full)  -  $($size) MB"
            }
            $last[$full] = $size
        }
    Start-Sleep -Seconds 2
}
