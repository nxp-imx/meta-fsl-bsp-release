FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://profile"

do_install_append() {
    install -Dm0755 ${WORKDIR}/profile ${D}${sysconfdir}/profile.d/weston.sh
}
