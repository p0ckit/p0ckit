#variables
HISTFILE="$script_hm/.histfile"
HISTSIZE=1000
HISTFILESIZE=2000
mnfstf="$script_hm/core/manifest.txt"
tmp_op="$script_hm/core/.op.tmp"
fw_name="p0ckit"
apps=("git" "python3" "nmap" "npm" "jq" "aircrack-ng")
nt="$1"
cntr=0
req=6
hm_path="$script_hm"
tst_file="${hm_path}/.ntfr01"
md_path="${hm_path}/modules/"
index_path="${md_path}index.txt"
