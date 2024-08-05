## Constants
#
RED="\e[31m"
GREEN="\e[32m"
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
function bck_cfg_and_link() {
	dst=$1
	cfg=$2
	if [ -f $dst ]; then
		if [ ! -L "${dst}" ]; then
			mv $dst "${dst}_bck_`date +%s`"
		fi
	fi
	ln -fs $(pwd)/$cfg $dst
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