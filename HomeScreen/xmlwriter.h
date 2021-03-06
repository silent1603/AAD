#ifndef XMLWRITER_H
#define XMLWRITER_H
#include <QtXml>
#include <QFile>
#include "applicationsmodel.h"

class XmlWriter
{
public:
    XmlWriter(QString fileName, ApplicationsModel &model);
private:
    QString convertToStringID(int id);
};

#endif // XMLWRITER_H
