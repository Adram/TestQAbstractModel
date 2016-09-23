#include "model.h"
#include "usermodel.h"
#include "sortfiltermodel.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>

// ************************************

#include <qqmlengine.h>
#include <qqmlcontext.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>
#include <QDebug>
#include <QObject>
#include <QSortFilterProxyModel>




int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    QQuickView view;
    UserModel *user_list = new UserModel();
    AnimalModel *animal_list = new AnimalModel();
    //QSortFilterProxyModel *m_proxyModel = new QSortFilterProxyModel();
    //SortFilterModel *m_sort_filterModel = new SortFilterModel();
    SortFilterModel *m_proxyModel = new SortFilterModel();
    QSortFilterProxyModel *m_sort_filterModel = new QSortFilterProxyModel();


    animal_list->addAnimal(Animal("Zolf", "Medium"));
    animal_list->addAnimal(Animal("AXolar bear", "Large"));
    animal_list->addAnimal(Animal("Airone", "Large"));
    animal_list->addAnimal(Animal("iAppaco", "Large"));
    animal_list->addAnimal(Animal("Puoll", "Small"));


    m_proxyModel->setSourceModel(animal_list);
    m_proxyModel->setFilterRole(AnimalModel::TypeRole);
    m_proxyModel->setFilterRegExp("^");
    m_proxyModel->setSortRole(AnimalModel::TypeRole);
    m_proxyModel->setSortCaseSensitivity(Qt::CaseInsensitive);
    m_proxyModel->sort(Qt::AscendingOrder);

    m_sort_filterModel->setSourceModel(user_list);
    m_sort_filterModel->setFilterRole(UserModel::NameRole);
    m_sort_filterModel->setFilterRegExp("^");
    m_sort_filterModel->setSortRole(UserModel::NameRole);
    m_sort_filterModel->setSortCaseSensitivity(Qt::CaseInsensitive);
    m_sort_filterModel->sort(Qt::AscendingOrder);



    QQmlContext *ctxt = view.rootContext();
    ctxt->setContextProperty("myModel", m_proxyModel);
    ctxt->setContextProperty("mySortModel", m_sort_filterModel);



    view.setSource(QUrl("qrc:/main.qml"));


    view.show();


    return app.exec();
}
