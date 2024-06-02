#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <KLocalizedContext>
#include <KLocalizedString>
#include <QQuickStyle>
#include <Kirigami/Platform/PlatformTheme>
#include <KColorSchemeManager>
#include <KIconThemes/kicontheme.h>
 #include <QQuickWindow>
#include "colorschememanager.h"
int main(int argc, char *argv[])
{
   QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGL);
    QGuiApplication app(argc, argv);
	KIconTheme::current();
    KLocalizedString::setApplicationDomain("helloworld");
    QCoreApplication::setOrganizationName(QStringLiteral("KDE"));
    QCoreApplication::setOrganizationDomain(QStringLiteral("kde.org"));
    QCoreApplication::setApplicationName(QStringLiteral("Hello World"));

    //QQuickStyle::setStyle("Universal");
    // if (qEnvironmentVariableIsEmpty("QT_QUICK_CONTROLS_STYLE")) {
       QQuickStyle::setStyle(QStringLiteral("org.kde.desktop"));
    // }
    qmlRegisterType<colorschememanager>("com.example.ColorSchemeManager", 1, 0, "ColorSchemeModel");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    const QUrl url(QStringLiteral("qrc:/kiritest/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);
    // Kirigami::Platform::PlatformTheme* theme = new Kirigami::Platform::PlatformTheme;
    // KColorSchemeManager *schemes = new KColorSchemeManager();

    //        // Get the KColorSchemeModel
    // QAbstractItemModel *model = schemes->model();

    //        // Print the available color schemes
    // qDebug() << "Available Color Schemes:";
    // for (int row = 0; row < model->rowCount(); ++row) {
    //     QModelIndex index = model->index(row, 0); // Assuming the name is in the first column
    //     QString schemeName = index.data().toString();
    //     qDebug() << schemeName;
    // }

    //        // Activate the color scheme at index 3
    // QModelIndex schemeIndex = model->index(4, 0); // Index 3, column 0
    // schemes->activateScheme(schemeIndex);

    return app.exec();
}
