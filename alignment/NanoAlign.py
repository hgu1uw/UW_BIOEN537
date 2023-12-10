import subprocess
import gzip
import argparse

def setup_environment():
    """
    Sets up the environment by installing Java, Docker, and Nextflow.
    """
    def install_software(name, check_command, install_commands):
        """
        Helper function to install software if not already installed.
        """
        try:
            subprocess.run(check_command, stderr=subprocess.STDOUT, check=True)
            print(f"{name} is already installed.")
        except subprocess.CalledProcessError:
            print(f"Installing {name}...")
            for command in install_commands:
                subprocess.run(command, check=True)

    install_software(
        "Java", ["java", "-version"],
        [["apt-get", "update"], ["apt-get", "install", "-y", "default-jdk"]]
    )

    install_software(
        "Docker", ["docker", "--version"],
        [["curl", "-fsSL", "https://get.docker.com", "-o", "get-docker.sh"], ["sh", "get-docker.sh"]]
    )

    install_software(
        "Nextflow", ["nextflow", "-version"],
        [["curl", "-s", "https://get.nextflow.io", "|", "bash"]]
    )

"""
def read_fastq_gz(file_path):
    """
    #Reads and returns data from a gzip-compressed FASTQ file.
    """
    with gzip.open(file_path, 'rt') as file:
        data = file.read()
    return data

"""
def run_wf_tb_amr(fastq_data_path):
    """
    Runs the wf-tb-amr workflow using Nextflow with the specified FASTQ data path.
    """
    sample_sheet_path = fastq_data_path + '/sample_sheet.csv'
    command = [
        "nextflow",
        "run",
        "epi2me-labs/wf-tb-amr",
        "--fastq", fastq_data_path,
        "--sample_sheet", sample_sheet_path,
    ]
    subprocess.run(command, check=True)

def main():
    """
    Main function to execute the script.
    """
    parser = argparse.ArgumentParser(description='Process the data.')
    parser.add_argument('running_folder', help='Path to the dir with files')
    args = parser.parse_args()

    setup_environment()
    fastq_data_path = args.running_folder
    run_wf_tb_amr(fastq_data_path)

if __name__ == "__main__":
    main()
