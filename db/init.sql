CREATE DATABASE symptom_monitoring_and_treatment_suggestion_users;
CREATE DATABASE symptom_monitoring_and_treatment_suggestion_pets;
CREATE DATABASE symptom_monitoring_and_treatment_suggestion_reminders;
CREATE DATABASE symptom_monitoring_and_treatment_suggestion_notifications;
CREATE DATABASE symptom_monitoring_and_treatment_suggestion_file_info;

USE symptom_monitoring_and_treatment_suggestion_users;
CREATE TABLE IF NOT EXISTS users (
    id VARCHAR(255) NOT NULL,
    morning DATETIME NOT NULL,
    noon DATETIME NOT NULL,
    evening DATETIME NOT NULL,
    before_bed DATETIME NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

USE symptom_monitoring_and_treatment_suggestion_pets;
CREATE TABLE IF NOT EXISTS pets (
    id VARCHAR(255) NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

USE symptom_monitoring_and_treatment_suggestion_reminders;
CREATE TABLE IF NOT EXISTS reminders (
    id VARCHAR(255) NOT NULL,
    pet_id VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    drug_name VARCHAR(255) NOT NULL,
    drug_usage VARCHAR(255) NOT NULL,
    frequency_day_usage INT NOT NULL,
    renew_in INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS period_info (
    id INT NOT NULL AUTO_INCREMENT,
    reminder_id VARCHAR(255) NOT NULL,
    morning DATETIME,
    noon DATETIME,
    evening DATETIME,
    before_bed DATETIME,
    PRIMARY KEY (id),
    FOREIGN KEY (reminder_id) REFERENCES reminders(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS hour_info (
    id INT NOT NULL AUTO_INCREMENT,
    reminder_id VARCHAR(255) NOT NULL,
    first_usage DATETIME NOT NULL,
    every int NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (reminder_id) REFERENCES reminders(id) ON DELETE CASCADE
);

USE symptom_monitoring_and_treatment_suggestion_notifications;
CREATE TABLE IF NOT EXISTS notifications (
    id INT NOT NULL AUTO_INCREMENT,
    pet_id VARCHAR(255) NOT NULL,
    reminder_id VARCHAR(255) NOT NULL,
    notify_at DATETIME NOT NULL,
    status VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

USE symptom_monitoring_and_treatment_suggestion_file_info;
CREATE TABLE IF NOT EXISTS file_info (
    id VARCHAR(255) NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);