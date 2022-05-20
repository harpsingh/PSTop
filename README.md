# Description
A simple PowerShell module to view CPU, memory usage and list of 10 processes sorted by CPU usage. It is similar to `top` or `htop` on Linux but much simpler. To quit, hit Ctrl+C.

<img src='.\PSTop_screenshot.png'>

# Usage
- Clone resository
```
git clone https://github.com/harpsingh/PSTop.git
```
- Import module
```powershell
Import-Module .\PSTop
```
- Run command
```
PSTop
```
- To view all processes, open PowerShell in elevated mode (Run as Administrator)