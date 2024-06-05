import Testconnection from "../models/index.model.js"
// Function that controls teh database connection test
 export const getTestconnection =async () => {
const result = await Testconnection.connectionDatabase();
if(result.length < 0) {
    console.error("Erro connection to database")
    return;
}
console.log("connection success")
 }

 export const renderIndex = (req, res) => res.render("index");