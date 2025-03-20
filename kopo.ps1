Write-Host "Script d'installation de mods pour Lethal Compagnie by Kopo"

$kobot = "             ##########@@@##########
         ##############@@@##############
       ################@@@################
    #################@@@@@@@#################
   ######.....@@@@@@@@@@@@@@@@@@@@@.....######
  #####.....@@@@@@@@@@@@@@@@@@@@@@@@@.....#####
 #####....@@@@@@@@@@@@@@@@@@@@@@@@@@@@@....#####
#####....@@@@@@@@@@@@@/////@@@@@@@@@@@@@....#####
####....@@@@@@@@@@@@/////////@@@@@@@@@@@@....####
#.......@@@@@@@@@@@////<@>////@@@@@@@@@@@.......#
####....@@@@@@@@@@@@/////////@@@@@@@@@@@@....####
#####....@@@@@@@@@@@@@/////@@@@@@@@@@@@@....#####
 #####....@@@@@@@@@@@@@@@@@@@@@@@@@@@@@....#####
  #####.....@@@@@@@@@@@@@@@@@@@@@@@@@.....#####
   ######.....@@@@@@@@@@@@@@@@@@@@@.....######
    #################@@@@@@@#################
       ####....###################....####
         #############.....#############
              #####################" 

# Définir le répertoire AppData pour l'installation
$installPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('LocalApplicationData'), 'Kopo')

# Vérifier si le fichier de stockage existe dans AppData
$saveFilePath = [System.IO.Path]::Combine($installPath, "LethalCompanyInstallLocation.txt")
$locationSaved = $false

Write-Host $kobot

# Vérifier si le fichier de sauvegarde existe et le lire
if (Test-Path $saveFilePath) {
    $savedPath = Get-Content $saveFilePath
    if (Test-Path $savedPath) {
        Write-Host "Emplacement enregistré : $savedPath"
        $fichiersTrouves = Get-ChildItem -Path $savedPath -Filter "Lethal Company.exe" -Recurse -ErrorAction SilentlyContinue
        if ($fichiersTrouves) {
            $chemin = $fichiersTrouves[0].DirectoryName
            $locationSaved = $true
        }
    }
}

# Si le jeu n'est pas trouvé à l'emplacement sauvegardé, rechercher dans tous les disques
if (-not $locationSaved) {
    Write-Host "Recherche de lethal en cours...."
    $drives = Get-PSDrive -PSProvider FileSystem
    foreach ($drive in $drives) {
        $fichiersTrouves = Get-ChildItem -Path $drive.Root -Filter "Lethal Company.exe" -Recurse -ErrorAction SilentlyContinue
        if ($fichiersTrouves) {
            $chemin = $fichiersTrouves[0].DirectoryName
            # Sauvegarder l'emplacement trouvé dans AppData
            Set-Content $saveFilePath $chemin
            Write-Host "Lethal trouve à l'emplacement : $chemin"
            $locationSaved = $true
            break
        }
    }
}

# Si l'emplacement du jeu a été trouvé, procéder à l'installation
if ($locationSaved) {
    Write-Host "L'installation est en cours.."

    # Supprimer les éléments existants si présents
    if (Test-Path -Path "$chemin\BepInEx") { Remove-Item "$chemin\BepInEx" -Recurse }
    if (Test-Path -Path "$chemin\doorstop_config.ini") { Remove-Item "$chemin\doorstop_config.ini" -Recurse }
    if (Test-Path -Path "$chemin\winhttp.dll") { Remove-Item "$chemin\winhttp.dll" -Recurse }

    # Télécharger et décompresser le mod
    wget https://download.kopo.systems/lethal/mode_lethal_cmz.zip -OutFile "$chemin\modletalhcmz.zip"
    Expand-Archive -Path "$chemin\modletalhcmz.zip" -DestinationPath $chemin
    Remove-Item "$chemin\modletalhcmz.zip"
    
    Write-Host "==Installation terminée. Bye bye!=="
} else {
    Write-Host "Lethal Company n'a pas été trouvé sur vos disques"
    Write-Host "==bye bye=="
}

sleep 5
