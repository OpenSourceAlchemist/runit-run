#!/bin/sh

# /usr/sbin/policy-rc.d [options] <initscript ID> <actions> [<runlevel>]
# /usr/sbin/policy-rc.d [options] --list <initscript ID> [<runlevel> ...]

# runit's init script policy: only run init scripts, if the 'script' is a
# symbolic link to the sv program.

usage() {
  cat >&2 <<-\EOT
	usage: policy-rc.d [--quiet] <initscript ID> <actions> [<runlevel>]
	usage: policy-rc.d --list <initscript ID> [<runlevel> ...]
	
	EOT
  exit 103  # syntax error
}

quiet=0
list=0
while test $# -gt 0; do
  case "$1" in
  --*)
    case "$1" in
    --quiet) quiet=1 ;;
    --list) list=1 ;;
    *) usage
    esac
    ;;
  *)
    break
    ;;
  esac
  shift
done
test $# -ne 0 || usage

id=$1
test -n "$id" || usage
test -e /etc/init.d/"$id" || usage

if test "$list" -eq 1; then
  cat <<\EOT

runit's init script policy is to only run init scripts, if the 'script' is a
symbolic link to the sv program.

EOT
  ls -l /etc/init.d/"$id"
  exit 0
fi

actions=$2
test -n "$actions" || usage

# check for symlink /etc/init.d/<service> -> sv
if test -h /etc/init.d/"$id"; then
  l=`readlink /etc/init.d/"$id"`
  l=${l##*/}
  if test "$l" = sv; then
    test "$quiet" -eq 1 || cat >&2 <<-EOT
	runit-policy-rc.d: allow: $*
	EOT
    exit 0  # allow
  fi
fi

test "$quiet" -eq 1 || cat >&2 <<-EOT
	runit-policy-rc.d: forbid: $*
	EOT
exit 101  # forbid
