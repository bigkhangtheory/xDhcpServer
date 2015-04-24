Write-Verbose -Message 'Publishing configuration ...' -Verbose
Publish-AzureVMDscConfiguration -ConfigurationPath .\Samples\SampleConfiguration.ps1  -Verbose -force
Write-Verbose -Message 'Choosing VM ...' -Verbose
$vm = get-azurevm | Out-GridView -Title 'choose vm to test with' -OutputMode Single 
if($vm)
{
    Write-Verbose -Message 'Setting Extension ...' -Verbose
    Set-AzureVMDscExtension -ConfigurationArchive SampleConfiguration.ps1.zip -ConfigurationName Sample_xDhcpsServerScope_NewScope -VM $vm -Verbose
    Write-Verbose -Message 'Updating Vm ...' -Verbose
    $vm | Update-AzureVM
}
Write-Verbose -Message 'Done' -Verbose
