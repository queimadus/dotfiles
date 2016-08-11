# npm run autocomplete
function _scripts () {
  compls=$([[ -s $PWD/package.json ]] || return 0 && cat package.json | tr -d " \t\n\r" | \
    grep -oE 'scripts\"\:\{(.*?)\}' | sed -e "s/scripts\"\://g" | sed -e "s/{//g" | \
    grep -oE '\"[^\"]+\":' | sed -e 's/\"//g' | sed -e 's/\://g' | sed -e 's/\,//g' | sort)

  completions=(${=compls})
  compadd -- $completions
}

compdef _scripts npm run

# npm autocomplete 
source /usr/local/etc/bash_completion.d/npm

# Install dependencies globally
alias npmg="npm i -g "

# npm package names are lowercase
# Thus, we've used camelCase for the following aliases:

# Install and save to dependencies in your package.json
# npms is used by https://www.npmjs.com/package/npms
alias npmS="npm i -S "

# Install and save to dev-dependencies in your package.json
# npmd is used by https://github.com/dominictarr/npmd
alias npmD="npm i -D "

# Execute command from node_modules folder based on current directory
# i.e npmE gulp
alias npmE='PATH="$(npm bin)":"$PATH"'

# Check which npm modules are outdated
alias npmO="npm outdated"

