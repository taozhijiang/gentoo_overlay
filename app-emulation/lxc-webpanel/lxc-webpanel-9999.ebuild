# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit systemd eutils git-r3

DESCRIPTION="LXC Web Panel"
HOMEPAGE="http://lxc-webpanel.github.io/"

EGIT_REPO_URI="https://github.com/lxc-webpanel/LXC-Web-Panel.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		 app-emulation/lxc
		 dev-python/flask"

src_prepare() {
	sed -i 's:lwp.conf:/etc/lwp.conf:' "lwp.py"
	sed -i "s:lwp.db:/var/db/${PN}/lwp.db:" "lwp.conf"
	epatch "${FILESDIR}/lxc-config.patch"
}

src_install() {
	dodoc CHANGELOG README.md

	insinto /etc
	doins "${S}/lwp.conf"

	insinto /var/db/${PN}
	doins "${S}/lwp.db"

	insinto /usr/share/${PN}
	doins -r lwp lwp.py lxclite static templates version

	systemd_dounit "${FILESDIR}"/lwp.service

}
