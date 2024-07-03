# bash_scripting

### Introduction: Automating User and Group Management on Ubuntu with Bash Scripting

Welcome to the create_users.sh script, designed to automate the process of user and group management on Ubuntu Linux systems. This script is crafted to streamline the creation of user accounts, assignment to specified groups, and secure password generation, all while maintaining detailed logs of actions for auditing purposes.

#### Purpose

Managing user accounts and groups manually can be labor-intensive and prone to errors, especially in environments with frequent personnel changes. This script aims to alleviate these challenges by automating the following tasks:

- User Creation: Create new user accounts with designated home directories and set appropriate permissions.
  
- Group Management: Ensure the creation of associated groups as specified in the input file, including each user's personal group named after their username.
  
- Password Generation: Generate random passwords for each user and securely store them in a designated file (/var/secure/user_passwords.csv), accessible only to privileged users.

- Logging: Log all actions performed by the script to /var/log/user_management.log, providing a clear record of user and group creation, password generation, and any potential errors encountered during execution.

#### Usage

To utilize the create_users.sh script effectively:

1. Input File: Prepare a text file containing usernames and associated groups in the format username;groups, where groups are comma-separated.
  
2. Execution: Run the script with root privileges (sudo) and provide the path to the input file as an argument (bash create_users.sh <name-of-text-file>).
  
3. Verification: Check /var/log/user_management.log for comprehensive logs of all actions performed by the script. Ensure /var/secure/user_passwords.csv securely stores generated passwords with restricted access.

#### Benefits

By automating user and group management with this script, administrators can:

- Save Time: Automate repetitive tasks, reducing manual effort and potential human errors.
  
- Enhance Security: Ensure consistent application of security policies, including strong password generation and restricted access to sensitive information.
  
- Improve Auditing: Maintain detailed logs that facilitate compliance with regulatory requirements and internal policies.

#### Conclusion

The create_users.sh script provides a robust solution for automating user and group management on Ubuntu systems, offering efficiency, security, and reliability in managing user accounts and access controls. Whether deploying in small businesses or enterprise environments, this script enhances operational efficiency while maintaining stringent security standards.

Explore the script, customize it to fit your organizational needs, and enjoy simplified user management on Ubuntu with automation at its core.

---
