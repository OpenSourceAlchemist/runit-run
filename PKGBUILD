# This PKGBUILD replaces sysV init scheme
# with the runit supervision system.  see
# smarden.org/runit for more information.


# Maintainer: Kevin Berry <kb@rubyuists.com>
pkgname='runit-run-git'
pkgver=20101107
pkgrel=1
pkgdesc="A SysV replacement init scheme with parallel start-up and flexible service directories"
arch=('i686' 'x86_64')
url="http://github.com/deathsyn/runit-run"
license=('MIT')
provides=('runit-run')
depends=('runit-dietlibc')
makedepends=('git')
optdepends=('socklog-dietlibc: advanced logging system' 'runit-services: a collection of commonly used service directories')
conflicts=("runit")
backup=('etc/runit/1' 'etc/runit/2' 'etc/runit/3')
install='runit-run.install'
source=()
md5sums=() #generate with 'makepkg -g'

_gitroot="https://github.com/deathsyn/runit-run.git"
_gitname="runit-run"

build() {
  cd "$srcdir"
  msg "Connecting to GIT server...."

  if [ -d $_gitname ] ; then
    cd $_gitname && git pull origin
    msg "The local files are updated."
  else
    git clone $_gitroot $_gitname
  fi

  msg "GIT checkout done or server timeout"
  msg "Starting make..."

  rm -rf "$srcdir/$_gitname-build"
  git clone "$srcdir/$_gitname" "$srcdir/$_gitname-build"
  cd "$srcdir/$_gitname-build"

  #
  # BUILD HERE
  #

}

package() {
  cd "$srcdir/$_gitname-build/archlinux"
  install -D -m 0755 etc/runit/1 $pkgdir/etc/runit/1
  install -m 0755 etc/runit/2 $pkgdir/etc/runit/2
  install -m 0755 etc/runit/3 $pkgdir/etc/runit/3
  install -m 0755 etc/runit/ctrlaltdel $pkgdir/etc/runit/ctrlaltdel
  install -d $pkgdir/etc/runit/runsvdir/runit-run-default
  install -d $pkgdir/etc/sv
  for service in etc/sv/*;do
    cp -a $service $pkgdir/etc/sv/
  done
  ln -s /etc/sv/agetty-tty2 $pkgdir/etc/runit/runsvdir/runit-run-default/
  ln -s /etc/sv/agetty-tty3 $pkgdir/etc/runit/runsvdir/runit-run-default/
  ln -s /etc/sv/syslog-ng $pkgdir/etc/runit/runsvdir/runit-run-default/
  ln -s /etc/sv/cron $pkgdir/etc/runit/runsvdir/runit-run-default/
} 