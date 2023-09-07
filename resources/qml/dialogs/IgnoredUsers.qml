// SPDX-FileCopyrightText: Nheko Contributors
//
// SPDX-License-Identifier: GPL-3.0-or-later
import QtQml 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import QtQuick.Window 2.15
import im.nheko 1.0

Window {
    id: ignoredUsers
    required property var profile

    title: qsTr("Ignored users")
    flags: Qt.WindowCloseButtonHint | Qt.WindowTitleHint
    height: 650
    width: 420
    minimumHeight: 420
    color: palette.window

    Connections {
        target: profile
        function onUnignoredUserError(id, err) {
            const text = qsTr("Failed to unignore \"%1\": %2").arg(id).arg(err)
            MainWindow.showNotification(text)
        }
    }

    ListView {
        id: view
        anchors.fill: parent
        spacing: Nheko.paddingMedium

        model: TimelineManager.ignoredUsers
        header: ColumnLayout {
            Text {
                Layout.fillWidth: true
                Layout.maximumWidth: view.width
                wrapMode: Text.Wrap
                color: palette.text
                text: qsTr("Ignoring a user hides their messages (they can still see yours!).")
            }

            Item { Layout.preferredHeight: Nheko.paddingLarge }
        }
        delegate: RowLayout {
            width: view.width
            Text {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft
                elide: Text.ElideRight
                color: palette.text
                text: modelData
            }

            ImageButton {
                Layout.preferredHeight: 24
                Layout.preferredWidth: 24
                image: ":/icons/icons/ui/delete.svg"
                hoverEnabled: true
                ToolTip.visible: hovered
                ToolTip.text: qsTr("Stop Ignoring.")
                onClicked: profile.ignoredStatus(modelData, false)
            }
        }
    }
}