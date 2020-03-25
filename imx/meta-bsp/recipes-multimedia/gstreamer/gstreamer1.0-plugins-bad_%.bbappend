FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

GST_CFLAGS_EXTRA = "${@base_contains('DISTRO_FEATURES', 'x11', '', \
                       base_contains('DISTRO_FEATURES', 'wayland', '-DEGL_API_FB -DWL_EGL_PLATFORM', \
					   base_contains('DISTRO_FEATURES', 'directfb', '-DEGL_API_DFB -I${STAGING_INCDIR}/directfb', '-DEGL_API_FB', d),d),d)}"
CFLAGS_append_mx6q = " ${GST_CFLAGS_EXTRA}"
CFLAGS_append_mx6dl = " ${GST_CFLAGS_EXTRA}"
CFLAGS_append_mx6sx = " ${GST_CFLAGS_EXTRA}"

PACKAGECONFIG_GL_mx6q = "${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'gles2', '', d)}"
PACKAGECONFIG_GL_mx6dl = "${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'gles2', '', d)}"
PACKAGECONFIG_GL_mx6sx = "${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'gles2', '', d)}"
PACKAGECONFIG_GL_mx6sl = "${@bb.utils.contains('DISTRO_FEATURES', 'opengl', \
                           base_contains('DISTRO_FEATURES', 'x11', \
                                    'opengl', '', d), '', d)}"

PACKAGECONFIG_append_mx6q = "${@base_contains('DISTRO_FEATURES', 'directfb', ' ', \
                ' opencv ', d)}"
PACKAGECONFIG_append_mx6qp = "${@base_contains('DISTRO_FEATURES', 'directfb', ' ', \
                ' opencv ', d)}"


#revert poky fido commit:cdc2c8aeaa96b07dfc431a4cf0bf51ef7f8802a3: move EGL to Wayland
PACKAGECONFIG[gles2]   = "--enable-gles2 --enable-egl,--disable-gles2 --disable-egl,virtual/libgles2 virtual/egl"
PACKAGECONFIG[wayland] = "--enable-wayland --disable-x11,--disable-wayland,wayland"

#i.MX specific
SRC_URI_append = " file://egl-workaround-for-eglCreateContext-isn-t-thread-safe.patch \
                   file://camerabin-Add-one-property-to-set-sink-element-for-video.patch \
                   file://0011-videoparse-modifiy-the-videoparse-rank.patch \
                   file://0013-PATCH-install-gstaggregator-and-gstvideoaggregator-h.patch \
"

#common
SRC_URI_append += " file://camerabin-examples-memory-leak-in-camerabin-examples-01.patch \
                    file://camerabin-examples-memory-leak-in-camerabin-examples-02.patch \
                    file://dvbsuboverlay-Set-query-ALLOCATION-need_pool-to-FALSE.patch \
                    file://0002-mpegtsmux-Need-get-pid-when-create-streams.patch \
                    file://0006-h263parse_fix_CPFMT_parsing.patch \
                    file://0009-mpeg4videoparse-Need-detect-picture-coding-type-when.patch \
                    file://0010-mpegvideoparse-Need-detect-picture-coding-type-when-.patch \
                    file://0012-glfilter-Lost-frame-rate-info-when-fixate-caps.patch \
                    file://0014-opencv-rename-gstopencv.c-to-gstopencv.cpp.patch \
                    file://0015-opencv-Add-video-stitching-support.patch \
                    file://0016-PATCH-gstaggregator-memory-leak-increasing-a-lot-aft.patch \
"

# i.MX6 patches for GST1.4.5
GPU_PATCHES = " file://1.4.5-Use-viv-direct-texture-to-bind-buffer.patch \
                file://0001-Support-croping-and-alignment-handling.patch \
                file://Fix-warnnig-log-in-glfilter.patch \
                file://Adding-some-fragment-shaders-for-glshader-plugin.patch \
                file://Fix-for-gl-plugin-not-built-in-wayland-backend.patch \
                file://0003-glimagesink-Add-fps-print-in-glimagesink.patch \
                file://0004-gl-fb-Support-fb-backend-for-gl-plugins.patch \
                file://0005-gl-wayland-Make-it-always-fullscreen-1024x768.patch \
                file://0007-glfilter-Fix-video-is-tearing-after-enab.patch \
                file://0008-gl-Fix-glimagesink-loop-playback-failed-in-wayland.patch \
                file://0017-MMFMWK-6778-Support-more-format-in-direct-viv.patch \
"

SRC_URI_append_mx6q  = "${GPU_PATCHES}"
SRC_URI_append_mx6dl = "${GPU_PATCHES}"
SRC_URI_append_mx6sx = "${GPU_PATCHES}"

# include fragment shaders
FILES_${PN}-opengl += "/usr/share/*.fs"

PACKAGE_ARCH_mx6 = "${MACHINE_SOCARCH}"
PACKAGE_ARCH_mx7 = "${MACHINE_SOCARCH}"