# GitHub.com related stuff
PAT=ghp_personal_access_tokens_of_your_GitHub_account
GH_USERNAME=e1630m
GIT_PATH=~/git
gcreate() {
    REPO=$1
    PUB='{"name":"'"${REPO}"'"}'
    curl -u ${GH_USERNAME}:${PAT} https://api.github.com/user/repos -d ${PUB};
}

gchere() {
    git clone git@github.com:${GH_USERNAME}/$1
    cd $1
    git branch -M main;
}

gclone() {
    cd $GIT_PATH
    gchere $1;
}

gpub() {
    REPO=$1
    gcreate $REPO
    gclone $REPO
    echo $null >> README.md
    git add README.md
    git commit -S -m "Initial Commit README.md"
    git push -u origin main;
}

gpriv() {
    REPO=$1
    PRIV='{"name":"'"${REPO}"'", "private":"true"}'
    curl -u ${GH_USERNAME}:${PAT} https://api.github.com/user/repos -d $PRIV
    gclone $REPO
    echo $null >> README.md
    git add README.md
    git commit -S -m "Initial Commit README.md"
    git push -u origin main;
}

gsub() {
    REPO=$1
    git submodule add git@github.com:${GH_USERNAME}/${REPO} ${REPO}
    cd $REPO
    git branch -M main;
}

gsinit() {
    git submodule --init --recursive;
}

