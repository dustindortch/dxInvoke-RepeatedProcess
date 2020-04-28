function Invoke-RepeatedProcess {
    [CmdletBinding(DefaultParameterSetName='Milliseconds')]
    [Alias("Repeat")]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNull()]
        [Alias("C")]
        [scriptblock]$ScriptBlock,

        [Parameter(Mandatory, ParameterSetName='Minutes')]
        [int]$Minutes,

        [Parameter(Mandatory, ParameterSetName='Seconds')]
        [int]$Seconds,

        [Parameter(Mandatory, ParameterSetName='Milliseconds')]
        [int]$Milliseconds,

        [Switch]$RunOnce
    )

    BEGIN {
        Write-Verbose $PSCmdlet.ParameterSetName

        switch ($PSCmdlet.ParameterSetName) {
            'Minutes' {$Seconds = $Minutes * 60}
            {$PSItem -ne 'Milliseconds'} {$Milliseconds = $Seconds * 1000}
        }
    }

    PROCESS {
        :mainLoop do {
            & $ScriptBlock
            Write-Verbose (Get-Date)
            if ($RunOnce) {
                Write-Verbose 'RunOnce'
                Break mainLoop
            }
            Write-Verbose "Sleeping for $Milliseconds milliseconds"
            Start-Sleep -Milliseconds $Milliseconds
        } while ($True)
    }
}

# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.
Export-ModuleMember -Function *-*
