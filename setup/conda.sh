#!/bin/bash

# Installs pyenv, python, and pips

. "$HOME/.dotfiles/bin/reports"

set -e
trap on_error SIGTERM

install_miniconda() {
  if [ ! -d "$HOME/.config/miniconda3" ]; then

    info "creating ~/.config/miniconda3..."
    mkdir -p ~/.config/miniconda3

    info "downloading Miniconda3-latest-MacOSX-arm64.sh..."
    curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/.config/miniconda3/miniconda.sh

    info "running miniconda.sh..."
    bash ~/.config/miniconda3/miniconda.sh -b -u -p ~/.config/miniconda3
  fi

  if [ -d "$HOME/.config/miniconda3" ]; then
    source "$HOME/.config/miniconda3/etc/profile.d/conda.sh"

    if ! conda env list | grep -q "^myenv "; then
      info "conda create myenv env 3.13.5 in miniconda..."
      conda create -y -n myenv python=3.13.5
    else
      info "conda myenv environment already exists, skipping creation..."

      info "conda activate myenv environment..."
      conda activate myenv

      info "conda install packages in myenv environment..."
      # conda install -c apple tensorflow-deps
      # conda install -c conda-forge pybind11
      for pkg in matplotlib jupyterlab seaborn opencv joblib pytables; do
        if conda list "$pkg" | grep -q "^$pkg"; then
          info "conda package '$pkg' already installed, skipping..."
        else
          conda install -y "$pkg"
        fi
      done

      packages=(
        aiohappyeyeballs aiohttp aiosignal annotated-types anyio attrs black Brotli cachetools certifi cffi charset-normalizer
        click colorama contourpy cryptography cssselect2 cycler debugpy Deprecated distro et-xmlfile fake-useragent filelock
        fonttools frozenlist fsspec google-api-core google-api-python-client google-auth google-auth-httplib2
        google-auth-oauthlib googleapis-common-protos h11 html5lib httpcore httplib2 httpx huggingface-hub idna ipaddress
        isort Jinja2 jiter kiwisolver mail-parser Markdown MarkupSafe matplotlib mpmath multidict mypy-extensions
        networkx numpy oauthlib openai openpyxl outcome packaging pandas pathspec pdfkit pillow platformdirs proto-plus
        protobuf pyasn1 pyasn1_modules pycparser pydantic pydantic_core pydyf PyGithub PyJWT PyNaCl pypandoc pyparsing pyphen
        PySocks python-dateutil pytz PyYAML regex requests requests-oauthlib rsa safetensors schedule scipy selenium
        setuptools six sniffio sortedcontainers sympy tinycss2 tokenizers torch tqdm transformers trio trio-websocket
        typing_extensions tzdata uritemplate urllib3 weasyprint webencodings websocket-client wrapt wsproto yarl zopfli
      )

      for package in "${packages[@]}"; do
        if python -m pip show "$package" >/dev/null 2>&1; then
          info "conda pip package ($package) is already installed, skipping..."
        else
          info "conda installing pip package ($package)..."
          python -m pip install "$package"
        fi
      done

    fi
  else
    info "miniconda3 not found in ~/.config/miniconda3. Skipping conda environment setup..."
  fi
}

main() {
  install_miniconda "$*"
}

main "$*"
