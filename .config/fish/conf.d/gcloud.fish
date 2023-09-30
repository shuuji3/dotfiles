. (brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

# Select configurations with fzf
alias gcloud-config="CLOUDSDK_ACTIVE_CONFIG_NAME=(FZF_DEFAULT_COMMAND=\"gcloud config configurations list --format='get(name)'\" fzf --ansi --no-preview)"

