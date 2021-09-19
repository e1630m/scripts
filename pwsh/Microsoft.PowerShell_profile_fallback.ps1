<#
    Default path of this file:
        (For Current User, Current Host) %UserProfile%/Documents/PowerShell/Microsoft.PowerShell_profile.ps1
        (For Current User, All Hosts) %UserProfile%/Documents/PowerShell/profile.ps1
        (For All Users, Current Host) $PSHOME/Microsoft.PowerShell_profile.ps1
        (For All Users, All Hosts) $PSHOME/profile.ps1
        (For POSIX) 
            %UserProfile%/Documents/PowerShell -> ~/.config/powershell
            %PSHOME -> /usr/local/microsoft/powershell/7
    
    Replace:
        $PAT: 'ghp_personal_access_tokens_of_your_github_account' (need repo access)
        $GH_USERNAME: 'your_github_username'
        $DEFAULT_GIT_PATH: '/path/to/the/home/directory/of/your/local/repos'
#>

$PAT = 'ghp_personal_access_tokens_of_your_GitHub_account'
$GH_USERNAME = 'e1630m'
$DEFAULT_GIT_PATH = '~/git'

Set-PoshPrompt agnoster
Function gcreate {
    $PUB = '{\"name\":\"' + $args[0] + '\"}'
    curl -u ${GH_USERNAME}:$PAT https://api.github.com/user/repos -d $PUB
}

Function gclone {
    cd $DEFAULT_GIT_PATH
    $REPO = $args[0]
    git clone git@github.com:$GH_USERNAME/$REPO
    cd $REPO
    git branch -M main
}

Function gchere {
    $REPO = $args[0]
    git clone git@github.com:$GH_USERNAME/$REPO
    cd $REPO
    git branch -M main
}

Function gpub {
    $REPO = $args[0]
    gcreate $REPO
    gclone $REPO
    echo $null >> README.md
    git add README.md
    git commit -S -m "Initial Commit README.md"
    git push -u origin main
}

Function gpriv {
    $REPO = $args[0]
    $PRIV = '{\"name\":\"' + $args[0] + '\", \"private\":\"true\"}'
    curl -u ${GH_USERNAME}:$PAT https://api.github.com/user/repos -d $PRIV
    gclone $REPO
    echo $null >> README.md
    git add README.md
    git commit -S -m "Initial Commit README.md"
    git push -u origin main
}

Function gsub {
    $REPO = $args[0]
    git submodule add git@github.com:${GH_USERNAME}/$REPO $REPO
    cd $REPO
    git branch -M main
}
