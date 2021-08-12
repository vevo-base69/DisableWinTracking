$version = Select-String -Path .\dwt_about.py -Pattern '^__version__ = "([0-9.]+)"$' | % { "$($_.matches.groups[1])" }

$pyVersion='cp39'

# Setup
# Create virtual env if needed
if(!(test-path env))
{
  py -m venv env
}

.\env\Scripts\activate

pip install -r requirements.txt

# Clean
Remove-Item -Recurse dist\*
Remove-Item -Recurse public\*

# Build
#pyinstaller --onefile dwt_about.py dwt_util.py dwt.py --icon=main.ico
pyinstaller dwt.spec

# Package
Copy-Item COPYING dist\
Copy-Item COPYING.LESSER dist\
Copy-Item README.md dist\

Compress-Archive -Force -Path dist\* -DestinationPath "public\dwt-$version-$pyVersion-win_x86.zip"