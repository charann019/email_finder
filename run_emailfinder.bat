import subprocess
import time

# Read domains from input.txt
with open('input.txt', 'r') as file:
    domains = [line.strip() for line in file if line.strip()]

# Create a temporary batch script to process domains
with open('temp_run_emailfinder.bat', 'w') as batch_file:
    batch_file.write('@echo off\n')
    batch_file.write('setlocal enabledelayedexpansion\n')
    for domain in domains:
        batch_file.write(f'echo Processing domain: {domain}\n')
        batch_file.write(f'emailfinder -d {domain}\n')
        batch_file.write('timeout /t 5 /nobreak\n')
    batch_file.write('echo All domains processed.\n')
    batch_file.write('endlocal\n')

# Execute the temporary batch script and capture the output
with open('output.txt', 'w') as outfile:
    subprocess.run(['cmd.exe', '/c', 'temp_run_emailfinder.bat'], stdout=outfile, text=True)

# Optional: Remove the temporary batch file if no longer needed
# os.remove('temp_run_emailfinder.bat')

print("Processing completed. Check output.txt for results.")
