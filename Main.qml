import QtQuick

import QtQuick.Layouts
import QtQuick.Controls as Controls

import org.kde.kirigami as Kirigami
import "."
import QtQuick.Controls.Material
import org.kde.kirigamiaddons.components
import com.example.ColorSchemeManager 1.0
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

        ListView {
            anchors.fill: parent
            model: colorSchemeModel
            delegate: ItemDelegate {
                text: model.display + model.index
                width: parent.width
                onClicked: colorSchemeModel.activateScheme(model.index)
            }
        }

    }
    Kirigami.Page {
        id: timersPage
        title: "Timers"
        visible: false


    }
    Kirigami.Page {
        id: stopwatchPage
        title: "Stopwatch"
        visible: false
    }
    Kirigami.Page {
        id: alarmsPage
        title: "Alarms"
        visible: false
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
}

