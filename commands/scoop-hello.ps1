# Usage: scoop hello <name>
# Summary: An example scoop command that echos what you type
# Help: Use this command as an example for creating your own

param($name)

# Define your command's functions
function say_hello($name) {
    write-host "Hello, $name!"
}

# Here is where the command is executed
say_hello($name)
