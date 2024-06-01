cmake_minimum_required(VERSION 3.16)

project(kiritest VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)



find_package(ECM   REQUIRED NO_MODULE)


set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH})

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick QuickControls2  )

find_package(KF6  REQUIRED COMPONENTS   Kirigami    I18n
    CoreAddons
   ColorScheme
)

qt_standard_project_setup()

qt_add_executable(appkiritest
    main.cpp
)



qt_add_qml_module(appkiritest
    URI kiritest
    VERSION 1.0
    QML_FILES
    Main.qml
    QML_FILES VLayerControl.qml
    SOURCES colorschememanager.h colorschememanager.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appkiritest PROPERTIES
    #    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appkiritest
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appkiritest
    PRIVATE Qt6::Quick Qt6::QuickControls2
    KF6::Kirigami
    KF6::I18n
    KF6::CoreAddons
    KF6::ColorScheme


)

include(GNUInstallDirs)
install(TARGETS appkiritest
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
