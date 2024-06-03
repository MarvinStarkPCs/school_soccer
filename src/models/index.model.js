import {pool} from '../database.js';

// Function for validating connection to the database
const Testconnection = {
    connectionDatabase: async () => {
        try {
            const [rows] = await pool.query("SELECT 1 + 1 AS result");
            return rows;
        } catch (error) {
            console.error(error);
            throw error;
        }
    }
};

export default Testconnection;
