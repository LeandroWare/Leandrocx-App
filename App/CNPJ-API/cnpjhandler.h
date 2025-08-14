#ifndef CNPJHANDLER_H
#define CNPJHANDLER_H

#include <QObject>
#include <QString>

class QNetworkAccessManager;
class QNetworkReply;

class CNPJhandler : public QObject {
    Q_OBJECT

    // CNPJ inserido
    Q_PROPERTY(QString cnpj READ cnpj WRITE setCnpj NOTIFY cnpjChanged FINAL)

    // respostas da API
    Q_PROPERTY(QList<QString> cnpjData READ cnpjData NOTIFY cnpjDataChanged FINAL)
    Q_PROPERTY(QString razaoSocial READ razaoSocial WRITE setRazaoSocial NOTIFY razaoSocialChanged FINAL)    // name
    Q_PROPERTY(QString rua READ rua WRITE setRua NOTIFY ruaChanged FINAL)                            // street
    Q_PROPERTY(QString num READ num WRITE setNum NOTIFY numChanged FINAL)                            // number
    Q_PROPERTY(QString bairro READ bairro WRITE setBairro NOTIFY bairroChanged FINAL)                   // district
    Q_PROPERTY(QString cep READ cep WRITE setCep NOTIFY cepChanged FINAL)                            // zip
    Q_PROPERTY(QString cidade READ cidade WRITE setCidade NOTIFY cidadeChanged FINAL)                   // city
    Q_PROPERTY(QString estado READ estado WRITE setEstado NOTIFY estadoChanged FINAL)                   // state
    Q_PROPERTY(QString atvPrincipal READ atvPrincipal WRITE setAtvPrincipal NOTIFY atvPrincipalChanged FINAL) // mainActivity
    Q_PROPERTY(QString nomeFantasia READ nomeFantasia WRITE setNomeFantasia NOTIFY nomeFantasiaChanged FINAL) // alias
    Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged FINAL)                   // status
    Q_PROPERTY(QString telefone READ telefone WRITE setTelefone NOTIFY telefoneChanged FINAL)             // phones

    // carregamento e erro perfumaria para o senhor esquilo frontend
    Q_PROPERTY(bool loading READ loading NOTIFY loadingChanged FINAL)
    Q_PROPERTY(QString erro READ erro NOTIFY erroOcorrido FINAL)

public:
    explicit CNPJhandler(QObject *parent = nullptr);

    // get e set CNPJ
    QString cnpj() const;
    void setCnpj(const QString &valor);

    // buscas meu jesus do ceu
    QList<QString> cnpjData() const;
    QString razaoSocial() const;
    QString rua() const;
    QString num() const;
    QString bairro() const;
    QString cep() const;
    QString cidade() const;
    QString estado() const;
    QString atvPrincipal() const;
    QString nomeFantasia() const;
    QString status() const;
    QString telefone() const;

    // carregamento e erro pra ficar bonitinho no front de nada esquilo
    bool loading() const;
    QString erro() const;

    // mexer com a API padrão do QT
    Q_INVOKABLE void fetch(const QString &cnpj);
    Q_INVOKABLE void updateCnpjData();

signals:
    // notificar que as coisas aconteceram
    void cnpjChanged();

    void cnpjDataChanged(QList<QString> cnpjDataParam);
    void razaoSocialChanged();
    void ruaChanged();
    void numChanged();
    void bairroChanged();
    void cepChanged();
    void cidadeChanged();
    void estadoChanged();
    void atvPrincipalChanged();
    void nomeFantasiaChanged();
    void statusChanged();
    void telefoneChanged();

    void loadingChanged(bool loading);
    void erroOcorrido(const QString &mensagem);

private slots:
    // função do treco de requisitar API padrão do QT sei la como funciona essa porra
    void onReplyFinished(QNetworkReply *reply);

public:
    void setCnpjData();

    // armazenar valores
    Q_INVOKABLE void setRazaoSocial(const QString &valor);
    Q_INVOKABLE void setRua(const QString &valor);
    Q_INVOKABLE void setNum(const QString &valor);
    Q_INVOKABLE void setBairro(const QString &valor);
    Q_INVOKABLE void setCep(const QString &valor);
    Q_INVOKABLE void setCidade(const QString &valor);
    Q_INVOKABLE void setEstado(const QString &valor);
    Q_INVOKABLE void setAtvPrincipal(const QString &valor);
    Q_INVOKABLE void setNomeFantasia(const QString &valor);
    Q_INVOKABLE void setStatus(const QString &valor);
    Q_INVOKABLE void setTelefone(const QString &valor);

private:

    void setLoading(bool valor);
    void setErro(const QString &error);

    // variáveis pra armazenar cada coisa
    // IMPLEMENTAR: jeito de alterar cada valor manualmente
    QList<QString> m_cnpjData;

    QString m_cnpj;    
    QString m_razaoSocial;
    QString m_rua;
    QString m_num;
    QString m_bairro;
    QString m_cep;
    QString m_cidade;
    QString m_estado;
    QString m_atvPrincipal;
    QString m_nomeFantasia;
    QString m_status;
    QString m_telefone;

    bool m_loading = false;
    QString m_erro;

    QNetworkAccessManager *m_nam;
};

#endif // CNPJHANDLER_H
