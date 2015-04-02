# Usage: scoop shellinit
# Summary: Initialises any required scoop environment variables for the 
# current session
# Help: Use this when you want access to the Scoop core library

function local:get_scoopdir {
  $scoopappdir = $null
  try {
    $scoopappdir = resolve-path $(scoop config home)
  }
  catch {
    $scoopappdir = resolve-path "$(scoop which scoop)\..\.."
    scoop config home "$scoopappdir"
  }

  if(!$scoopappdir) {
    write-error "something went wrong: couldn't find scoop directory"
    exit 1
  }

  $scoopappdir
}
$env:SCOOP_HOME = get_scoopdir