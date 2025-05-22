## Constants
#
RED="\e[31m"
GREEN="\e[32m"
PURPLE="\e[35m"
ENDCOLOR="\e[0m"

## Helper functions
#
function negative() {
	echo -e "[${RED}-${ENDCOLOR}] $1"
}
#
function positive() {
	echo -e "[${GREEN}+${ENDCOLOR}] $1"
}
#
function debug() {
	if [ -n "${dotdebug+x}" ]; then
		echo -e "[${PURPLE}%${ENDCOLOR}] $1"
	fi
}
#
function bck_cfg_and_link() {
	dst=$1
	cfg=$2
	# Check if the destination is not a symlink
	if [ ! -L $dst ]; then
		# Check if the destination exists
		if [ -n $dst ]; then
			# Backup the destination, whatever it is (file or directory)
			backup_name="${dst}_backup_$(date +%s)"
			debug "Backing up $cfg to $backup_name"
			mv $dst $backup_name
		fi
		src="$(pwd)/${cfg}"
		debug "Linking $src to $dst"
		ln -fs $src $dst
	fi
}
#
function clone_git_repo() {
	git_repo=$1
	dst=$2
	if [ ! -d $dst ]; then
		git clone --quiet --depth 1 $git_repo $dst
		# Change line ending to LF
		dos2unix $dst/**/* --quiet
	fi
}

function replace_or_append() {
	match=$1
	debug "match: $match"
	replace=$2
	debug "replace: $replace"
	file_path=$3
	debug "file_path: $file_path"
	grep_match=$(grep "${match}" $file_path | sed '/^#/d')
	if [[ -n "$grep_match" ]]; then
		if [[ $(echo "$grep_match" | wc -l) -eq 1 ]]; then
			sed -i --follow-symlinks "s/$grep_match/$replace/" $file_path
		fi
	else
		echo -e "$replace" | tee -a $file_path &>/dev/null
	fi
}
