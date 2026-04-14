#module/script loader
scrp_ld() {
	local script="$1"
	
	#to see if the script actually exists
	entry="$(grep -F "$script" "$index_path")"

	if [ -z "$entry" ]; then
		echo "Script/Module doesn't exist"
		return 1
	fi

	path="$(echo "$entry" | awk '{ print $2 }')"
	rpath="${md_path}${path}"

	if [[ -z "$rpath" ]]; then
		echo "Script/Module is indexed but path found empty: ${path}"
		return 1
	elif [[ ! -f "$rpath" ]]; then
		echo "Script/Module is indexed but not found at $path"
		return 1
	else
		ld_md="${path}"
		rm -f $tmp_op
		touch $tmp_op
	fi


}

# this funcs are to show module options and info if they exist
sh_op() {
	local str="str_op"
	local end="end_op"
	if [[ -z "$ld_md" ]]; then
		echo "Show: no module/script selected. Nothing to show"
	else	
		sed -n "/$str/,/$end/p" "$md_path/$ld_md"
	fi
}

sh_info() {
	local str="str_info"
	local end="end_info"
	if [[ -z "$ld_md" ]]; then
		echo "Show: no module/script selected. Nothing to show"
	else	
		sed -n "/$str/,/$end/p" "$md_path/$ld_md"
	fi
}

#module/script runner
run_mdl() {
	local mdl="${md_path}${ld_md}"
	local mdl_var=$(paste -sd " " "$tmp_op")
	
	if [[ ! -x "$mdl" ]]; then
		echo "The module: $mdl is not executable"
		read -p "Do you want to make it executable (Y/n)" ans
		ans=${ans:-y}
		ans=${ans,,}
		if [[ "$ans" == "n" ]]; then
			echo "Ok as you say"
		else
			chmod +x "$mdl"
		fi
	else
        local t=$(grep -oP "#\s*t \K\S+" "$mdl")
        if [[ "$t" == "last" ]]; then
		    env $mdl_var $mdl
        elif [[ "$t" == "first" ]]; then
            env $mdl $mdl_var
        fi
	fi
	

}

# This is to unset an option/s that are no longer needed
unset_opt() {
	local ukey="${1,,}"
	if [[ -z $ukey ]]; then
		rm $tmp_op
	else
		sed -i "/${ukey}/d" "$tmp_op"
	fi		
}

# This is to set the options needed by the module/script
set_opt() {
	local key="${1,,}"
	local val="$2"
	touch "$tmp_op"

	if [[ -z "$key" || -z "$val" ]]; then
		echo "Set: no option/value specified"
	else
		echo "Set: $key => $val"
	fi

	sed -i "/${key}=/d" "$tmp_op"

	echo "${key}=${val}" >> "$tmp_op"

}

# This is to auto find new modules/scripts added in the modules folder
auto_find() {
    shopt -s globstar

    for fpath in ${md_path}**/*; do
        [[ -d "$fpath" ]] && continue
        [[ "$fpath" == "$index_path" ]] && continue

        local rel_path="${fpath#*/modules/}"
        local mdn="${fpath##*/}"
        local entry="${mdn} ${rel_path}"

        if ! grep -qFx "$entry" "$index_path"; then
            echo "Found new module: $mdn"
            echo "$entry" >> "$index_path"
        else
            echo "Module: $mdn already indexed"
        fi
    done

    shopt -u globstar
}

# This func is to search for the specified module/script
src_mdl() {
	local md_name="$1"
	
	echo "$(grep "^$md_name" "$index_path")"
}
