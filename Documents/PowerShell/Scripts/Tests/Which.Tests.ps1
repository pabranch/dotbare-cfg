Describe "which function" {
    It "should return the full path of an existing executable in PATH" {
        # Assuming 'which' is your custom function
        $expected = (Get-Command "git").Source
        $actual = which "git"
        $actual | Should -Be $expected
    }

    It "should return $null or throw if the command doesn't exist" {
        $actual = which "definitelyNotARealCommand123"
        $actual | Should -Be $null
    }

    It "should handle absolute paths correctly" {
        $tempExe = "$env:TEMP\dummy.exe"
        New-Item $tempExe -ItemType File -Force | Out-Null
        $actual = which $tempExe
        $actual | Should -Be $tempExe
        Remove-Item $tempExe
    }
}
