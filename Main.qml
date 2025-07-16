import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4 as Qqc
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtMultimedia 5.5
import SddmComponents 2.0

Rectangle {
	color: "black"
	width: Window.width
	height: Window.height

	Connections {
		target: sddm

		onLoginSucceeded: {
		}

		onLoginFailed: {
			denied.play()
		}
	}

	AnimatedImage {
		width: parent.width
		height: parent.height
		fillMode: Image.PreserveAspectCrop
		source: "altmit3.gif"
	}

	ColumnLayout {
		width: parent.width
		height: parent.height
		Qqc.Label {
			Layout.topMargin: 500
			Layout.alignment: Qt.AlignCenter
			text: "Ｕｓｅｒ ＩD:"
			color: "#c1b492"
			font.pixelSize: 16
		}
		Qqc.TextField {
			id: username
			Layout.alignment: Qt.AlignCenter
			text: userModel.lastUser
			style: TextFieldStyle {
				textColor: "#63758C"
				background: Rectangle {
					color: "#000"
					implicitWidth: 200
					border.color: "#0F4D99"
				}
			}
			KeyNavigation.backtab: shutdownBtn; KeyNavigation.tab: password
			Keys.onPressed: {
				if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
					sddm.login(username.text, password.text, session.index)
					event.accepted = true
				}
			}
		}
		Qqc.Label {
			Layout.alignment: Qt.AlignCenter
			text: "Ｐａｓｓｗｏｒｄ："
			color: "#c1b492"
			font.pixelSize: 16
		}
		Qqc.TextField {
			id: password
			echoMode: TextInput.Password
			Layout.alignment: Qt.AlignCenter
			style: TextFieldStyle {
				textColor: "#63758C"
				background: Rectangle {
					color: "#000"
					implicitWidth: 200
					border.color: "#0F4D99"
				}
			}
			KeyNavigation.backtab: username; KeyNavigation.tab: session
			Keys.onPressed: {
				if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
					sddm.login(username.text, password.text, session.index)
					event.accepted = true
				}
			}
		}
		ColumnLayout {
			Layout.alignment: Qt.AlignCenter
			Layout.topMargin: 4
			Layout.bottomMargin: 50
			width: 200
			Rectangle {
				anchors.fill: parent
				color: "#1A5AA7"
			}
			Qqc.Label {
				Layout.alignment: Qt.AlignCenter
				text: "Ｌｏｇｉｎ"
				color: "#FFFFFF"
				font.pixelSize: 20
			}
			MouseArea {
				anchors.fill: parent
				onClicked: sddm.login(username.text, password.text, session.index)
			}
		}
	}
	AnimatedImage {
		id: shutdownBtn
		// height: 120
		width: 120
		y: 0
		x: Window.width - width
		source: "power.gif"
		fillMode: Image.PreserveAspectFit
		MouseArea {
			anchors.fill: parent
			hoverEnabled: true
			onClicked: sddm.powerOff()
			onEntered: {
				var component = Qt.createComponent("ShutdownToolTip.qml");
				if (component.status == Component.Ready) {
					var tooltip = component.createObject(shutdownBtn);
					tooltip.x = -45
					tooltip.y = 60
				tooltip.destroy(600);
				}
			}
		}
	}
	ComboBox {
		id: session
		height: 30
		width: 200
		x: 15
		y: 20
		model: sessionModel
		index: sessionModel.lastIndex
		color: "#000"
		borderColor: "#0F4D99"
		focusColor: "#2D92F5"
		hoverColor: "#4AA5F6"
		textColor: "#63758C"
		arrowIcon: "angle-down.png"
		KeyNavigation.backtab: password; KeyNavigation.tab: rebootBtn;
	}
	Audio {
		id: bgMusic
		source: "loadmenu.mp3"
		autoPlay: true
		loops: Audio.Infinite
	}
	Audio {
		id: welcome
		source: "welcome.wav"
		autoPlay: true
	}
	Audio {
		id: denied
		source: "denied.wav"
	}

	Component.onCompleted: {
		if (username.text == "") {
			username.focus = true
		} else {
			password.focus = true
		}
	}
}
