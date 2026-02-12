# 🎓 GPA Calculation Automation Testing (UP REG)

**Automated Web Testing Project** for the Educational Service System (REG) of the University of Phayao. Developed using **Robot Framework** to ensure the accuracy and integrity of the GPA calculation engine.


## 📋 Test Information & Documentation
Access the comprehensive Test Case Specifications, Test Data, and Requirement Traceability Matrix via the link below:

* 📍 **Test Case Sheets:** [View Google Spreadsheets](https://docs.google.com/spreadsheets/d/14-Vsel4U2QA6lPBbqdn-1kscXpFjRp0HZ5SA41vllmE/edit?usp=sharing)
* 📑 **Project Status:** `Active / In-Progress`


## 🧪 Test Scenarios & Scope
The testing suite is divided into two primary modules to validate both security and functional logic:

| Module | ID | Test Name | Description |
| :--- | :--- | :--- | :--- |
| **Authentication** | `F01` | **Login & MFA** | Validates Microsoft SSO integration, including Positive/Negative login cases and Multi-Factor Authentication (MFA) approval. |
| **Calculation** | `F02` | **Grade Point Average** | Verifies the GPA calculation engine across various boundary values (Max GPA, Min GPA, and Mixed Grade distributions). |


## 🛠️ Tech Stack & Tools
This project leverages industry-standard tools for robust and scalable web automation:

* **Core Framework:** [Robot Framework](https://robotframework.org/) (Keyword-Driven)
* **Libraries:**
    * `SeleniumLibrary`: For browser orchestration and web element interaction.
    * `Dialogs`: To handle manual pause-and-resume for MFA mobile approval.
    * `Collections`: To manage complex data lists and grade mapping.
* **Language:** Python 3.4
* **Browser:** Google Chrome (controlled via ChromeDriver)
