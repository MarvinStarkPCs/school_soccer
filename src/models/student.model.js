import { pool } from "../database.js";

const studentsModel = {
  createStudent: async (
    name,
    lastName,
    city_id,
    category_id,
    image,
    regimen_id
  ) => {
    try {
      const query = `
                INSERT INTO students (name, last_name, city_id, category_id, image, regimen_id)
                VALUES (?, ?, ?, ?, ?, ?)
            `;
      const [result] = await pool.query(query, [
        name,
        lastName,
        city_id,
        category_id,
        image,
        regimen_id,
      ]);
      if (result.affectedRows === 1) {
        return result.insertId;
      } else {
        throw new Error("Error creating student: No rows affected");
      }
    } catch (error) {
      throw new Error(`Error creating student: ${error.message}`);
    }
  },

  getStudent: async () => {
    try {
      const Query = `SELECT
        s.student_id,
        s.name AS student_name,
        s.last_name,
        s.date AS registration_date,
        c.city_name,
        d.department_name,
        cat.category_name,
        sch.school_name,
        GROUP_CONCAT(DISTINCT eps.eps_description SEPARATOR ', ') AS eps_description,
        rt.regimen_description,
        CASE WHEN s.image_student = b'1' THEN 'Yes' ELSE 'No' END AS has_image
    FROM
        students s
    JOIN citys c ON s.city_id = c.city_id
    JOIN departments d ON c.id_department = d.department_id
    JOIN categories cat ON s.category_user_id = cat.category_id
    JOIN school sch ON cat.school_id = sch.school_id
    JOIN regimen_type rt ON s.afiliation_type = rt.regimen_id
    LEFT JOIN regimen_eps re ON rt.regimen_id = re.regimen_id
    LEFT JOIN eps ON re.eps_id = eps.eps_id
    GROUP BY
        s.student_id, s.name, s.last_name, s.date, c.city_name, d.department_name, cat.category_name, sch.school_name, rt.regimen_description, s.image_student
    ORDER BY
        s.student_id;`;
      const [students] = await pool.query(Query);
      return await students;
    } catch (error) {
      console.error(error);
      throw error;
    }
  },

  getStudentById: async (id_student) => {
    try {
      const [student] = await pool.query(
        "SELECT * FROM students WHERE student_id = ?",[id_student]);
        return student
    } catch (error) {
      console.error(error);
      throw error;
    }
  },
  updateStudent :async(id_student)=>{
    try {
        const [student] = await pool.query(
          "UPDATE students SET WHERE student_id = ?",[id_student]);
          return student
      } catch (error) {
        console.error(error);
        throw error;
      }

  },
  deleteStudent: async (id_student)=>{
    try {
      await pool.query('DELETE FROM students WHERE student_id = ?', [id_student]);

    } catch (error) {
      console.error(error);
      throw error;
    }


  }


};

export default studentsModel;
