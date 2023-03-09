#!/bin/bash

clean() {
    fd -t d -H "$1" "$2" -X rm -rfv
}

ws="$HOME/Workspace"
pydir="$ws/python"
jsdir="$ws/javascript"
vscode_dir="$HOME/.config/Code/User"

clean ".venv" "$pydir"
clean "__pycache__" "$pydir"
clean ".mypy_cache" "$pydir"
clean "node_modules" "$jsdir"
clean "workspaceStorage" "$vscode_dir"
