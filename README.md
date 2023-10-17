# Autonomous (Visual Regression) Testing with Robot Framework

This repository consist is compilation of various examples of features which
helps to bring test automation into testing autonomy via introducing visual testing.

All examples and prototypes are based on [Robot Framework](https://robotframework.org/).

## Install Robot Framework

```shell

# Create python environment
python3 -m venv .venv

# Activate python environment
source .venv/bin/activate

# Install Robot Framework (with all dependencies)
pip install -r requirements.txt

# Initialize Browser library
rfbrowser init

# Set up credentials for Wopee examples
# Optional - for advanced users, Wopee team to provide more detail instructions
source set-credentials.sh

# Install Wopee Assistant
gh release download --repo autonomous-testing/wopee.rf --pattern '*.whl'
pip3 install wopee_rf*.whl

```

Some more details about the [installation of Browser library can be found here](https://robotframework-browser.org/#installation)

## Set up OpenAI (for form filling demo)

OpenAI token is required to use OpenAI API. You can get it by creating an account
at [OpenAI platform](https://platform.openai.com/).

Create [API key here](https://platform.openai.com/account/api-keys) and export
it as environment variable:

```shell
export OPENAI_API_KEY=Bearer <your key>
```

## Folder structure

```shell
WOPEE-RF-WORKSHOP
└── .github/workflows           # Folder with CI for github actions
└── baselines                   # Pictures stored to demo how comparison works
└── examples                    # Folder with example how to introduce autnomous testing into RF
│    └── 01-Console             # Autonomous bot collectign warning and errors
│    └── 02-Forms-fill          # Demo for filling forms
│    └── 03-WatchUI             # Demo using open source library WatchUI to compare pisctures
│    └── 04-Tesseract           # Not implemented yet - just idea for future
│    └── 05-Classification      # Demo to explain more dynamic visual validation
│    └── 06-Wopee-assitant      # Assistant - easier to mantain baselines, track results, and
│    │                          # work in teams
│    └── 07-Wopee-bot           # Bot - Visual testing without writing code
└── resources                   # Folder with suporting keywords across examples
└── README.MD                   # Here you are :-)
```
