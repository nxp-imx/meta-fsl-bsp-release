# Copyright (C) 2017-2018 NXP

DESCRIPTION = "Sample program to monitor i.MX GPU performance data"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=bcacc6777a7173f8b95b5d1e0ac341ae"

DEPENDS = "libgpuperfcnt"

GPUTOP_SRC ?= "git://source.codeaurora.org/external/imx/imx-gputop.git;protocol=https"
SRCBRANCH = "release"
SRC_URI = "${GPUTOP_SRC};branch=${SRCBRANCH} "
SRCREV = "fee72a78edbc52622623dcdf0fe62189bdf0e2c7"

S = "${WORKDIR}/git"

inherit cmake pkgconfig

do_compile_append () {
    oe_runmake -C ${S} man
}

do_install_append() {
	install -d ${D}/${mandir}
	install -m 0444 ${S}/man/* ${D}/${mandir}
}

PACKAGE_ARCH = "${MACHINE_SOCARCH}"
PACKAGES = "${PN}"
FILES_${PN} += "${mandir}/*"
INSANE_SKIP_${PN} += "installed-vs-shipped dev-so rpaths dev-deps"

COMPATIBLE_MACHINE = "(imxgpu)"
