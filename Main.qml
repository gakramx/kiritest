import QtQuick

import QtQuick.Layouts
import QtQuick.Controls as Controls

import org.kde.kirigami as Kirigami
import "."
import org.kde.quickcharts as Charts
import QtQuick.Controls.Material
import org.kde.kirigamiaddons.components
import org.kde.kirigamiaddons.formcard as FormCard
import com.example.ColorSchemeManager 1.0
// import QtQuick.VirtualKeyboard
Kirigami.ApplicationWindow {
    title: "Clock"

    header:     Kirigami.ActionToolBar {

        alignment: Qt.AlignCenter
        actions: [
            Kirigami.Action {
                text: "Beep"
                icon.name: "notifications"
                onTriggered: showPassiveNotification("BEEP!")
            },
            Kirigami.Action {
                text: "Action Menu"
                icon.name: "overflow-menu"

                Kirigami.Action {
                    text: "Deet";
                    icon.name: "notifications"
                    onTriggered: showPassiveNotification("DEET!")
                }
                Kirigami.Action {
                    text: "Doot";
                    icon.name: "notifications"
                    onTriggered: showPassiveNotification("DOOT!")
                }
            },

            Kirigami.Action {
                icon.name: "search"
                displayComponent: Kirigami.SearchField { }
            }
        ]


    }

    pageStack.initialPage: worldPage
    globalDrawer: Kirigami.GlobalDrawer {
        id: globalDrawer
        title: "Widget gallery"
        titleIcon: "applications-graphics"

        showHeaderWhenCollapsed: true
        modal : false;
        collapsible : true;
        collapsed : true;
        header:
            ColumnLayout{

            RowLayout {
                Layout.fillWidth: true

                // Controls.ToolButton {
                //     icon.name: "application-menu"
                //     visible: globalDrawer.collapsible
                //     checked: !globalDrawer.collapsed
                //     onClicked: globalDrawer.collapsed = !globalDrawer.collapsed
                // }
                Kirigami.SearchField {
                    visible: !globalDrawer.collapsed
                    Layout.fillWidth: true
                }
            }
        }


        actions: [
            Kirigami.Action {
                icon.name: "list-import-user"
                text: i18n("&Import")
            },
            Kirigami.Action {
                icon.name: "list-export-user"
                text: i18n("&Export")
            },
            Kirigami.Action {
                icon.name: "user-group-delete"
                text: i18n("&Merge contacts")
            },
            Kirigami.Action {
                icon.name: "user-group-new"
                text: i18n("&Search duplicate contacts")
            },
            Kirigami.Action {
                icon.name: "configure"
                text: i18n("&Settings")
            },
            Controls.Action{
                icon.name: "configure"
                text: i18n("&Settings")
            }
        ]
    }

    Kirigami.Page {
        id: worldPage
        title: "World"
        visible: false
        ColorSchemeModel {
            id: colorSchemeModel
        }
        header:    Kirigami.ActionToolBar {

            alignment: Qt.AlignCenter
            actions: [
                Kirigami.Action {
                    text: "Select Color"
                    icon.name: "notifications"
                    onTriggered: scrollableDialog.open()
                }

            ]


        }


        Kirigami.Dialog {
            id: scrollableDialog
            title: qsTr("Select Number")

            ListView {
                id: listView
                implicitWidth: Kirigami.Units.gridUnit * 16
                implicitHeight: Kirigami.Units.gridUnit * 16
                leftMargin: 0; rightMargin: 0; topMargin: 0; bottomMargin: 0;

                model: colorSchemeModel
                delegate: Controls.RadioDelegate {
                    topPadding: Kirigami.Units.smallSpacing * 2
                    bottomPadding: Kirigami.Units.smallSpacing * 2
                    implicitWidth: listView.width
                    text:  model.display + model.index
                    onClicked:  colorSchemeModel.activateScheme(model.index)
                }
            }
        }


    }
    Kirigami.ScrollablePage {
        id: timersPage
        title: "Timers"
        visible: false


        Kirigami.FormLayout {
            anchors.fill: parent
            Kirigami.Chip {
                text: "Chip 1"
            }
            Kirigami.Chip {
                text: "Chip 2"
            }
            Kirigami.Chip {
                text: "Chip 3"
            }
        }

    }



    Kirigami.ScrollablePage {
        id: stopwatchPage
        title: "Stopwatch"
        visible: false
        FormCard.FormCardPage {

            FormCard.FormHeader {
                title: i18n("General")
            }

            FormCard.FormCard {
                FormCard.FormTextDelegate {
                    text: i18n("Current Color Scheme")
                    description: "Breeze"

                }
                FormCard.FormComboBoxDelegate {
                    id: combobox
                    text: i18n("Default Profile")
                    description: i18n("The profile to be loaded by default.")
                    displayMode: FormCard.FormComboBoxDelegate.ComboBox
                    currentIndex: 0
                    editable: false
                    model: ["Work", "Personal"]
                }
                FormCard.FormDelegateSeparator {
                    above: combobox
                    below: checkbox
                }
                FormCard.FormCheckDelegate {
                    id: checkbox
                    text: i18n("Show Tray Icon")
                    onToggled: {
                        if (checkState) {
                            console.info("A tray icon appears on your system!")
                        } else {
                            console.info("The tray icon disappears!")
                        }
                    }
                }
            }

            FormCard.FormHeader {
                title: i18n("Autosave")
            }

            FormCard.FormCard {
                FormCard.FormSwitchDelegate {
                    id: autosave
                    text: i18n("Enabled")
                }
                FormCard.FormDelegateSeparator {
                    above: autosave
                    below: firstradio
                    visible: autosave.checked
                }
                FormCard.FormRadioDelegate {
                    id: firstradio
                    text: i18n("After every change")
                    visible: autosave.checked
                }
                FormCard.FormRadioDelegate {
                    text: i18n("Every 10 minutes")
                    visible: autosave.checked
                }
                FormCard.FormRadioDelegate {
                    text: i18n("Every 30 minutes")
                    visible: autosave.checked
                }
            }

            FormCard.FormHeader {
                title: i18n("Accounts")
            }

            FormCard.FormCard {
                FormCard.FormSectionText {
                    text: i18n("Online Account Settings")
                }
                FormCard.FormTextDelegate {
                    id: lastaccount
                    leading: Kirigami.Icon {source: "user"}
                    text: "John Doe"
                    description: i18n("The Maintainer ™️")
                }
                FormCard.FormDelegateSeparator {
                    above: lastaccount
                    below: addaccount
                }
                FormCard.FormButtonDelegate {
                    id: addaccount
                    icon.name: "list-add"
                    text: i18n("Add a new account")
                    onClicked: console.info("Clicked!")
                }
            }
        }

    }


    Kirigami.Page {
        id: alarmsPage
        title: "Alarms"
        visible: false
        // Kirigami.Card {
        //     anchors.centerIn: parent
        //     height: 260
        //     width: 200
        //     actions: [
        //         Kirigami.Action {
        //             text: qsTr("Action1")
        //             icon.name: "add-placemark"
        //         },
        //         Kirigami.Action {
        //             text: qsTr("Action2")
        //             icon.name: "address-book-new-symbolic"
        //         }

        //     ]
        //     banner {
        //         source: Qt.resolvedUrl("coffe.jpg")

        //         title: "Title Alignment"
        //         // The title can be positioned in the banner
        //         titleAlignment: Qt.AlignLeft | Qt.AlignBottom
        //     }
        //     contentItem: Controls.Label {
        //         wrapMode: Text.WordWrap
        //         text: "My Text"
        //     }
        // }
        ColumnLayout {
            Kirigami.CardsLayout {
                Kirigami.Card {
                        banner {
                            source: Qt.resolvedUrl("coffe.jpg")

                            title: "Title Alignment"
                            // The title can be positioned in the banner
                            titleAlignment: Qt.AlignLeft | Qt.AlignBottom
                        }
                    contentItem: Controls.Label {
                        wrapMode: Text.WordWrap
                        text: "My Text2"
                    }
                }

                Kirigami.Card {

                    headerOrientation: Qt.Horizontal
                    banner {
                        source: Qt.resolvedUrl("coffe.jpg")

                        title: "Title Alignment 3"
                        // The title can be positioned in the banner
                        titleAlignment: Qt.AlignLeft | Qt.AlignBottom
                    }
                    contentItem: Controls.Label {
                        wrapMode: Text.WordWrap
                        text: "My Text2"
                    }
                }
                Kirigami.Card {

                    headerOrientation: Qt.Horizontal
                    banner {
                        source: Qt.resolvedUrl("coffe.jpg")

                        title: "Title Alignment 3"
                        // The title can be positioned in the banner
                        titleAlignment: Qt.AlignLeft | Qt.AlignBottom
                    }
                    contentItem: Controls.Label {
                        wrapMode: Text.WordWrap
                        text: "My Text2"
                    }
                }
                Kirigami.Card {

                    headerOrientation: Qt.Horizontal
                    banner {
                        source: Qt.resolvedUrl("coffe.jpg")

                        title: "Title Alignment 3"
                        // The title can be positioned in the banner
                        titleAlignment: Qt.AlignLeft | Qt.AlignBottom
                    }
                    contentItem: Controls.Label {
                        wrapMode: Text.WordWrap
                        text: "My Text2"
                    }
                }
            }
        }


    }

    footer: Kirigami.NavigationTabBar {
        actions: [
            Kirigami.Action {
                icon.name: "globe"
                text: "World"
                checked: worldPage.visible
                onTriggered: {
                    if (!worldPage.visible) {
                        while (pageStack.depth > 0) {
                            pageStack.pop();
                        }
                        pageStack.push(worldPage);
                    }
                }
            },
            Kirigami.Action {
                icon.name: "player-time"
                text: "Timers"
                checked: timersPage.visible
                onTriggered: {
                    if (!timersPage.visible) {
                        while (pageStack.depth > 0) {
                            pageStack.pop();
                        }
                        pageStack.push(timersPage);
                    }
                }
            },
            Kirigami.Action {
                icon.name: "chronometer"
                text: "Stopwatch"
                checked: stopwatchPage.visible
                onTriggered: {
                    if (!stopwatchPage.visible) {
                        while (pageStack.depth > 0) {
                            pageStack.pop();
                        }
                        pageStack.push(stopwatchPage);
                    }
                }
            },
            Kirigami.Action {
                icon.name: "notifications"
                text: "Alarms"
                checked: alarmsPage.visible
                onTriggered: {
                    if (!alarmsPage.visible) {
                        while (pageStack.depth > 0) {
                            pageStack.pop();
                        }
                        pageStack.push(alarmsPage);
                    }
                }

            }
        ]
    }

    // InputPanel {
    //     id:ip
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     anchors.bottom: parent.bottom
    //     width: 600
    //     visible: Qt.inputMethod.visible

    // }

}

