$com = (New-Object -ComObject Shell.Application).NameSpace('j:\downloads')
$com.Items() | ForEach-Object {
    New-Object -TypeName PSCustomObject -Property @{
        FullName = $com.GetDetailsOf($_,0)
        Size = $com.GetDetailsOf($_,1)
        ItemType = $com.GetDetailsOf($_,2)
    }
} 