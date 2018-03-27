$ModuleManifestName = 'Invoke-RepeatedProcess.psd1'
$ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath | Should Not BeNullOrEmpty
        $? | Should Be $true
    }

    It "Outputs 'Hello, world!'" {
        Invoke-RepeatedProcess -ScriptBlock {Write-Output "Hello, world!"} -RunOnce | Should Be "Hello, world!"
    }
}

