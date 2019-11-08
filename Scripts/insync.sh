function UpdateInsync_IgnoreRules {
    local ignoreRulesFile="$(Trim "$1")"
    local insyncDB="$(Trim "$2")"
    local ignoreRules=""


    if $(FileNotExists "$ignoreRulesFile"); then return; fi


    while IFS= read -r rule; do
    ignoreRules="$ignoreRules""$rule""\n"
    done <<< "$(SmlCutLines_Empty "$(ReadFile "$ignoreRulesFile")")"
    ignoreRules="\"${ignoreRules: 0:-2}\""


    sqlite3 "$insyncDB" "UPDATE sync_prefs SET encoded_value='$ignoreRules' WHERE key=\"IGNORE_RULES\""
}
