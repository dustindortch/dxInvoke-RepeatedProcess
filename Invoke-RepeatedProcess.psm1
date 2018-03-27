# Implement your module commands in this script.

function Invoke-RepeatedProcess {
    <#
    .SYNOPSIS
        Executes a given process repeatedly at a specified time interval
    .DESCRIPTION
        Executes a given process repeatedly at a specified time interval
    .EXAMPLE
        Invoke-RepeatedProcess -EveryXMinutes 5 -ScriptBlock {Write-Output "Hello, world!"} -Verbose
    .INPUTS
        EveryXMinutes
    .INPUTS
        ScriptBlock
    #>

    [CmdletBinding()]
    [Alias("Repeat")]
    Param
    (
        [Parameter(Mandatory,
            ValueFromPipeline)]
        [ValidateNotNull()]
        [Alias("C")]
        [scriptblock]$ScriptBlock,

        [Parameter(Mandatory=$False)]
        [int]$EveryXMinutes=5,

        [Parameter(Mandatory=$False)]
        [Switch]$RunOnce
    )

    Begin
    {
    }
    Process
    {
        $HasRan = $False
        :mainLoop While($True) {
            & $ScriptBlock
            Write-Verbose (Get-Date)
            If($RunOnce) {
                Write-Verbose "RunOnce: True"
            }
            $HasRan = $True
            If($HasRan -and $RunOnce) {
                Break mainLoop
            }
            $Seconds = 60 * $EveryXMinutes
            Write-Verbose "Sleeping for $Seconds"
            Start-Sleep -s $Seconds
        }
    }
    End
    {
    }
}

# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.
Export-ModuleMember -Function *-*
