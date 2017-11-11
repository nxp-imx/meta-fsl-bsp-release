# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2017 NXP

include recipes-bsp/imx-test/imx-test.inc

SRCBRANCH = "imx_4.9.51_imx8_beta1"
IMXTEST_SRC ?= "git://source.codeaurora.org/external/imx/imx-test.git;protocol=https"

SRC_URI = "${IMXTEST_SRC};branch=${SRCBRANCH}"
SRC_URI_append = " file://memtool_profile "

SRCREV = "6217a637d7e01141bf70f83ef1795e12b22c5097"

S = "${WORKDIR}/git"

DEPENDS_mx6sl += "virtual/imxvpu"
DEPENDS_mx6sx += "virtual/imxvpu"
DEPENDS_mx6ul += "virtual/imxvpu"
DEPENDS_mx6sll += "virtual/imxvpu"
DEPENDS_mx7d  += "virtual/imxvpu"
DEPENDS_mx7ulp  = "virtual/kernel imx-lib virtual/imxvpu"
DEPENDS_append_mx8 = " virtual/kernel alsa-lib"
DEPENDS_append_mx8mq = " virtual/kernel virtual/imxvpu alsa-lib"

PLATFORM_mx6sll = "IMX6SL"
PLATFORM_mx7ulp  = "IMX7D"
PLATFORM_mx8 = "IMX8"

IMX_HAS_VPU         = "false"
IMX_HAS_VPU_imxvpu  = "true"
EXTRA_OEMAKE       += "HAS_VPU=${IMX_HAS_VPU}"

PARALLEL_MAKE="-j 1"

do_install_append() {
    install -d -m 0755 ${D}/home/root/
    install -m 0644 ${WORKDIR}/memtool_profile ${D}/home/root/.profile
}

FILES_${PN} += " /home/root/.profile "

COMPATIBLE_MACHINE = "(mx6|mx7|mx8)"
