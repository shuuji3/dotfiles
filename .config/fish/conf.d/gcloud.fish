. (brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

# Increase upload bandwidth
# ref. https://cloud.google.com/iap/docs/using-tcp-forwarding
export CLOUDSDK_PYTHON_SITEPACKAGES=1

# Select configurations with fzf
alias gcloud-config="CLOUDSDK_ACTIVE_CONFIG_NAME=(FZF_DEFAULT_COMMAND=\"gcloud config configurations list --format='get(name)'\" fzf --ansi --no-preview)"

