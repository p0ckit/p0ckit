#This file is just to make naas work but going to add more local apis later
naas() {
    local cmd="$1"
    if [[ ! -d "${script_hm}/.no-as-a-service" ]]; then
        read -e -p "NaaS (no-as-a-service) is not installed, do you want to install it (Y/n)? " ans
        ans=${ans:-y}
        ans=${ans,,}
        if [[ "$ans" != "y" ]]; then
            echo Ok not installing naas
        else
            git clone https://github.com/hotheadhacker/no-as-a-service.git "${script_hm}/.no-as-a-service"
            echo "Installing dependencies..."
            cd .no-as-a-service && npm install && cd ..
        fi
    else
        if [[ "$cmd" == "start" ]]; then
            (
                cd "${script_hm}/.no-as-a-service" || exit 1
                if [[ ! -d "node_modules" ]]; then
                    npm install
                fi

                nohup npm start >/dev/null 2>&1 &
            ) & 
            api_pid=$!
        fi
    fi

    if [[ "$cmd" == "stop" ]]; then
        lsof -ti :3000 | xargs kill
    fi   
}
