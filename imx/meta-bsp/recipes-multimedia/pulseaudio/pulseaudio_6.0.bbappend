# As it can not overwrite the version in the layer meta-fsl-arm, we have to use
#   another file extension for new patch to the append in the meta-fsl-arm

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://daemon.conf \
        file://default.pa \
        file://0001-Fix-pulseaudio-mutex-issue-when-do-pause-in-gstreame.patch \
        file://0001-client-conf-Add-allow-autospawn-for-root.patch \
        file://0002-pulseaudio-enable-allow-autospawn-for-root-as-defaul.patch \
        file://pulseaudio-remove-the-control-for-speaker-headphone-widge.patch \
"

do_install_append() {
    install -m 0644 ${WORKDIR}/daemon.conf ${D}${sysconfdir}/pulse/daemon.conf
    install -m 0644 ${WORKDIR}/default.pa ${D}${sysconfdir}/pulse/default.pa

}
