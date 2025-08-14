#include "modelhandler.h"

// Constructor
ModelHandler::ModelHandler(QObject *parent)
    : QObject{parent}
{
    Py_Initialize();
}

ModelHandler::~ModelHandler() {
    Py_Finalize();
}

std::string ModelHandler::getLeandrocxModelsPath() {
    char appdataPath[MAX_PATH];
    HRESULT hr = SHGetFolderPathA(NULL, CSIDL_APPDATA, NULL, 0, appdataPath);
    if (FAILED(hr)) {
        return std::string(); // não conseguiu obter AppData
    }

    fs::path appdata(appdataPath);
    fs::path leandro = appdata / "LEANDROCX";
    fs::path models = leandro / "MODELS";

    if (fs::exists(leandro) && fs::is_directory(leandro)
        && fs::exists(models) && fs::is_directory(models)) {
        return models.string(); // caminho absoluto para ...\MODELS
    }

    return std::string(); // não existe a(s) pasta(s)
}

std::string ModelHandler::getLeandrocxPath() {
    char appdataPath[MAX_PATH];
    HRESULT hr = SHGetFolderPathA(NULL, CSIDL_APPDATA, NULL, 0, appdataPath);
    if (FAILED(hr)) {
        return std::string(); // não conseguiu obter AppData
    }

    fs::path appdata(appdataPath);
    fs::path leandro = appdata / "LEANDROCX";

    if (fs::exists(leandro) && fs::is_directory(leandro)){
        return leandro.string(); // caminho absoluto para ...\MODELS
    }

    return std::string(); // não existe a(s) pasta(s)
}

std::string ModelHandler::getUserPath() {
    char userDocsPath[MAX_PATH];
    HRESULT hr = SHGetFolderPathA(NULL, CSIDL_MYDOCUMENTS, NULL, 0, userDocsPath);
    if (FAILED(hr)) {
        return std::string(); // não conseguiu obter Documents
    }

    fs::path userDocs(userDocsPath);
    fs::path leandro = userDocs / "LEANDROCX";

    if (fs::exists(leandro) && fs::is_directory(leandro)) {
        return leandro.string(); // caminho absoluto para ...\MODELS
    }
    else {
        fs::create_directory(leandro);
        return leandro.string();
    }

    return std::string(); // não existe a(s) pasta(s)
}

void ModelHandler::CreatePassiveModel(){

    //Obtém __main__ e seu dicionário global
    PyObject* mainMod = PyImport_AddModule("__main__"); // borrowed ref
    if (!mainMod) {
        qDebug() << "Erro: não foi possível obter __main__";
        Py_Finalize();
        return;
    }
    PyObject* globals = PyModule_GetDict(mainMod);

    // Transformar cnpjData de QList -> python list
    PyObject* pyCnpjData = PyList_New(0);
    for (auto i : this->cnpjData) {
        PyObject* itemStr = PyUnicode_FromString(i.toUtf8().constData());
        PyList_Append(pyCnpjData, itemStr);
    }

    //Injeta cnpjData em globals
    if (PyDict_SetItemString(globals, "cnpjData", pyCnpjData) != 0) {
        qDebug() << "Aviso: não foi possível setar cnpjData no globals";
    }
    Py_DECREF(pyCnpjData);

    
    ModelHandler::ExecutePythonScript("createPassiveModel");
}

void ModelHandler::exportDocument(QString fileName) {

    std::string userPath = ModelHandler::getUserPath();

    //Obtém __main__ e seu dicionário global
    PyObject* mainMod = PyImport_AddModule("__main__"); // borrowed ref
    if (!mainMod) {
        qDebug() << "Erro: não foi possível obter __main__";
        Py_Finalize();
        return;
    }
    PyObject* globals = PyModule_GetDict(mainMod);

    PyObject* pyfileName = PyUnicode_FromString(fileName.toStdString().c_str());

    //Injeta fileName em globals
    if (PyDict_SetItemString(globals, "fileName", pyfileName) != 0) {
        qDebug() << "Aviso: não foi possível setar fileName no globals";
    }
    Py_DECREF(pyfileName);

    //Injeta userPath em globals
    PyObject* pyUserPath = PyUnicode_FromString(userPath.c_str());
    if (PyDict_SetItemString(globals, "userPath", pyUserPath) != 0) {
        qDebug() << "Aviso: não foi possível setar userPath no globals";
    }
    Py_DECREF(pyUserPath);

    ModelHandler::ExecutePythonScript("exportDocument");
}

void ModelHandler::ExecutePythonScript(QString scriptName) {
    qDebug() << "DEU CERTO POHAAAA";

    std::string cvtScriptName = scriptName.toStdString();
    std::string modelsPath = ModelHandler::getLeandrocxModelsPath();
    std::string leandrocxPath = ModelHandler::getLeandrocxPath() + "\\" + cvtScriptName +".py";
    qDebug() << modelsPath;
    qDebug() << leandrocxPath;

    //Obtém __main__ e seu dicionário global
    PyObject* mainMod = PyImport_AddModule("__main__"); // borrowed ref
    if (!mainMod) {
        qDebug() << "Erro: não foi possível obter __main__";
        Py_Finalize();
        return;
    }
    PyObject* globals = PyModule_GetDict(mainMod);

    //Injeta src_files_path em globals
    PyObject* pyModels = PyUnicode_FromString(modelsPath.c_str()); // new ref
    if (!pyModels) {
        qDebug() << "Erro: falha ao criar PyUnicode para src_files_path";
        Py_Finalize();
        return;
    }
    if (PyDict_SetItemString(globals, "src_files_path", pyModels) != 0) {
        qDebug() << "Aviso: não foi possível setar src_files_path no globals";
    }
    Py_DECREF(pyModels);

    //Injeta script_path em globals (para usar com runpy.run_path)
    PyObject* pyScript = PyUnicode_FromString(leandrocxPath.c_str()); // new ref
    if (!pyScript) {
        qDebug() << "Erro: falha ao criar PyUnicode para script_path";
        Py_Finalize();
        return;
    }
    if (PyDict_SetItemString(globals, "script_path", pyScript) != 0) {
        qDebug() << "Aviso: não foi possível setar script_path no globals";
    }
    Py_DECREF(pyScript);

    //Executa main.py como se fosse `python main.py` (garante __main__ e loader corretos)
    const char* runCmd =
        "import runpy\n"
        "runpy.run_path(script_path, init_globals=globals(), run_name='__main__')\n";
    int res = PyRun_SimpleString(runCmd);
    if (res != 0) {
        qDebug() << "Python retornou erro ao executar o script (PyRun_SimpleString retornou != 0).";
    }
}

void ModelHandler::updateCnpjData(QList<QString> cnpjData) {
    qDebug() << "KASJDLKSDJSALDLSADMSAKFJAKFASLDSA";

    this->cnpjData = cnpjData;
    qDebug() << cnpjData;

    for (auto i : this->cnpjData) {
        qDebug() << i;
    }
}