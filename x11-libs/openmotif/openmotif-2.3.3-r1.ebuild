# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/openmotif/Attic/openmotif-2.3.3-r1.ebuild,v 1.17 2012/10/24 21:43:54 ulm dead $

EAPI=4

inherit autotools eutils flag-o-matic multilib

DESCRIPTION="Open Motif"
HOMEPAGE="http://www.motifzone.net/"
SRC_URI="ftp://ftp.ics.com/openmotif/${PV%.*}/${PV}/${P}.tar.gz"

LICENSE="MOTIF MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc examples jpeg png static-libs unicode xft"
# license allows distribution only for "open source operating systems"
RESTRICT="!kernel_linux? (
	!kernel_FreeBSD? (
	!kernel_Darwin? (
		fetch bindist
	) ) )"

RDEPEND="x11-libs/libXmu
	x11-libs/libXp
	unicode? ( virtual/libiconv )
	xft? ( x11-libs/libXft )
	jpeg? ( virtual/jpeg )
	png? ( >=media-libs/libpng-1.4 )"
DEPEND="${RDEPEND}
	sys-devel/flex
	|| ( dev-util/byacc sys-freebsd/freebsd-ubin )
	x11-misc/xbitmaps"
RDEPEND="${RDEPEND}
	doc? ( app-doc/openmotif-manual )"

pkg_nofetch() {
	local line
	while read line; do einfo "${line}"; done <<-EOF
	From the Open Motif license: "The rights granted under this license are
	limited solely to distribution and sublicensing of the contribution(s)
	on, with, or for operating systems which are themselves open source
	programs. Contact The Open Group for a license allowing distribution and
	sublicensing of the original program on, with, or for operating systems
	which are not open source programs."

	If above conditions are fulfilled, you may download the file:
	${SRC_URI}
	and place it in ${DISTDIR}.
	EOF
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.3.2-darwin.patch"
	epatch "${FILESDIR}/${PN}-2.3.2-sanitise-paths.patch"
	epatch "${FILESDIR}/${PN}-2.3.2-libpng14.patch"
	[[ ${CHOST} == *-solaris2.11 ]] \
		&& epatch "${FILESDIR}/${PN}-2.3.2-solaris-2.11.patch"

	# disable compilation of demo binaries
	sed -i -e '/^SUBDIRS/{:x;/\\$/{N;bx;};s/[ \t\n\\]*demos//;}' Makefile.am

	# add X.Org vendor string to aliases for virtual bindings
	echo -e '"The X.Org Foundation"\t\t\t\t\tpc' >>bindings/xmbind.alias

	AT_M4DIR=. eautoreconf
}

src_configure() {
	# get around some LANG problems in make (#15119)
	LANG=C

	# bug #80421
	filter-flags -ftracer

	# feel free to fix properly if you care
	append-flags -fno-strict-aliasing

	# For Solaris Xos_r.h :(
	[[ ${CHOST} == *-solaris2.11 ]] && append-flags -DNEED_XOS_R_H=1

	if use !elibc_glibc && use !elibc_uclibc && use unicode; then
		# libiconv detection in configure script doesn't always work
		# http://bugs.motifzone.net/show_bug.cgi?id=1423
		export LIBS="${LIBS} -liconv"
	fi

	# "bison -y" causes runtime crashes #355795
	export YACC=byacc

	econf --with-x \
		$(use_enable static-libs static) \
		$(use_enable unicode utf8) \
		$(use_enable xft) \
		$(use_enable jpeg) \
		$(use_enable png)
}

src_compile() {
	make clean			# remove pre-made bison parsers
	emake -j1 MWMRCDIR="${EPREFIX}"/etc/X11/mwm
}

src_install() {
	emake -j1 DESTDIR="${D}" MWMRCDIR="${EPREFIX}"/etc/X11/mwm install

	# mwm default configs
	insinto /usr/share/X11/app-defaults
	newins "${FILESDIR}"/Mwm.defaults Mwm

	if use examples; then
		emake -j1 -C demos DESTDIR="${D}" install-data
		dodir /usr/share/doc/${PF}/demos
		mv "${ED}"/usr/share/Xm/* "${ED}"/usr/share/doc/${PF}/demos || die
	fi
	rm -rf "${ED}"/usr/share/Xm

	# don't install libtool archives
	rm -f "${ED}"/usr/$(get_libdir)/*.la

	dodoc BUGREPORT ChangeLog README RELEASE RELNOTES TODO
}

pkg_postinst() {
	local line
	while read line; do elog "${line}"; done <<-EOF
	From the Open Motif 2.3.0 (upstream) release notes:
	"Open Motif 2.3 is an updated version of 2.2. Any applications
	built against a previous 2.x release of Open Motif will be binary
	compatible with this release."

	If you have binary-only applications requiring libXm.so.3, you may
	therefore create a symlink from libXm.so.3 to libXm.so.4.
	Please note, however, that there will be no Gentoo support for this.
	Alternatively, you may install slot 2.2 of x11-libs/openmotif for
	the Open Motif 2.2 libraries.
	EOF
}
