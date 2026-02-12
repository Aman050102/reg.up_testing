# 🎓 GPA Calculation Automation Testing (UP REG)

โปรเจกต์ทดสอบระบบ (Automated Testing) สำหรับระบบบริการการศึกษา มหาวิทยาลัยพะเยา โดยใช้ **Robot Framework**

---

## 📋 Test Information
📍 https://docs.google.com/spreadsheets/d/14-Vsel4U2QA6lPBbqdn-1kscXpFjRp0HZ5SA41vllmE/edit?usp=sharing

---

## 🛠️ เครื่องมือที่ใช้ (Tech Stack)

* **Framework:** [Robot Framework](https://robotframework.org/)
* **Library:** * `SeleniumLibrary` (Web Automation)
  * `Dialogs` (รองรับการหยุดรอการยืนยัน MFA)
  * `Collections` (จัดการข้อมูลชุดเกรด)
* **Language:** Python 3.x
* **Browser:** Google Chrome (ร่วมกับ ChromeDriver)

---

## 🧪 ขอบเขตการทดสอบ (Test Scenarios)

ชุดทดสอบนี้ครอบคลุมฟังก์ชันหลัก ดังนี้: 	
| Main Feature|
| ID | Name| Details |
| :--- | :--- | :--- |
| **F01** | **Login & MFA** | เข้าสู่ระบบ ด้วยข้อมูลที่ลงทะเบียนไว้ เพื่อหา Valid และ Invalid และ การยืนยันตัวตนด้วย MFA|
| **F02** | **Grade Point Average (GPA)** | ตรวจสอบการคำนวณ GPA |


## 🚀 วิธีการรันการทดสอบ (Getting Started)

### 1. การเตรียมความพร้อม (Prerequisites)
* ติดตั้ง Python และ SeleniumLibrary:
  ```bash
  pip install robotframework-seleniumlibrary
