release=$(cat /etc/os-release | grep NAME= | head -n 1 | cut -d '"' -f 2)
case "$release" in
  "Ubuntu")
    echo "Install for Ubuntu"
    sudo apt-get install pandoc texlive texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra
    curl -s -L -o ./eisvogel.tar.gz https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v2.4.0/Eisvogel-2.4.0.tar.gz
    tar -xzf ./eisvogel.tar.gz --one-top-level 2>/dev/null
    pandocDir=$(pandoc --version | grep "Default user data directory" | cut -d ":" -f 2 | cut -c 2-)
    if [ ! -d "$pandocDir]" ]; then
      mkdir -p "$pandocDir/templates"
    fi
    mv ./eisvogel/eisvogel.latex $pandocDir/templates/eisvogel.latex
    rm -rf ./eisvogel*
    echo "[OK] Use [pandoc ../example.md -o ./example.pdf --from markdown --template ~/.pandoc/templates/eisvogel.latex --listings && xdg-open example.pdf]"
    ;;
  "Debian")
    echo "Debian"
    ;;
  *)
    echo "Unknown OS - Exiting."
    exit
    ;;
esac    
