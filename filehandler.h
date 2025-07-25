#ifndef FILEHANDLER_H
#define FILEHANDLER_H
#include <QObject>

class FileHandler : public QObject
{
    Q_OBJECT
public:
    explicit FileHandler(QObject* parent = nullptr);
    Q_INVOKABLE void autoSave(QString value);
    Q_INVOKABLE void saveLsd(QString value);
    Q_INVOKABLE void saveAs(QString value, QString filepath);
    Q_INVOKABLE void exportPdf(QString value, QString pdfilepath);
};

#endif // FILEHANDLER_H
