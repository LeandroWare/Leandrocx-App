#include "texteditor.h"
#include <QFile>
#include <QFileInfo>
#include <QFileDialog>
#include <QStandardPaths>

TextEditor::TextEditor(QPlainTextEdit* editor, FileHandler* fileHandler, QObject* parent)
    : QObject(parent), m_editor(editor), m_fileHandler(fileHandler), m_isUntitled(true)
{
    //conecta modificação de documento ao sinal documentModified
    connect(m_editor->document(), &QTextDocument::modificationChanged, this, &TextEditor::documentModified);

    //configura autosave a cada 5 minutos
    setupAutoSave(5 * 60 * 1000);
}

void TextEditor::setupAutoSave(int intervalMs) {
    m_autosaveTimer.setInterval(intervalMs);
    connect(&m_autosaveTimer, &QTimer::timeout, this, &TextEditor::autosave);
    m_autosaveTimer.start();
}

void TextEditor::newDocument() {
    m_editor->clear();

    m_currentFile.clear();
    m_isUntitled = true;

    m_editor->document()->setModified(false);
    emit documentModified(false);

    //informa a UI (exemplo: barra de status)
    emit statusMessage("Novo documento criado");
}

void TextEditor::openDocument(const QString& filepath) {
    QString text = m_fileHandler->loadLsd(filepath);
    m_editor->setPlainText(text);

    m_currentFile = filepath;
    m_isUntitled = false;
    m_editor->document()->setModified(false);
    emit documentModified(false);
    emit statusMessage(QString("Aberto %1").arg(filepath));
}

void TextEditor::saveDocument() {
    if(m_isUntitled) {  //se não tiver nome,
        emit requestSaveAs(); //chama o saveAs
        return;
    }

    m_fileHandler->saveLsdBin(m_editor->toPlainText(), m_currentFile); //salvando em binário
    m_editor->document()->setModified(false);
    emit documentModified(false);
    emit statusMessage("Salvo em " + m_currentFile);
}

void TextEditor::saveDocumentAs(const QString& filepath) {
    m_currentFile = filepath;
    m_isUntitled = false;

    //garante que o diretório existe -> não acho muito necessário ter
    QFileInfo fi(filepath);
    QDir dir = fi.dir();
    if (!dir.exists() && !dir.mkpath(dir.absolutePath())) {
        emit statusMessage(QString("Erro: não foi possível criar pasta %1").arg(dir.absolutePath()));
        return;
    }

    m_fileHandler->saveAs(m_editor->toPlainText(), m_currentFile);
    m_editor->document()->setModified(false);
    emit documentModified(false);
    emit statusMessage(QString("Salvo como %1").arg(filepath));
}

void TextEditor::autosave() {
    const QString text = m_editor->toPlainText();
    if (m_isUntitled) {
        //salva temporário em pasta fixa
        const QString base = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/Leandrocx/Docs";
        QDir(base).mkpath(base);

        const QString tempFile = QDir(base).filePath("autosave.lsd");
        m_fileHandler->saveLsdBin(text, tempFile);

        emit statusMessage("Auto-save (temporário) em " + tempFile);
    } else {
        m_fileHandler->saveLsd(text, QFileInfo(m_currentFile).completeBaseName());
        emit statusMessage("Auto-save em " + m_currentFile);
    }
}

void TextEditor::exportToPdf(const QString& filePath) {
    const QString escaped = m_editor->toPlainText().toHtmlEscaped();
    const QString html = "<pre>" + escaped + "</pre>";

    m_fileHandler->exportPdf(html, filePath);
    emit statusMessage("Exportado PDF para " + filePath);
}
