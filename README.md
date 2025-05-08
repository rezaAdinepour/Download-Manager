# Download Scheduler

A bash script to schedule downloads at a specific time with flexible link input, custom save paths, and detailed logging.

## Features

- ⏰ Schedule downloads for a specific time (HH:MM)
- 🔗 Support for multiple download links (unlimited count)
- 📂 Customizable download directory
- 📝 Detailed logging to a text file
- 💻 Both interactive and non-interactive modes
- 📊 Download success/failure statistics
- 🔔 Desktop notifications (Linux systems with notify-send)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/rezaAdinepour/Download-Scheduler.git
   cd Download-Scheduler
   ```
2. Make the script executable:
   ```bash
   chmod +x crazy_ds.sh
   ```

## Usage

### Basic Interactive Mode
```bash
./crazy_ds.sh
```
The script will prompt you for:
* Scheduled time (hour and minute)
* Download links (enter one per line, press Ctrl+D when done)
* Uses current directory for downloads and creates `download_log.txt`

### Advanced Command Line Options
```bash
./crazy_ds.sh [OPTIONS]
```

## Command Line Options

| Option               | Short Form | Description                                      | Example Usage                    |
|----------------------|------------|--------------------------------------------------|----------------------------------|
| `--help`             | `-h`       | Show help message and exit                       | `./crazy_ds.sh -h`     |
| `--time HH:MM`       | `-t HH:MM` | Set scheduled time in 24-hour format             | `./crazy_ds.sh -t 14:30` |
| `--links FILE`       | `-l FILE`  | Path to file containing download URLs            | `./crazy_ds.sh -l urls.txt` |
| `--directory PATH`   | `-d PATH`  | Set custom download directory                    | `./crazy_ds.sh -d ~/downloads` |
| `--log FILE`         | `-o FILE`  | Specify custom log file path                     | `./crazy_ds.sh -o download.log` |
| `--interactive`      | `-i`       | Force interactive mode                           | `./crazy_ds.sh -i`     |

### Table Notes:
1. Time format must be 24-hour (e.g., `14:30` for 2:30 PM)
2. For `-l/--links`, the file should contain one URL per line
3. Directory paths can be absolute or relative
4. When no options are provided, the script defaults to interactive mode


## Examples

1. Schedule downloads for 3:15 PM using links from a file:
   ```bash
   ./crazy_ds.sh -t 15:15 -l my_links.txt
   ```
2. Schedule for 9:30 AM, save to custom directory with custom log:
   ```bash
   ./crazy_ds.sh -t 09:30 -d ~/my_downloads -o ~/my_logs/down.log
   ```
3. Enter links interactively for 11:45 PM:
   ```bash
   ./crazy_ds.sh -t 23:45
   ```
(Then paste/type your links, `Ctrl+D` when done)


## Link File Format

Create a text file with one download URL per line:

```bash
https://example.com/file1.zip
https://example.com/file2.jpg
https://example.com/file3.pdf
```

## Log File Format

The log file contains timestamped entries for all operations:

```bash
[2023-11-15 14:30:00] Script started - Scheduled for 14:30
[2023-11-15 14:30:00] Download Started...
[2023-11-15 14:30:02] Downloading: https://example.com/file1.zip
[2023-11-15 14:30:05] Successfully downloaded: file1.zip
[2023-11-15 14:30:15] Download completed at 14:30:15 - 1 succeeded, 0 failed
```

## Requirements

* Bash (typically installed by default on Linux/macOS)
* `wget` (for downloads)
* `notify-send` (optional, for desktop notifications on Linux)

use `install_requirements.sh` for check and install all of requirements:

1. Make the installer executable:
  ```bash
   chmod +x install_requirements.sh
  ```
2. Run the installer:
   ```bash
   ./install_requirements.sh
   ```

## License
MIT License - Free to use and modify
