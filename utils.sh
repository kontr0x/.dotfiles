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