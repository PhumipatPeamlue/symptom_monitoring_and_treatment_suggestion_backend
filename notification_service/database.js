const mysql = require("mysql2/promise")

async function connectDB() {
    try {
        return await mysql.createConnection({
            host: process.env.DATABASE_HOST || "localhost",
            user: "root",
            password: "root",
            database: process.env.DATABASE_NAME || "service_db",
            timezone: "+00:00",
        })
    } catch (err) {
        throw err;
    }
}

async function getNotSentNotificationList(connection) {
    try {
        const res = []
        const [rows, fields] = await connection.execute("SELECT notifications.id, notifications.user_id, notifications.time, notifications.status, pets.name, reminders.drug_name, reminders.drug_usage FROM notifications INNER JOIN reminders ON reminders.id = notifications.reminder_id INNER JOIN pets ON reminders.pet_id = pets.id");
        for (let row of rows) {
            let notificationStatus = row.status
            let notificationTime = new Date(row.time)
            let now = new Date()
            if (notificationTime <= now && notificationStatus === "not sent") {
                console.log(`notification id: ${row.id} is going to send to user`)
                res.push(row)
            }
        }

        return res
    } catch (err) {
        throw err
    }
}

async function changeNotificationStatus(connection, successList) {
    try {
        for (let id of successList) {
            await connection.query(`UPDATE notifications SET status = 'sent' WHERE id = ${id}`)
        }
    } catch (err) {
        throw err
    }
}

module.exports = {
    connectDB,
    getNotSentNotificationList,
    changeNotificationStatus,
};