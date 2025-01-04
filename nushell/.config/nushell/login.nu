# Start ssh-agent if not running
if not ("SSH_AUTH_SOCK" in $env) {
    ssh-agent -s | lines | parse "{name}={value};" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value}
}

# Set SSH_AUTH_SOCK environment variable
let-env SSH_AUTH_SOCK = ($env.XDG_RUNTIME_DIR | path join "ssh-agent.socket")
