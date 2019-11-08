function GetChromiumVersion { GetVersion "$(chromium --version)"; }
function GetChromeVersion { GetVersion "$(chrome --version)"; }
function GetChromeDriverVersion { GetVersion "$(chromedriver --version)"; }


function InstallChromeDriver { UpdateChromeDriver "$@"; }
function UpdateChromeDriver {
    local tmpFolder="$(TempFolder)"
    local chromeDriver="/usr/bin/chromedriver"

    local chromeLocalVersion="$(GetVersion_Major "$(GetChromiumVersion)")"
    local chVersion="$(GetVersion "$(FindLink "https://chromedriver.chromium.org/downloads" "https://chromedriver.storage.googleapis.com/index.html?path=$chromeLocalVersion.*")")"
    local chLink="https://chromedriver.storage.googleapis.com/$chVersion/chromedriver_linux64.zip"


    if $(UrlNotExists "$chLink"); then
        chVersion="2.34"
        chLink="https://chromedriver.storage.googleapis.com/$chVersion/chromedriver_linux64.zip"

        if $(UrlNotExists "$chLink"); then return; fi
    fi
    sudo rm -rf "$chromeDriver"


    wget -P "$tmpFolder" "$chLink"
    sudo su -c "unzip \"$tmpFolder/chromedriver_linux64.zip\" -d \"/usr/bin/\""

    sudo chown root:root "$chromeDriver"
    sudo chmod +x "$chromeDriver"
}
