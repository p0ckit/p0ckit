#!/usr/bin/env python3
# p0ckit updater - windows helper script
# made by ai so if any errors I'm sorry (but also why do you use windows)
# mirrors the logic from update_fix.sh but for windows users

import subprocess
import sys
import os

fw_name = "p0ckit"
repo_url = "https://github.com/tgrd0813/p0ckit.git"
img_name = "p0ckit"


def run_cmd(cmd, capture=False):
    """run a shell command, return (success, output)"""
    try:
        result = subprocess.run(
            cmd,
            capture_output=capture,
            text=True,
            shell=True
        )
        return result.returncode == 0, result.stdout.strip()
    except Exception as e:
        return False, str(e)


def check_dep(dep):
    """check if a dependency is installed"""
    ok, _ = run_cmd(f"where {dep}", capture=True)
    return ok


def check_deps():
    """check for required dependencies"""
    deps = ["git", "docker"]
    missing = []
    for dep in deps:
        if not check_dep(dep):
            missing.append(dep)
    return missing


def docker_img_exists():
    """check if the p0ckit docker image already exists locally"""
    ok, output = run_cmd(f'docker images -q {img_name}', capture=True)
    return ok and output.strip() != ""


def git_pull():
    """pull latest from github - mirrors fw_upd() in update_fix.sh"""
    print(f"Updating {fw_name} please wait...")
    ok, out = run_cmd("git pull origin main", capture=True)
    if ok:
        print("Update done")
    else:
        print(f"Update failed: {out}")
    return ok


def docker_build():
    """rebuild the docker image"""
    print(f"Rebuilding Docker image {img_name} please wait...")
    ok, out = run_cmd(f"docker build -t {img_name} .", capture=False)
    if ok:
        print("Docker image rebuilt successfully")
    else:
        print(f"Docker build failed: {out}")
    return ok


def ask(prompt, default="y"):
    """ask a yes/no question - mirrors the read -e -p pattern from bash scripts"""
    ans = input(prompt).strip().lower()
    if ans == "":
        ans = default.lower()
    return ans == "y"


def main():
    print(f"== {fw_name} updater ==\n")

    # check we're in the right directory
    if not os.path.isfile("p0ckit.sh"):
        print("Error: run this script from the p0ckit root directory")
        sys.exit(1)

    # check deps
    missing = check_deps()
    if missing:
        print(f"Error: missing dependencies: {', '.join(missing)}")
        print("Please install them and try again")
        sys.exit(1)

    # pull latest from github
    pull_ok = git_pull()
    if not pull_ok:
        print("Could not pull latest changes, aborting")
        sys.exit(1)

    # check if docker image exists
    if docker_img_exists():
        print(f"\nFound existing Docker image '{img_name}'")
        if ask(f"Do you want to rebuild it with the latest changes (Y/n)? ", default="y"):
            docker_build()
        else:
            print("Ok, not rebuilding the image")
    else:
        print(f"\nNo Docker image '{img_name}' found")
        if ask("Do you want to build it now (Y/n)? ", default="y"):
            docker_build()
        else:
            print("Ok, not building the image")

    print("\nDone")


if __name__ == "__main__":
    main()
