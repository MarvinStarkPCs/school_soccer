import studentsModel from "../models/student.model.js";

/// funcion para la entrada de imagenes
export const uploadImg = (req, res) => {
  if (!req.file) {
    return res.status(400).send("No file uploaded.");
  }
  res.send("File uploaded successfully!");
};

export const renderstudent = (req, res) => res.render("students/list");

export const renderStudentsList = async (req, res) => {
  try {
    const students = await studentsModel.getStudent();
    res.render("students/list", { students });
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
};
