#!/bin/bash

script_hm="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

source "$script_hm/core/globals.sh"
source "$script_hm/core/main.sh"
source "$script_hm/core/pkg_mgr_utils.sh"
source "$script_hm/core/run_mdl.sh"
source "$script_hm/core/update_fix.sh"
source "$script_hm/core/apis.sh"
source "$script_hm/core/banner.sh"


banner
naas start
t_first_run "${1}"
sleep 1
no_res 0
menu
