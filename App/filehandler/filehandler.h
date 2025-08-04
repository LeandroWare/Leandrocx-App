#ifndef FILEHANDLER_H
#define FILEHANDLER_H
#include <QObject>

class FileHandler : public QObject
{
    Q_OBJECT
public:
    explicit FileHandler(QObject* parent = nullptr);

    //abrir lsd
    QString loadLsd(const QString& filepath);

    //salvar como lsd:
    void saveLsd(const QString& content, const QString& filepath);

    //salvar como:
    void saveAs(const QString& content, const QString& filepath);
    //pra usar de forma correta, no main ou onde quer que chame essa função, tem que ter o bgl de selecionar onde e como vai salvar:
    /*
    //supondo que tenha um QFileDialog para pegar o caminho:
        const QString& path = QFileDialog::getSaveFileName(this, "Salvar como...", "", "Textos (*.txt);;Todos (*.*)");
        handler.saveAs(textEdit->toPlainText(), path);
    */

    //exportar como pdf:
    void exportPdf(const QString& content, const QString& pdfilepath);

    void saveLsdBin(const QString& content, const QString& filepath);
};

#endif // FILEHANDLER_H
