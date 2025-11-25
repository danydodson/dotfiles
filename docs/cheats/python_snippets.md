# --- // SHEBANGS:
```bash
#!/usr/bin/env python3
#!/usr/bin/python3
```

# --- // Auto_escalate:
```python
if os.geteuid() != 0:
    try:
        print("Attempting to escalate privileges...")
        subprocess.check_call(['sudo', sys.executable] + sys.argv)
        sys.exit()
    except subprocess.CalledProcessError as e:
        print(f"Error escalating privileges: {e}")
        sys.exit(e.returncode)
```

# --- // CLEANING_FUNCTION:
```bash
clean() {
	rm -rf __pycache__ wayfire/__pycache__ wayfire.egg-info build/
}

clean 
pip uninstall wayfire
python3 -m pip install .
clean
```
