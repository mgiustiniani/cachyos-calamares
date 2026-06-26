/* === This file is part of Calamares - <https://calamares.io> ===
 *
 *   SPDX-FileCopyrightText: 2026 Mario Giustiniani <mariogiustiniani@gmail.com>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 *
 */

#ifndef SERVERVIEWSTEP_H
#define SERVERVIEWSTEP_H

#include "DllMacro.h"
#include "locale/TranslatableConfiguration.h"
#include "utils/PluginFactory.h"
#include "utils/System.h"
#include "utils/Variant.h"
#include "viewpages/QmlViewStep.h"

class PLUGINDLLEXPORT ServerViewStep : public Calamares::QmlViewStep
{
    Q_OBJECT

public:
    ServerViewStep( QObject* parent = nullptr );
    ~ServerViewStep() override;

    QString prettyName() const override;

    void setConfigurationMap( const QVariantMap& configurationMap ) override;

private:
    Calamares::Locale::TranslatedString* m_serverName;
};

CALAMARES_PLUGIN_FACTORY_DECLARATION( ServerViewStepFactory )

#endif
