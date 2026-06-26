/* === This file is part of Calamares - <https://calamares.io> ===
 *
 *   SPDX-FileCopyrightText: 2026 Mario Giustiniani <mariogiustiniani@gmail.com>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 *
 * Server configuration module — shows SSH and VNC sections
 * only if the corresponding packages are selected in netinstall.
 *
 * - openssh → SSH section
 * - wayvnc  → VNC section
 *
 */

import io.calamares.ui 1.0

import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1

Item {
    width: 740
    height: 420

    // Check which packages are selected in netinstall
    // globalStorage key "netinstallPackages" contains the list
    property var selectedPackages: configStorage.get("netinstallPackages") || []
    property bool hasSshd: selectedPackages.indexOf("openssh") !== -1
    property bool hasVnc:  selectedPackages.indexOf("wayvnc") !== -1 || selectedPackages.indexOf("x11vnc") !== -1

    Flickable {
        id: flick
        anchors.fill: parent
        contentHeight: 900

        ScrollBar.vertical: ScrollBar {
            id: fscrollbar
            width: 10
            policy: ScrollBar.AlwaysOn
        }

        ColumnLayout {
            x: 1
            y: 0
            width: parent.width - fscrollbar.width
            spacing: 16

            // ── SSH Section ───────────────────────────────────
            GroupBox {
                title: "SSH"
                Layout.fillWidth: true
                visible: hasSshd

                ColumnLayout {
                    spacing: 8

                    CheckBox {
                        id: sshEnabled
                        text: "Enable SSH server"
                        checked: true
                    }

                    Label { text: "SSH Port:" }
                    SpinBox {
                        id: sshPort
                        from: 1024
                        to: 65535
                        value: 22
                        enabled: sshEnabled.checked
                    }

                    Label { text: "Authentication:" }
                    ComboBox {
                        id: sshAuth
                        model: ["Password only", "Key + Password", "Key only"]
                        enabled: sshEnabled.checked
                    }
                }
            }

            // ── VNC Section ───────────────────────────────────
            GroupBox {
                title: "VNC"
                Layout.fillWidth: true
                visible: hasVnc

                ColumnLayout {
                    spacing: 8

                    CheckBox {
                        id: vncEnabled
                        text: "Enable VNC server"
                        checked: false
                    }

                    Label { text: "VNC Port:" }
                    SpinBox {
                        id: vncPort
                        from: 5900
                        to: 5999
                        value: 5901
                        enabled: vncEnabled.checked
                    }

                    Label { text: "Password:" }
                    TextField {
                        id: vncPassword
                        echoMode: TextInput.Password
                        placeholderText: "VNC password"
                        enabled: vncEnabled.checked
                    }
                }
            }

            // ── LLM Section (placeholder, hidden for now) ─────
            GroupBox {
                title: "LLM (AI)"
                Layout.fillWidth: true
                visible: false  // hidden — will be enabled later

                ColumnLayout {
                    spacing: 8

                    CheckBox {
                        id: llmEnabled
                        text: "Enable LLM service"
                        checked: false
                    }

                    Label { text: "Model:" }
                    ComboBox {
                        id: llmModel
                        model: ["Llama 3.2 8B", "Llama 3.2 3B", "Mistral 7B", "Custom"]
                        enabled: llmEnabled.checked
                    }

                    Label { text: "API Port:" }
                    SpinBox {
                        id: llmPort
                        from: 1024
                        to: 65535
                        value: 8080
                        enabled: llmEnabled.checked
                    }
                }
            }

            // ── Store config on next ──────────────────────────
            function saveConfig() {
                var config = {
                    "ssh_enabled": sshEnabled.checked,
                    "ssh_port": sshPort.value,
                    "ssh_auth": sshAuth.currentIndex,
                    "vnc_enabled": vncEnabled.checked,
                    "vnc_port": vncPort.value,
                    "vnc_password": vncPassword.text,
                    "llm_enabled": llmEnabled.checked,
                    "llm_model": llmModel.currentText,
                    "llm_port": llmPort.value
                }
                configStorage.set("server_config", config)
            }
        }
    }
}
