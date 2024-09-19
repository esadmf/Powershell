$csv = 'C:\Users\david\dwhelper\CCP\mp4_files.csv'
$vids = Import-Csv $csv
foreach($vid in $vids){
    Rename-Item $vid.'Path' $vid.'NewName'
    Move-Item $vid.'OldPath' $vid.'NewPath'
}