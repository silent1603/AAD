#include "appconfiginfo.h"

AppConfig::AppConfig(QSize device,QObject *parent) : QObject(parent)
{
    screen_size.setting_size = QSize(1920,1200);
    screen_size.device_size = device;
}

qreal AppConfig::getWRatio()
{
    return (qreal)screen_size.device_size.width()/screen_size.setting_size.width();
}

qreal AppConfig::getHRatio()
{
     return (qreal)screen_size.device_size.height()/screen_size.setting_size.height();
}

qreal AppConfig::getWSize()
{
    return (qreal)screen_size.setting_size.width();
}

qreal AppConfig::getHSize()
{
    return (qreal)screen_size.setting_size.height();
}

qreal AppConfig::getWDSize()
{
    return (qreal)screen_size.device_size.width();
}

qreal AppConfig::getHDSize()
{
    return (qreal)screen_size.setting_size.height();
}
