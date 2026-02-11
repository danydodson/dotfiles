# Cheater File: Python.md

## Building without Make

```python
cd <dupeGuru directory>
python3 -m venv --system-site-packages ./env
source ./env/bin/activate
pip install -r requirements.txt
python build.py
python run.py
```

---

## Confirm Syntax

```python
python -m py_compile vacuum.py
```

---

## Official Poetry Install

```bash
curl -sSL https://install.python-poetry.org | python3 -
export PATH="$HOME/.local/bin:$PATH"
poetry --version
```

---

## Poetry Project Init Workflow

```bash
cd /project/directory
poetry init
poetry add dependencies
poetry shell
python3 yourapp.py
```

---

## Update Python PIP

```python
1. General Setup:
python3 -m pip install --upgrade pip setuptools wheel

2. Safe way:
python3 -m pip install -U $(python3 -m pip list outdated 2> /dev/null | grep -v 'Version' | grep -v '\-\-\-\-\-\-' | awk '{printf $1 " " }' && echo)

3. Overwrite method:
python3 -m pip install --exists-action w --force-reinstall -U $(python3 -m pip list outdated 2> /dev/null | grep -v 'Version' | grep -v '\-\-\-\-\-\-' | awk '{printf $1 " " }' && echo)

4. Pythonic method:
import subprocess
outdated_packages = subprocess.check_output(['python3', '-m', 'pip', 'list', 'outdated'],
stderr=subprocess.DEVNULL).decode().splitlines()
for package in outdated_packages:
    package_name = package.split()[0]
    subprocess.call(['python3', '-m', 'pip', 'install', '--break-system-packages', '-U', package_name])
```

---

## Install PIP with Python

```python
python -m ensurepip --upgrade
```

---

## General Update

```python
python3 -m pip install --upgrade pip setuptools wheel
```
