# === This file is part of Calamares - <https://calamares.io> ===
#
#   SPDX-FileCopyrightText: 2026 Mario Giustiniani <mariogiustiniani@gmail.com>
#   SPDX-License-Identifier: BSD-2-Clause
#
if(NOT WITH_QML)
    calamares_skip_module( "server (QML is not supported in this build)" )
    return()
endif()

calamares_add_plugin(server
    TYPE viewmodule
    EXPORT_MACRO PLUGINDLLEXPORT_PRO
    SOURCES
        ServerViewStep.cpp
    RESOURCES
        server.qrc
    SHARED_LIB
)
