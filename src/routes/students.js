const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/add',isLoggedIn, (req, res) => {
    res.render('students/add');
});
/// crud completo 

//agregar
router.post('/add', isLoggedIn, async (req, res) => {
    const { title, url, description } = req.body;
    const newLink = {
        title,
        url,
        description,
        user_id: req.user.id
    };
    await pool.query('INSERT INTO links set ?', [newLink]);
    req.flash('success', 'Link Saved Successfully');
    res.redirect('/students');
});


router.get('/', isLoggedIn, async (req, res) => {
    const students = await pool.query(`
        SELECT
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
            s.student_id;
    `);
    res.render('students/list', { students });
    console.log(students[0]);
});


router.get('/delete/:id',isLoggedIn, async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM links WHERE ID = ?', [id]);
    req.flash('success', 'Link Removed Successfully');
    res.redirect('/links');
});

router.get('/edit/:id',isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const links = await pool.query('SELECT * FROM links WHERE id = ?', [id]);
    console.log(links);
    res.render('links/edit', {link: links[0]});
});

router.post('/edit/:id',isLoggedIn, async (req, res) => {
    const { id } = req.params;
    const { title, description, url} = req.body; 
    const newLink = {
        title,
        description,
        url
    };
    await pool.query('UPDATE links set ? WHERE id = ?', [newLink, id]);
    req.flash('success', 'Link Updated Successfully');
    res.redirect('/links');
});

module.exports = router;