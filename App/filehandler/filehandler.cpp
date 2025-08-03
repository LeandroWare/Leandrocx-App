#include "filehandler.h"
#include <QFile>
#include <QTextStream>
#include <QStandardPaths>
#include <QDir>
#include <QPdfWriter>
#include <QPainter>
#include <QTextDocument>

FileHandler::FileHandler(QObject* parent)
    : QObject(parent)
{}

// arquivo salvo em "%APPDATA%\Leandrocx"
void FileHandler::saveLsd(const QString& content, const QString& filepath){
    //TODO - FAZER BGLH PRA MODIFICAR CONTEUDO SE NECESSARIO

    QFile file(filepath);
    if (file.open(QIODevice::WriteOnly | QIODevice::Text)){
        QTextStream out(&file);
        out << content;
    } else {
        qWarning() << "ERRO: Impossivel abrir arquivo (saveLsd)" << filepath;
    }
}

void FileHandler::saveLsdBin(const QString& content, const QString& filepath){
    //TODO - FAZER BGLH PRA MODIFICAR CONTEUDO SE NECESSARIO

    QFile file(filepath);
    if (file.open(QIODevice::WriteOnly | QIODevice::Truncate)){
        QDataStream out(&file);
        out << content;
    } else {
        qWarning() << "ERRO: Impossivel abrir arquivo (saveLsdBin)" << filepath;
    }
}

//=====================================================================================================================================
//esse aqui é um "salvar como".
//pra usar de forma correta, no main ou onde quer que chame essa função, tem que ter o bgl de selecionar onde e como vai salvar:
/*
    //supondo que você tenha um QFileDialog para pegar o caminho:
const QString& path = QFileDialog::getSaveFileName(this, "Salvar como...", "", "Textos (*.txt);;Todos (*.*)");
handler.saveAs(textEdit->toPlainText(), path);
*/
void saveAs (const QString& content, const QString& filepath) {
    //TODO - FAZER BGLH PRA MODIFICAR CONTEUDO SE NECESSARIO

    QFile file(filepath);

    if(file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream out(&file);
        out << content;
        file.close();
    } else {
        qWarning() << "ERRO: Impossivel abrir arquivo (saveAs)" << filepath;
    }
}

//=====================================================================================================================================
//nome auto-explicativo.
//esse é mais de boa pra chamar, só botar um timer pra chamar periodicamente
/*
    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, [&]() {
        handler.autoSave(textEdit->toPlainText());
    });
timer->start(300000); // a cada 5 minutos
*/
void FileHandler::autoSave(const QString&& content){
    const QString& docsPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/Leandrocx" + "/Docs";
    QDir dir(docsPath);
    if (!dir.exists()){
        dir.mkpath(docsPath);
    }
    //saveLsd(content, "autosave");
    saveLsdBin(content, "autosave"); //pra salvar como binário
}


//=====================================================================================================================================
void FileHandler::exportPdf(const QString& content, const QString& pdfilepath){
    //TODO - FAZER BGLH PRA MODIFICAR CONTEUDO SE NECESSARIO

    QPdfWriter writer(pdfilepath);
    writer.setPageSize(QPageSize::A4);
    writer.setResolution(300);

    QTextDocument doc;
    doc.setHtml(content);

    // CALCULA O TAMANHO DA PÁGINA EM PIXELS E CONVERTE PARA QSizeF
    QRect pageRect = writer.pageLayout()
                         .fullRectPixels(writer.resolution());
    QSizeF pageSizeF(pageRect.width(), pageRect.height());
    doc.setPageSize(pageSizeF);

    // Renderiza o doc no PDF
    QPainter painter(&writer);
    doc.drawContents(&painter);
    painter.end();
}
