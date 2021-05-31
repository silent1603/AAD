#ifndef APPCONFIGINFO_H
#define APPCONFIGINFO_H

#include <QObject>
#include <QSize>
struct SreenSizeInfo
{
    QSize setting_size;
    QSize device_size;
};

class AppConfig : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qreal width_ratio READ getWRatio  NOTIFY sizeChanged)
    Q_PROPERTY(qreal height_ratio READ getHRatio  NOTIFY sizeChanged)
    Q_PROPERTY(qreal width_size READ getWSize NOTIFY sizeChanged)
    Q_PROPERTY(qreal height_size READ getHSize NOTIFY sizeChanged)
    Q_PROPERTY(qreal width_device_size READ getWDSize NOTIFY sizeChanged)
    Q_PROPERTY(qreal height_device_size READ getHDSize NOTIFY sizeChanged)
public:
    explicit AppConfig(QSize device,QObject *parent = nullptr);
    qreal getWRatio();
    qreal getHRatio();
    qreal getWSize();
    qreal getHSize();
    qreal getWDSize();
    qreal getHDSize();

signals:
    void sizeChanged();
public:
    SreenSizeInfo screen_size;
};

#endif // APPCONFIGINFO_H
