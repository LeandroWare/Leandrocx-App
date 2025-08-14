#include "cnpjhandler.h"
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QUrlQuery>

CNPJhandler::CNPJhandler(QObject *parent) : QObject(parent), m_nam(new QNetworkAccessManager(this)){
    connect(m_nam, &QNetworkAccessManager::finished, this, &CNPJhandler::onReplyFinished);
}

// get (basicamente igual o contador do LeandroCLicker)
QList<QString> CNPJhandler::cnpjData() const{ return m_cnpjData; }
QString CNPJhandler::cnpj() const{return m_cnpj;}
QString CNPJhandler::razaoSocial() const{return m_razaoSocial;}
QString CNPJhandler::rua() const{return m_rua;}
QString CNPJhandler::num() const{return m_num;}
QString CNPJhandler::bairro() const{return m_bairro;}
QString CNPJhandler::cep() const{return m_cep;}
QString CNPJhandler::cidade() const{return m_cidade;}
QString CNPJhandler::estado() const{return m_estado;}
QString CNPJhandler::atvPrincipal() const{return m_atvPrincipal;}
QString CNPJhandler::nomeFantasia() const{return m_nomeFantasia;}
QString CNPJhandler::status() const{return m_status;}
QString CNPJhandler::telefone() const{return m_telefone;}

bool CNPJhandler::loading() const{return m_loading;}
QString CNPJhandler::erro() const{return m_erro;}

// set (basicamente igual o contador do LeandroCLicker)
void CNPJhandler::setCnpj(const QString &valor){
    if(m_cnpj != valor){
        m_cnpj = valor;

        emit cnpjChanged();
    }
}
void CNPJhandler::setRazaoSocial(const QString &valor) {
    if (m_razaoSocial != valor) {
        m_razaoSocial = valor;

        emit razaoSocialChanged();
    }
}
void CNPJhandler::setRua(const QString &valor) {
    if (m_rua != valor) {
        m_rua = valor;

        emit ruaChanged();
    }
}
void CNPJhandler::setNum(const QString &valor) {
    if (m_num != valor) {
        m_num = valor;

        emit numChanged();
    }
}
void CNPJhandler::setBairro(const QString &valor) {
    if (m_bairro != valor) {
        m_bairro = valor;

        emit bairroChanged();
    }
}
void CNPJhandler::setCep(const QString &valor) {
    if (m_cep != valor) {
        m_cep = valor;

        emit cepChanged();
    }
}
void CNPJhandler::setCidade(const QString &valor) {
    if (m_cidade != valor) {
        m_cidade = valor;

        emit cidadeChanged();
    }
}
void CNPJhandler::setEstado(const QString &valor) {
    if (m_estado != valor) {
        m_estado = valor;

        emit estadoChanged();
    }
}
void CNPJhandler::setAtvPrincipal(const QString &valor) {
    if (m_atvPrincipal != valor) {
        m_atvPrincipal = valor;

        emit atvPrincipalChanged();
    }
}
void CNPJhandler::setNomeFantasia(const QString &valor) {
    if (m_nomeFantasia != valor) {
        m_nomeFantasia = valor;

        emit nomeFantasiaChanged();
    }
}
void CNPJhandler::setStatus(const QString &valor) {
    if (m_status != valor) {
        m_status = valor;

        emit statusChanged();
    }
}
void CNPJhandler::setTelefone(const QString &valor) {
    if (m_telefone != valor) {
        m_telefone = valor;

        emit telefoneChanged();
    }
}
void CNPJhandler::setLoading(bool valor) {
    if (m_loading != valor) {
        m_loading = valor;
        emit loadingChanged(valor);
    }
}
void CNPJhandler::setErro(const QString &error) {
    if (m_erro != error) {
        m_erro = error;
        emit erroOcorrido(error);
    }
}
void CNPJhandler::setCnpjData() {
    m_cnpjData.clear();
    m_cnpjData.append(m_razaoSocial);
    m_cnpjData.append(m_cnpj);
    m_cnpjData.append(m_rua);
    m_cnpjData.append(m_num);
    m_cnpjData.append(m_bairro);
    m_cnpjData.append(m_cep);
    m_cnpjData.append(m_cidade);
    m_cnpjData.append(m_estado);

    qDebug() << "CNPJ DATA EMITTED";
    for (auto i : m_cnpjData) {
        qDebug() << i;
    }
    emit cnpjDataChanged(m_cnpjData);
}

// requisitar dados da API e esperar fielmente uma resposta
void CNPJhandler::fetch(const QString &cnpj) {
    // esquilo bota uma animação de loading la no treco
    setLoading(true);
    setErro("");

    // (des)formatando o cnpj
    QString cnpjLimpo = cnpj;
    static const QRegularExpression pontuacao("[^\\d]");
    cnpjLimpo.remove(pontuacao);
    setCnpj(cnpj);

    // mandando pra API
    QUrl url(QStringLiteral("https://open.cnpja.com/office/%1").arg(cnpjLimpo));
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::UserAgentHeader, "QtApp");

    m_nam->get(request);
}

void CNPJhandler::updateCnpjData() {
    setCnpjData();
}

void CNPJhandler::onReplyFinished(QNetworkReply *reply) {
    setLoading(false);

    if (reply->error() != QNetworkReply::NoError) {
        setErro("Erro: " + reply->errorString());
        reply->deleteLater();
        return;
    }

    const QByteArray data = reply->readAll();
    const QJsonDocument doc = QJsonDocument::fromJson(data);

    if (!doc.isObject()) {
        setErro("Resposta inválida da API");
        reply->deleteLater();
        return;
    }

    // objetos dentro do principal onde tão as info
    const QJsonObject obj = doc.object();
    auto company = obj.value("company").toObject();
    auto address = obj.value("address").toObject();
    auto status = obj.value("status").toObject();
    auto mainAct = obj.value("mainActivity").toObject();
    auto phones = obj.value("phones").toArray()[0].toObject();

    // catando informações do JSON
    setRazaoSocial(company.value("name").toString());
    setRua(address.value("street").toString());
    setNum(address.value("number").toString());
    setBairro(address.value("district").toString());
    setCep(address.value("zip").toString());
    setCidade(address.value("city").toString());
    setEstado(address.value("state").toString());
    setAtvPrincipal(mainAct.value("text").toString());
    setNomeFantasia(obj.value("alias").toString());
    setStatus(status.value("text").toString());
    setTelefone(phones.value("number").toString());

    //setCnpjData();

    reply->deleteLater();

    qDebug() << "CNPJ: " << m_cnpj;
    qDebug() << "Razão Social: " << m_razaoSocial;
    qDebug() << "Nome Fantasia: " << m_nomeFantasia;
    qDebug() << "Status: " << m_status;
    qDebug() << "Atividade Principal: " << m_atvPrincipal;
    qDebug() << "Endereço: " << m_rua << m_num << m_bairro << m_cidade <<
    m_estado << m_cep; qDebug() << "Telefone: " << m_telefone;
}
