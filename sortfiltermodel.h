#ifndef SORTFILTERMODEL_H
#define SORTFILTERMODEL_H


#include <QDate>
#include <QSortFilterProxyModel>

class SortFilterModel : public QSortFilterProxyModel
{
    Q_OBJECT

public:
    SortFilterModel(QObject *parent = 0);


protected:

private:
};


#endif // SORTFILTERMODEL_H
