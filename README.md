# Computer Applications in Chemical Engineering Laboratory [Semester 3.1]

## Pre-requisites

- Local installation of MATLAB (R2020b or later)
- Local installation of Python (3.10 or later)
- Symlinked/available matlab executable in the system path
  ```bash
  # use this to check if the matlab executable is available in the system path
  which matlab
  ```

## Development

1. Clone this repository to your local machine and navigate to it.
   ```bash
   git clone [insert repository URL here]
   cd computer-applications-in-chem-e
   ```
1. Create a virtual environment and activate it.
   ```bash
   python -m venv .venv
   source .venv/bin/activate
   ```
1. Install the required dependencies.
   ```bash
   pip install -r requirements.txt
   ```
1. Spin up a Jupyter Lab server.
   ```bash
   jupyter lab
   ```
1. Open any existing notebook and run the first cell. This will ask you for your license. Select the option to run it locally.
1. [VSCODE] Open the notebook in VSCode, head over to existing Jupyter server, and enter the URL of the server you spun up. The password is the token in the url. Connect to that kernel and run the notebook cells.
