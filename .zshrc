if [ -n "${TRACE_ZSH}" ]; then
    set -x
fi

ZSH_DISABLE_COMPFIX="true"

# Only compinit once a day, faster startups
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

DISABLE_AUTO_UPDATE="true"
DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(edit-command-line zsh-autosuggestions zsh-completions)

## Set locale
export LC_ALL="en_US.UTF-8"
# Use bash style comments
set -k

##  Imports
for file in `ls ~/.zshrc.d/*`; do
    source "$file"
done

# Private imports
for file in `ls ~/.zshrc.d.priv/*`; do
    source "$file"
done

PATH="/Users/arastogi/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/arastogi/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/arastogi/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/arastogi/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/arastogi/perl5"; export PERL_MM_OPT;
# $HOME/.cargo/bin is added to user PATH by MDM
case ":${PATH}:" in
    *:"$HOME/.cargo/bin":*)
    ;;
    *)
    export PATH="$PATH:$HOME/.cargo/bin"
    ;;
esac
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
