#include "usermodel.h"


#include <QFile>
#include <QList>
#include <QTextStream>
#include <QStringList>

#include <memory>
#include <pwd.h>


class User {
public:
    QString name;
    QString realName;
    QString homeDir;
    QString icon;
    bool needsPassword { false };
    int uid { 0 };
    int gid { 0 };
};

typedef std::shared_ptr<User> UserPtr;

class UserModelPrivate {
public:
    int lastIndex { 0 };
    QList<UserPtr> users;
};

UserModel::UserModel(QObject *parent) : QAbstractListModel(parent), d(new UserModelPrivate())
{

    struct passwd *current_pw;
    while ((current_pw = getpwent()) != nullptr) {


        // create user
        UserPtr user { new User() };
        user->name = QString::fromLocal8Bit(current_pw->pw_name);
        user->realName = QString::fromLocal8Bit(current_pw->pw_gecos).split(QLatin1Char(',')).first();
        user->homeDir = QString::fromLocal8Bit(current_pw->pw_dir);
        user->uid = int(current_pw->pw_uid);
        user->gid = int(current_pw->pw_gid);
        // if shadow is used pw_passwd will be 'x' nevertheless, so this
        // will always be true
        user->needsPassword = strcmp(current_pw->pw_passwd, "") != 0;


        // add user
        d->users << user;
    }

    endpwent();

    // sort users by username
    // std::sort(d->users.begin(), d->users.end(), [&](const UserPtr &u1, const UserPtr &u2) { return u1->name < u2->name; });

}

UserModel::~UserModel() {
    delete d;
}

QHash<int, QByteArray> UserModel::roleNames() const {
    // set role names
    QHash<int, QByteArray> roleNames;
    roleNames[NameRole] = QByteArrayLiteral("name");
    roleNames[RealNameRole] = QByteArrayLiteral("realName");
    roleNames[HomeDirRole] = QByteArrayLiteral("homeDir");
    roleNames[IconRole] = QByteArrayLiteral("icon");
    roleNames[NeedsPasswordRole] = QByteArrayLiteral("needsPassword");

    return roleNames;
}

int UserModel::rowCount(const QModelIndex &parent) const {
    return d->users.length();
}

QVariant UserModel::data(const QModelIndex &index, int role) const {
    if (index.row() < 0 || index.row() > d->users.count())
        return QVariant();

    // get user
    UserPtr user = d->users[index.row()];

    // return correct value
    if (role == NameRole)
        return user->name;
    else if (role == RealNameRole)
        return user->realName;
    else if (role == HomeDirRole)
        return user->homeDir;
    else if (role == IconRole)
        return user->icon;
    else if (role == NeedsPasswordRole)
        return user->needsPassword;

    // return empty value
    return QVariant();
}
