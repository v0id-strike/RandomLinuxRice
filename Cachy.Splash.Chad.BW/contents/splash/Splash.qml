import QtQuick
import org.kde.kirigami 2 as Kirigami

Image {
    id: root
    source: "images/background.png"

    property int stage

    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        Image {
            id: busyIndicator
            anchors.centerIn: parent.horizontalCenter
            y: parent.height - 100
            anchors.horizontalCenter: parent.horizontalCenter
            asynchronous: true
            source: "images/loading.svg"
            sourceSize.height: Kirigami.Units.gridUnit * 4
            sourceSize.width: Kirigami.Units.gridUnit * 4
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 2000
                loops: Animation.Infinite
                running: Kirigami.Units.longDuration > 1
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: Kirigami.Units.veryLongDuration * 2
        easing.type: Easing.InOutQuad
    }
}
