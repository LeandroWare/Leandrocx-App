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
    Q_PROPERTY(QString razaoSocial READ razaoSocial NOTIFY razaoSocialChanged FINAL)    // name
    Q_PROPERTY(QString rua READ rua NOTIFY ruaChanged FINAL)                            // street
    Q_PROPERTY(QString num READ num NOTIFY numChanged FINAL)                            // number
    Q_PROPERTY(QString bairro READ bairro NOTIFY bairroChanged FINAL)                   // district
    Q_PROPERTY(QString cep READ cep NOTIFY cepChanged FINAL)                            // zip
    Q_PROPERTY(QString cidade READ cidade NOTIFY cidadeChanged FINAL)                   // city
    Q_PROPERTY(QString estado READ estado NOTIFY estadoChanged FINAL)                   // state
    Q_PROPERTY(QString atvPrincipal READ atvPrincipal NOTIFY atvPrincipalChanged FINAL) // mainActivity
    Q_PROPERTY(QString nomeFantasia READ nomeFantasia NOTIFY nomeFantasiaChanged FINAL) // alias
    Q_PROPERTY(QString status READ status NOTIFY statusChanged FINAL)                   // status
    Q_PROPERTY(QString telefone READ telefone NOTIFY telefoneChanged FINAL)             // phones

    // carregamento e erro perfumaria para o senhor esquilo frontend
    Q_PROPERTY(bool loading READ loading NOTIFY loadingChanged FINAL)
    Q_PROPERTY(QString erro READ erro NOTIFY erroOcorrido FINAL)

public:
    explicit CNPJhandler(QObject *parent = nullptr);

    // get e set CNPJ
    QString cnpj() const;
    void setCnpj(const QString &valor);

    // buscas meu jesus do ceu
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

signals:
    // notificar que as coisas aconteceram
    void cnpjChanged();

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

    void loadingChanged();
    void erroOcorrido(const QString &mensagem);

private slots:
    // função do treco de requisitar API padrão do QT sei la como funciona essa porra
    void onReplyFinished(QNetworkReply *reply);

private:
    // armazenar valores
    void setRazaoSocial(const QString &valor);
    void setRua(const QString &valor);
    void setNum(const QString &valor);
    void setBairro(const QString &valor);
    void setCep(const QString &valor);
    void setCidade(const QString &valor);
    void setEstado(const QString &valor);
    void setAtvPrincipal(const QString &valor);
    void setNomeFantasia(const QString &valor);
    void setStatus(const QString &valor);
    void setTelefone(const QString &valor);

    void setLoading(bool valor);
    void setErro(const QString &error);

    // variáveis pra armazenar cada coisa
    // IMPLEMENTAR: jeito de alterar cada valor manualmente
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
