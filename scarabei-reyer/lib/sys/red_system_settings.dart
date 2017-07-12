library com.jfixby.scarabei.red.sys;

import 'java.dart';

class RedSystemSettings with com_jfixby_scarabei_api_sys_settings_SystemSettingsComponent
{
    com_jfixby_scarabei_api_sys_settings_ExecutionMode execution_mode = ExecutionMode_.EARLY_DEVELOPMENT;
    com_jfixby_scarabei_api_collections_Map<String, Boolean> flags = Collections.newMap();
    com_jfixby_scarabei_api_collections_Map<String, Long> longs = Collections.newMap();
    com_jfixby_scarabei_api_collections_Map<String, String> strings = Collections.newMap();
    com_jfixby_scarabei_api_collections_Map<String, ID> assets = Collections.newMap();

    void printSystemParameters()
    {
        L.d("---[SystemSettings]-----------------------------------");
        L.d("ExecutionMode", this.execution_mode);
        this.flags.print("   Flags  ");
        this.longs.print("   Longs  ");
        this.strings.print("   Strings");
        this.assets.print("   Assets ");
        L.d("---[SystemSettings-END]-----------------------------------");
    }

    com_jfixby_scarabei_api_collections_Mapping<String, String> listAllSettings()
    {
        com_jfixby_scarabei_api_collections_Map<String, String> params = Collections.newMap();
        params.put("ExecutionMode", "" + this.execution_mode);
        collect("flag", params, this.flags);
        collect("long", params, this.longs);
        collect("string", params, this.strings);
        collect("assets", params, this.assets);
        return params;
    }

    static void collect(String string, com_jfixby_scarabei_api_collections_Map<String, String> params, com_jfixby_scarabei_api_collections_Map<String, ?> input)
    {
        for (String flagName in input.keys()) {
            String key = ((string + ".") + flagName);
            String value = ("" + input.get(flagName));
            params.put(key, value);
        }
    }

    void setExecutionMode(com_jfixby_scarabei_api_sys_settings_ExecutionMode executionMode)
    {
        Debug.checkNull("ExecutionMode", executionMode);
        this.execution_mode = executionMode;
    }

    void setFlag(String flag_name, bool flag_value)
    {
        this.flags.put(flag_name, flag_value);
    }

    bool getFlag(String flag_name)
    {
        Boolean value = this.flags.get(flag_name);
        if (value == null) {
            L.d("Flag not found", flag_name);
            return false;
        }
        return value;
    }

    String getStringParameter(String parameter_name)
    {
        String value = this.strings.get(parameter_name);
        if (value == null) {
            L.d("Parameter not found", parameter_name);
            return null;
        }
        return value;
    }

    void setStringParameter(String parameter_name, String parameter_value)
    {
        this.strings.put(parameter_name, parameter_value);
    }

    void setSystemAssetID(String parameter_name, com_jfixby_scarabei_api_assets_ID parameter_value)
    {
        this.assets.put(parameter_name, parameter_value);
    }

    com_jfixby_scarabei_api_assets_ID getSystemAssetID(String parameter_name)
    {
        com_jfixby_scarabei_api_assets_ID value = this.assets.get(parameter_name);
        if (value == null) {
            L.d("Parameter not found", parameter_name);
            return null;
        }
        return value;
    }

    bool executionModeCovers(com_jfixby_scarabei_api_sys_settings_ExecutionMode execution_mode)
    {
        return this.execution_mode.covers(execution_mode);
    }

    com_jfixby_scarabei_api_sys_settings_ExecutionMode getExecutionMode()
    {
        return this.execution_mode;
    }

    void setLongParameter(String parameterName, int parameterValue)
    {
        this.longs.put(parameterName, parameterValue);
    }

    int getLongParameter(String parameterName)
    {
        Long value = this.longs.get(parameterName);
        if (value == null) {
            L.d("Parameter not found", parameterName);
            return 0;
        }
        return value;
    }
}
