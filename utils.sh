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
