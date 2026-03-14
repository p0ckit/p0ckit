#check if apps exists
app_chk() {
	pkg_mgr_dct
	echo "Testing for apps"
	
	if [[ "$1" == "--no-test" ]]; then
		echo "${0} runned with ${1} so not testing if apps are instaled"
	elif [[ "$1" == "--no-test" && -f "$tst_file" ]]; then
		echo "${0} runned with ${1}, the test was already done [test file found: ${tst_file}]"
	else
		for app in "${apps[@]}"; do
			if which "$app" &>/dev/null; then
				((cntr++))
				echo "$app is installed"
			else
				echo "$app is not installed"
				echo "Do you want to install $app (y/N)"
				read -p "=> " ans
				ans=${ans:-n}
				ans=${ans,,}
				if [[ "$ans" = y ]]; then
					pkg_install "$app"
					((cntr++))
				else
					echo "Ok how you say"
				fi
			fi
			sleep 1
		done
	fi
	if [[ "$cntr" -ge "$req" && -z "$1" ]]; then
		echo "Testing done all needed apps are installed($cntr/$req)"
		touch "$tst_file"
	elif [[ "$1" ]]; then
		echo ""
	else
		echo "Something went wrong some apps are not installed($cntr/$req)"
	fi
	cntr=0
}

#detects distro pkg manager
pkg_mgr_dct() {
	if command -v apt >/dev/null 2>&1; then
		pkg_mgr="apt"
	elif command -v pacman >/dev/null 2>&1; then
		pkg_mgr="pacman"
	elif command -v dnf >/dev/null 2>&1; then
		pkg_mgr="dnf"
	else
		echo "Could not found a pkg manager"
	fi
}

#installs any pkg/app not found
pkg_install() {
	local pkg="$1"
	case "$pkg_mgr" in
		apt) sudo apt install -y "$pkg";;
		pacman) sudo pacman -S --noconfirm "$pkg";;
		dnf) sudo dnf install -y "$pkg";;
	esac

}
