# Usage: scoop plist <query>
# Summary: A posh version of scoop list
# Help: Lists the apps installed in scoop

param($query)

$(scoop shellinit)
. "$env:SCOOP_HOME/lib/core.ps1"
. "$env:SCOOP_HOME/lib/manifest.ps1"
. "$env:SCOOP_HOME/lib/versions.ps1"
. "$env:SCOOP_HOME/lib/buckets.ps1"

function posh_list($query) {
  $local = installed_apps $false | % { @{ name = $_ } }
  $global = installed_apps $true | % { @{ name = $_; global = $true } }

  $apps = @($local) + @($global)
  $app_list = @($apps | sort { $_.name } | ? { !$query -or ($_.name -match $query) } | % {
    $manifest, $bucket = find_manifest $_.name
    if(!$bucket) { $bucket = "main" }

    @{ 
      "Name" = $_.name;
      "Version" = $manifest.version;
      "Bucket" = $bucket;
    }
  })

  $exp = @{expression={$_.name};Label="App"}, `
    @{expression={$_.version};Label="Version"}, `
    @{expression={$_.bucket};Label="Bucket"}

  $app_list.foreach({[pscustomobject]$_}) | select-object name, version, bucket
}

function installed_apps($global) {
  $dir = appsdir $global
  if(test-path $dir) {
    gci $dir | where { $_.psiscontainer -and $_.name -ne 'scoop' } | % { $_.name }
  }
}

posh_list $query

exit 0
