# Usage: scoop hello <name>
# Summary: An example scoop command that echos what you type
# Help: This is an example scoop command that doesn't do anything particularly useful
param($name)

# Define your command's functions
function say_hello($name) {
    write-host "Hello, $name!"
}

# Here is where the command is executed
switch($name) {
    $null { say_hello "world" }
    default { say_hello $name }
}

exit 0
