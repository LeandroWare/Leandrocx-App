#ifndef FILEHANDLER_H
#define FILEHANDLER_H
#include <QObject>

class FileHandler : public QObject
{
    Q_OBJECT
public:
    explicit FileHandler(QObject* parent = nullptr);

    //autosave:
    Q_INVOKABLE void autoSave(const QString& content);
    //só botar um timer pra chamar periodicamente
    /*
        QTimer *timer = new QTimer(this);
        connect(timer, &QTimer::timeout, [&]() {
            handler.autoSave(textEdit->toPlainText());
        });
        timer->start(300000); // a cada 5 minutos
    */

    //salvar como lsd:
    Q_INVOKABLE void saveLsd(QString content, QString name);

    //salvar como:
    Q_INVOKABLE void saveAs(QString content, QString filepath);
    //pra usar de forma correta, no main ou onde quer que chame essa função, tem que ter o bgl de selecionar onde e como vai salvar:
    /*
    //supondo que tenha um QFileDialog para pegar o caminho:
        QString path = QFileDialog::getSaveFileName(this, "Salvar como...", "", "Textos (*.txt);;Todos (*.*)");
        handler.saveAs(textEdit->toPlainText(), path);
    */

    //exportar como pdf:
    Q_INVOKABLE void exportPdf(QString content, QString pdfilepath);

    Q_INVOKABLE void saveLsdBin(QString content, QString name);
};

#endif // FILEHANDLER_H
