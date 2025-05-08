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
| `--help`             | `-h`       | Show help message and exit                       | `./download_scheduler.sh -h`     |
| `--time HH:MM`       | `-t HH:MM` | Set scheduled time in 24-hour format             | `./download_scheduler.sh -t 14:30` |
| `--links FILE`       | `-l FILE`  | Path to file containing download URLs            | `./download_scheduler.sh -l urls.txt` |
| `--directory PATH`   | `-d PATH`  | Set custom download directory                    | `./download_scheduler.sh -d ~/downloads` |
| `--log FILE`         | `-o FILE`  | Specify custom log file path                     | `./download_scheduler.sh -o download.log` |
| `--interactive`      | `-i`       | Force interactive mode                           | `./download_scheduler.sh -i`     |

### Table Notes:
1. Time format must be 24-hour (e.g., `14:30` for 2:30 PM)
2. For `-l/--links`, the file should contain one URL per line
3. Directory paths can be absolute or relative
4. When no options are provided, the script defaults to interactive mode
