#!/usr/bin/env bash
ytsf(){
	[[ $# -lt 1 ]] && return 1
	local argv args mode=0 r u v R
	local init='https://www.youtube.com/results?search_query='
	local vals=("CAASAhAB" "CAI%253D" "CAMSAhAB" "CAESAhAB")
	r='^-r|--[rR][eE][lL][eE][vV][aA][nN][cC][eE]$'
	u='^-[uU]|--[uU][pP][lL][oO][aA][dD][dD][aA][tT][eE]$'
	v='^-[vV]|--[vV][iI][eE][wW][cC][oO][uU][nN][tT]$'
	R='^-R|--[rR][aA][tT][iI][nN][gG]$'
	h='^-[hH]|--[hH][eE][lL][pP]$'
	for argv in "$@"; do
		if [[ "${argv}" =~ $h ]]; then
			printf "%s\n"\
" ytsf [OPTIONS]... <QUERY>..."\
"\n Use your 'XDG' program of choice to do a YouTube search with"\
"\n a pre-filter."\
"\n\n OPTIONS:  OPTIONS and QUERY can be in any order."\
"\n\t-h,--help\t\tThis help message."\
"\n\t-r,--relevance\tDo a search by 'Relevance'."\
"\n\t-u,--uploaddate\tDo a search by 'Upload Date'."\
"\n\t-v,--viewcount\tDo a search by 'View Count'."\
"\n\t-R,--rating\t\tDo a search by 'Rating'."\
"\n\n QUERY:"\
"\n\tString\t\t\tSearch query by string."\
"\n\n"
			return
		fi
		[[ "${argv}" =~ $r ]] && mode=0 && shift
		[[ "${argv}" =~ $u ]] && mode=1 && shift
		[[ "${argv}" =~ $v ]] && mode=2 && shift
		[[ "${argv}" =~ $R ]] && mode=3 && shift
	done
	mode="${vals[$mode]}"
	args="$@"
	args="${init}${args// /+}"'&sp='"$mode"
	xdg-open "$args"	
}
$(return >/dev/null 2>&1)
if [ "$?" -eq "0" ]; then
    complete -W "-r --relevance -u --uploaddate -v --viewcount -R --rating" ytsf
else
    eval ytsf "$@"
fi
