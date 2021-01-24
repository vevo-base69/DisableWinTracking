$releaseVersion='3.2.4'
$pyVersion='cp39'

# Create virtual env if needed
if(!(test-path env))
{
  py -m venv env
}

.\env\Scripts\activate

pip install -r requirements.txt

pyinstaller --onefile dwt_about.py dwt_util.py dwt.py

Copy-Item COPYING dist\
Copy-Item COPYING.LESSER dist\
Copy-Item README.md dist\

Compress-Archive -Force -Path dist\* -DestinationPath "public\dwt-$releaseVersion-$pyVersion-win_x86.zip"