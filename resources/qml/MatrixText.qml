// SPDX-FileCopyrightText: Nheko Contributors
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import QtQuick.Controls
import im.nheko

TextArea {
    id: r

    property alias cursorShape: cs.cursorShape

    ToolTip.text: hoveredLink
    ToolTip.visible: hoveredLink || false
    background: null
    bottomInset: 0
    bottomPadding: 0
    // this always has to be enabled, otherwise you can't click links anymore!
    //enabled: selectByMouse
    color: palette.text
    focus: false
    leftInset: 0
    leftPadding: 0
    readOnly: true
    rightInset: 0
    rightPadding: 0
    textFormat: TextEdit.RichText
    topInset: 0
    topPadding: 0
    wrapMode: Text.Wrap

    // Setting a tooltip delay makes the hover text empty .-.
    //ToolTip.delay: Nheko.tooltipDelay
    Component.onCompleted: {
        TimelineManager.fixImageRendering(r.textDocument, r);
    }
    onLinkActivated: (link) => Nheko.openLink(link)

    // propagate events up
    onPressAndHold: event => event.accepted = false
    onPressed: event => event.accepted = (event.button == Qt.LeftButton)

    NhekoCursorShape {
        id: cs

        anchors.fill: parent
        cursorShape: hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}
