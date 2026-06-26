/* === This file is part of Calamares - <https://calamares.io> ===
 *
 *   SPDX-FileCopyrightText: 2026 Mario Giustiniani <mariogiustiniani@gmail.com>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 *
 */

#include "ServerViewStep.h"

#include <QVariant>

ServerViewStep::ServerViewStep( QObject* parent )
    : Calamares::QmlViewStep( parent )
{
}

ServerViewStep::~ServerViewStep() {}

QString
ServerViewStep::prettyName() const
{
    return m_serverName ? m_serverName->get() : tr( "Server Setup" );
}

void
ServerViewStep::setConfigurationMap( const QVariantMap& configurationMap )
{
    bool qmlLabel_ok = false;
    auto qmlLabel = Calamares::getSubMap( configurationMap, "qmlLabel", qmlLabel_ok );

    if ( qmlLabel.contains( "server" ) )
    {
        m_serverName = new Calamares::Locale::TranslatedString( qmlLabel, "server" );
    }

    Calamares::QmlViewStep::setConfigurationMap( configurationMap );  // call parent implementation last
}

CALAMARES_PLUGIN_FACTORY_DEFINITION( ServerViewStepFactory, registerPlugin< ServerViewStep >(); )
