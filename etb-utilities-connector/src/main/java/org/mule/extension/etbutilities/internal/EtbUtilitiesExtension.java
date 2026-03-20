package org.mule.extension.etbutilities.internal;
import org.mule.runtime.extension.api.annotation.Extension;
import org.mule.runtime.extension.api.annotation.Configurations;
import org.mule.runtime.extension.api.annotation.dsl.xml.Xml;
import org.mule.sdk.api.annotation.JavaVersionSupport;
import org.mule.sdk.api.meta.JavaVersion;


/**
 * This is the main class of an extension, is the entry point from which configurations, connection providers, operations
 * and sources are going to be declared.
 */
@Xml(prefix = "etbutilities")
@Extension(name = "EtbUtilities")
@JavaVersionSupport(JavaVersion.JAVA_17)
@Configurations(EtbUtilitiesConfiguration.class)
public class EtbUtilitiesExtension {

}