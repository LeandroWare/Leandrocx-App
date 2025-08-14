#ifndef MODELHANDLER_H
#define MODELHANDLER_H

#undef slots
#include <Python.h>
#include <string>
#include <QObject>
#include <qdebug.h>
#include <windows.h>
#include <shlobj.h>    // SHGetFolderPathA
#include <filesystem>

namespace fs = std::filesystem;

class ModelHandler : public QObject
{
    Q_OBJECT
public:
    explicit ModelHandler(QObject *parent = nullptr);
    ~ModelHandler();

    Q_INVOKABLE void ExecutePythonScript(QString scriptName);

    Q_INVOKABLE void CreatePassiveModel();


    Q_INVOKABLE void exportDocument(QString fileName);

    void updateCnpjData(QList<QString> cnpjData);

    std::string getLeandrocxModelsPath();

    std::string getLeandrocxPath();

    std::string getUserPath();

private:
    QList<QString> cnpjData;

signals:
};

#endif // MODELHANDLER_H
