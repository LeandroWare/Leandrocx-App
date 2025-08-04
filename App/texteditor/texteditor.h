#ifndef TEXTEDITOR_H
#define TEXTEDITOR_H

#include <QObject>
#include <QPlainTextEdit>
#include <QTimer>
#include "filehandler.h"

class TextEditor : public QObject
{
    Q_OBJECT
public:
    explicit TextEditor(QPlainTextEdit* editor, FileHandler* fileHandler, QObject* parent = nullptr);

    ~TextEditor() override = default;

    //cria um novo documento (limpa o editor e estado interno)
    Q_INVOKABLE void newDocument();

    //abre arquivo de texto (.lsd ou plain .txt)
    Q_INVOKABLE void openDocument(const QString& filePath);

    //salva no arquivo atual usando FileHandler
    Q_INVOKABLE void saveDocument();

    //salva como, definindo novo caminho
    Q_INVOKABLE void saveDocumentAs(const QString& filePath);

    //exporta para PDF usando FileHandler
    Q_INVOKABLE void exportToPdf(const QString& filePath);

public slots:
    void autosave();

signals:
    void documentModified(bool modif);
    void statusMessage(const QString& message); //feedback
    void requestSaveAs();                       //pro primeiro save

private:
    QPlainTextEdit* m_editor;
    FileHandler* m_fileHandler;
    QString m_currentFile;
    bool m_isUntitled;
    QTimer m_autosaveTimer;

    //de forma porca: seta tudo q precisa pro autosave funcionar
    void setupAutoSave(int intervalMs);
};

#endif // TEXTEDITOR_H
