#ifndef USERMODEL_H
#define USERMODEL_H

#include <QAbstractListModel>

class UserModelPrivate;


class UserModel : public QAbstractListModel
{
    Q_OBJECT
    // Q_PROPERTY(QString firstUser READ firstUser CONSTANT)
public:
    enum UserRoles {
        NameRole = Qt::UserRole + 1,
        RealNameRole,
        HomeDirRole,
        IconRole,
        NeedsPasswordRole
    };

    UserModel(QObject *parent = 0);
    ~UserModel();

    QHash<int, QByteArray> roleNames() const override;

    // QString firstUser() const;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

private:
    UserModelPrivate *d { nullptr };
};


#endif // USERMODEL_H
