# simanager/cli_tool.py
import argparse
import os
import re
import subprocess
import sys
import time


def generate_parser():
    parser = argparse.ArgumentParser(description="General Simulation Manager")

    # Create subparsers for each subcommand
    subparsers = parser.add_subparsers(title="Subcommands", dest="subcommand")

    # Subcommand: sshfs (mount)
    subparsers.add_parser("sshfs", help="Mount AFS and EOS folders via SSHFS")

    # Subcommand: update
    subparsers.add_parser("update", help="Update the repository")

    return parser


def confirm_execution(timeout):
    print("Are you sure you want to execute this command?")
    print(f"Press Enter to proceed or CTRL+C to cancel ({timeout} seconds timeout):")

    start_time = time.time()
    input_thread = sys.stdin.readline()
    elapsed_time = time.time() - start_time

    # If the user presses Enter or the timeout (in seconds) is reached, execute the command
    if not input_thread.strip() or elapsed_time >= timeout:
        return True
    else:
        return False


def main():
    parser = generate_parser()
    args = parser.parse_args()

    if args.subcommand == "sshfs":
        # mount AFS
        print("Mounting AFS...")
        subprocess.run(
            [
                "sshfs",
                "camontan@lxplus.cern.ch:/afs",
                "~/afs",
            ],
            check=True,
        )
        # mount EOS
        print("Mounting EOS...")
        subprocess.run(
            [
                "sshfs",
                "camontan@lxplus.cern.ch:/eos",
                "~/eos",
            ],
            check=True,
        )

    elif args.subcommand == "update":
        # get the path of this file
        this_file_path = os.path.abspath(__file__)

        # update the repository
        print("Updating the repository...")
        subprocess.run(
            [
                "git",
                "pull",
            ],
            check=True,
            cwd=os.path.dirname(this_file_path),
        )


if __name__ == "__main__":
    main()
