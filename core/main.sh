#cmd handler
cmd_hdlr() {
	local cmd="$1"
	shift
	local arg="$@"
	local mdl="${ld_md}"

	case "$cmd" in
		exit|quit|q)
			if [[ -z "$mdl" ]]; then
				echo "Ok quitting..."
				naas stop
				if [[ -z "$tmp_op" ]]; then
					:
				else
					rm -f $tmp_op
				fi
				exit 0
			else
				ld_md=""
				rm -f $tmp_op
			fi
			;;
		set)
			if [[ -z "$mdl" ]]; then
				echo "you haven't selected any module/script"
			else
				set_opt ${arg[@]}
			fi
			;;
		unset)
			if [[ -z "$mdl" ]]; then
				echo "you haven't selected any module/script"
			else
				unset_opt ${arg[@]}
			fi
			;;
		help) help_menu;;
		test) app_chk;;
		run) run_mdl "${arg[@]}";;
		use)
			ld_md=""
			if [[ -z "${arg[@]}" ]];then
				echo "No module/script specified please specify one"
			elif [[ "${arg[@]}" ]]; then
				scrp_ld "${arg[@]}"
			fi
			;;
		show)
			local op=$arg
			if [[ "$op" == "options" ]]; then
				sh_op
			elif [[ "$op" == "info" ]]; then
				sh_info
			elif [[ -z "$op" ]]; then
				echo "Show: you need to specify a function options/info"
			else
				echo "Show: Invalid option $op"
				echo "Show: Valid option are options/info"
			fi
			;;
		crtmnfst) crt_mnfst;;
		search) src_mdl "${arg[@]}";;
		update) fw_upd;;
		fix) fw_fix;;
		hack|no) no_res 1;;
		*)
			if command -v "${cmd}" >/dev/null 2>&1; then
				$cmd $arg
			else
				echo "Unknown framwork or system command: ${cmd}"
			fi
	esac
}

#menu
menu() {
	[[ -f "$HISTFILE" ]] && history -r "$HISTFILE"
	shopt -s histappend
	while true; do
		read -e -p "fw(${ld_md})# "  line
		set -- $line
		cmd="$1"
		shift
		arg="$@"

		[[ -z "$cmd" ]] && continue

		cmd_hdlr "$cmd" "${arg[@]}"

		history -s "$line"
		history -w "$HISTFILE"

	done
}

#check if its first run
t_first_run() {
	if [ -f "$tst_file" ]; then
		echo "Test file found"
	else
		app_chk "${@}"
	fi

	if [[ ! -f "${mnfstf}" ]]; then
		find core -type f ! -name "manifest.txt" -exec sha256sum {} + | sort > "${mnfstf}"
	else
		echo "Found manifest file"
	fi

	if [[ "$@" == "--crt-manifest" ]]; then
		echo Creating manifest file...
		sleep 1
		find core -type f ! -name "manifest.txt" -exec sha256sum {} + | sort > "${mnfstf}"
		echo Manifest file created
	fi
		
}

#help menu
help_menu() {
	echo "Help menu:"
	echo "help -- This help menu"
	echo "test -- Test for apps and dependencies"
	echo "set -- Set variables for module/script as rhost/port"
	echo "show -- Show info/options about a module/script"
	echo "use -- Use a module/script (modules by name | scritps by path)"
	echo "fix -- Fix the tool if something is broken (if you have made chages to the tool they will not be saved)"
	echo "crtmnfst -- Create manifest manually (sorry for the wierd command)"
	echo "update -- Update the tool to the lates release"
	echo "search -- Search a module/script by name or path"
	echo "exit/quit -- to quit the script"

}

#small something coz why not
no_res() {
	if [[ $@ == 1 ]]; then
		res="$(curl -s http://127.0.0.1:3000/no | jq -r '.reason')"
		echo -e "No: $res"
	elif [[ $@ == 0 ]]; then
		echo "$(curl -s http://127.0.0.1:3000/no | jq -r '.reason')"
	fi
}
