#include "xmlwriter.h"
#include <QtDebug>
XmlWriter::XmlWriter(QString fileName, ApplicationsModel &model)
{
    QFile f(PROJECT_PATH + fileName);
    if (!f.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug() << f.errorString() << '\n';
        // Error while loading file
        return;
    }
    // Set data into the QDomDocument before processing
    QDomDocument m_xmlDoc;

    QDomElement root = m_xmlDoc.createElement("APPLICATIONS");
    m_xmlDoc.appendChild(root);
    qDebug() << model.rowCount() << '\n';
    for(int i = 0 ; i < model.rowCount(); i++)
    {
        ApplicationItem app = model.getApplication(i);
        QDomElement tagName = m_xmlDoc.createElement("APP");
        tagName.setAttribute("ID", convertToStringID(i));

        QDomElement tagTitle = m_xmlDoc.createElement("TITLE");
        QDomText txtTitle = m_xmlDoc.createTextNode(app.title());
        tagTitle.appendChild(txtTitle);
        tagName.appendChild(tagTitle);

        QDomElement tagURL = m_xmlDoc.createElement("URL");
        QDomText txtURL = m_xmlDoc.createTextNode(app.url());
        tagURL.appendChild(txtURL);
        tagName.appendChild(tagURL);

        QDomElement tagPath = m_xmlDoc.createElement("ICON_PATH");
        QDomText txtPath = m_xmlDoc.createTextNode(app.iconPath());
        tagPath.appendChild(txtPath);
        tagName.appendChild(tagPath);

        root.appendChild(tagName);
    }
    QTextStream stream (&f);
    stream << m_xmlDoc.toString();
    f.close();
}

QString XmlWriter::convertToStringID(int id)
{
    id++;
    if (id < 10) return "00" + QString::number(id);
    if (id < 100) return "0" + QString::number(id);
    return QString::number(id);
}

