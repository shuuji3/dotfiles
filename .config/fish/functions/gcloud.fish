function gcloud --description 'fix pyenv location problem'
    set PYENV_VERSION_PREVIOUS $PYENV_VERSION
    pyenv shell system
    command gcloud $argv
    pyenv shell $PYENV_VERSION_PREVIOUS
end
    
