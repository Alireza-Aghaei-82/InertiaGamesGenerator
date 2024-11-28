import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform as Labs
import QtQuick.Dialogs

import InertiaGamesGenerator
import MyModules.Inertia.Model 1.0


Window
{
    id: root

    width: 240
    height: 100
    visible: true
    title: qsTr("Inertia Games Generator")

    property int gamesGenerated

    ColumnLayout
    {
        Layout.fillWidth: true
        anchors.topMargin: 2
        anchors.bottomMargin: 2

        GridLayout
        {
            Layout.fillWidth: true

            rows: 2
            columns: 2

            Label
            {
                Layout.leftMargin: 5
                Layout.Layout.rightMargin: 2
                text: qsTr("Rows Count:");
            }

            TextField
            {
                id: rowsCountTF

                Layout.leftMargin: 2
                Layout.Layout.rightMargin: 5
                implicitWidth: 140
                placeholderText: qsTr("Enter number of rows ...")
                validator: IntValidator { bottom: 8; top: 16 }
            }

            Label
            {
                Layout.leftMargin: 5
                Layout.Layout.rightMargin: 2
                text: qsTr("Columns Count:");
            }

            TextField
            {
                id: columnsCountTF

                Layout.leftMargin: 2
                Layout.rightMargin: 5
                implicitWidth: 140
                placeholderText: qsTr("Enter number of columns ...")
                validator: IntValidator { bottom: 8; top: 20 }
            }

            Label
            {
                Layout.leftMargin: 5
                Layout.Layout.rightMargin: 2
                text: qsTr("Games Count:");
            }

            TextField
            {
                id: gamesCountTF

                Layout.leftMargin: 2
                Layout.rightMargin: 5
                implicitWidth: 140
                placeholderText: qsTr("Enter number of games ...")
                validator: IntValidator { bottom: 100; top: 500000 }
            }
        }

        Button
        {
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: 2
            text: qsTr("Generate Games")

            onClicked: fileDialog.open()
        }
    }

    FileDialog
    {
        id: fileDialog

        fileMode: FileDialog.SaveFile
        currentFolder: "G:/work/Inertia-related-files/all-games-data"
        nameFilters: ["Inertia files (*.inrt)"]

        onAccepted: gameModel.generateAllGames(Number(rowsCountTF.text),
                                               Number(columnsCountTF.text),
                                               Number(gamesCountTF.text),
                                               fileDialog.selectedFile)
    }

    Labs.MessageDialog
    {
        id: taskCompletedDialog

        buttons: MessageDialog.Ok
        text: qsTr("Games generation completed after generating " + root.gamesGenerated + " games.")
    }

    InertiaModel
    {
        id: gameModel

        onGameGenerationCompleted: function(gamesCount)
        {
            root.gamesGenerated = gamesCount;
            taskCompletedDialog.open();
        }
    }

    GameStateMaintainer
    {
        id: stateMaintainer
        model: gameModel
        gamesDataFilesPath: GamesDataPath.path
    }
}
