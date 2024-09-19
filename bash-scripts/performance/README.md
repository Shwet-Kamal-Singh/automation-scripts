# Performance Management Scripts

This directory contains Bash scripts for managing and analyzing system performance.

## Table of Contents

- [File Structure](#file-structure)
- [Scripts Overview](#scripts-overview)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Performance Considerations](#performance-considerations)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Disclaimer](#disclaimer)
- [Contact](#contact)

## File Structure
```
performance/
├── README.md
├── cache-clearing.sh
├── main.sh
└── resource-usage-analysis.sh
```


## Scripts Overview

1. `cache-clearing.sh`: Clears system caches to free up memory.
2. `main.sh`: Provides a menu-driven interface to execute other performance management scripts.
3. `resource-usage-analysis.sh`: Analyzes and reports on system resource usage.

## Prerequisites

- Bash shell environment
- Root or sudo access for certain performance operations
- Basic understanding of system performance concepts

## Usage

To use these performance management scripts, navigate to the `automation-scripts/bash-scripts/performance/` directory and run the desired script:

1. **Cache Clearing**:
   ```bash
   sudo ./cache-clearing.sh
   ```

2. **Resource Usage Analysis**:
   ```bash
   ./resource-usage-analysis.sh
   ```

3. **Main Menu**:
   ```bash
   ./main.sh
   ```

## Performance Considerations

- `System Impact:` Cache clearing may temporarily impact system performance.
- `Resource Intensive:` Resource usage analysis may consume additional system resources during execution.
- `Frequency:` Consider the frequency of running these scripts to balance between performance gains and system load.

## Troubleshooting

- `Permission Errors:` Ensure you have the necessary permissions (root or sudo) for scripts that modify system caches.
- `High Resource Usage:` If the analysis script shows consistently high resource usage, investigate potential system issues or resource-hungry processes.
- `Cache Clearing Effects:` Monitor system behavior after cache clearing to ensure it doesn't negatively impact critical applications.

## Contributing

Contributions to enhance these scripts are welcome. Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and test thoroughly.
4. Submit a pull request with a clear description of your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/Shwet-Kamal-Singh/automation-scripts/blob/main/LICENSE) file for details.

![Original Creator](https://img.shields.io/badge/Original%20Creator-Shwet%20Kamal%20Singh-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## Disclaimer

These scripts are provided as-is, without warranty. Use caution when clearing caches or analyzing resource usage, as these actions can impact system stability and performance.

## Contact

For any inquiries or permissions, please contact:
- Email: shwetkamalsingh55@gmail.com
- LinkedIn: https://www.linkedin.com/in/shwet-kamal-singh/
- GitHub: https://github.com/Shwet-Kamal-Singh