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
    void newDocument();
    //abre arquivo de texto (.lsd ou plain .txt)
    void openDocument(const QString& filePath);
    //salva no arquivo atual usando FileHandler
    void saveDocument();
    //salva como, definindo novo caminho
    void saveDocumentAs(const QString& filePath);
    //exporta para PDF usando FileHandler
    void exportToPdf(const QString& filePath);

public slots:
    void autosave();

signals:
    void documentModified(bool modif);
    void statusMessage(const QString& message);
    void requestSaveAs();

private:
    QPlainTextEdit* m_editor;
    FileHandler* m_fileHandler;
    QString m_currentFile;
    bool m_isUntitled;
    QTimer m_autosaveTimer;

    void setupAutoSave(int intervalMs);
};

#endif // TEXTEDITOR_H
