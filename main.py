"""
Acadify - Academic Record Management System
A comprehensive web-based academic record management system for Norzagaray College
"""

from flask import Flask, render_template, request, redirect, url_for, flash, session, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, UserMixin, login_user, logout_user, login_required, current_user
from werkzeug.security import generate_password_hash, check_password_hash
import pymysql
import os
from datetime import datetime

# Initialize Flask application
app = Flask(__name__)

# Configuration
app.config['SECRET_KEY'] = os.environ.get('SESSION_SECRET', 'acadify-secret-key-2025')
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/acadify_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Initialize extensions
db = SQLAlchemy(app)
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'  # type: ignore
login_manager.login_message = 'Please log in to access this page.'

# =====================================
# DATABASE MODELS
# =====================================

class User(UserMixin, db.Model):
    """User model for authentication and role management"""
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password_hash = db.Column(db.String(255), nullable=False)
    role = db.Column(db.String(20), nullable=False)  # student, instructor, registrar, dean, mis_it
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    department = db.Column(db.String(10), nullable=True)  # BSCS, BEED, BSHM, BSED
    student_id = db.Column(db.String(20), unique=True, nullable=True)
    year_level = db.Column(db.Integer, nullable=True)
    semester = db.Column(db.Integer, nullable=True)
    active = db.Column(db.Boolean, default=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    def set_password(self, password):
        self.password_hash = generate_password_hash(password)
    
    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

class Subject(db.Model):
    """Subject model for course management"""
    id = db.Column(db.Integer, primary_key=True)
    subject_code = db.Column(db.String(20), unique=True, nullable=False)
    subject_name = db.Column(db.String(100), nullable=False)
    units = db.Column(db.Integer, nullable=False)
    department = db.Column(db.String(10), nullable=False)
    year_level = db.Column(db.Integer, nullable=False)
    semester = db.Column(db.Integer, nullable=False)
    instructor_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=True)
    
class Grade(db.Model):
    """Grade model for academic records"""
    id = db.Column(db.Integer, primary_key=True)
    student_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    subject_id = db.Column(db.Integer, db.ForeignKey('subject.id'), nullable=False)
    prelim_grade = db.Column(db.Float, nullable=True)
    midterm_grade = db.Column(db.Float, nullable=True)
    final_grade = db.Column(db.Float, nullable=True)
    final_average = db.Column(db.Float, nullable=True)
    equivalent_grade = db.Column(db.Float, nullable=True)  # GPA equivalent (1.00-5.00)
    remarks = db.Column(db.String(20), nullable=True)  # Excellent, Outstanding, etc.
    semester = db.Column(db.Integer, nullable=False)
    academic_year = db.Column(db.String(10), nullable=False)
    is_locked = db.Column(db.Boolean, default=False)
    submitted_at = db.Column(db.DateTime, nullable=True)
    approved_at = db.Column(db.DateTime, nullable=True)

class DeansListRecord(db.Model):
    """Dean's List records for academic achievers"""
    id = db.Column(db.Integer, primary_key=True)
    student_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    semester = db.Column(db.Integer, nullable=False)
    academic_year = db.Column(db.String(10), nullable=False)
    gwa = db.Column(db.Float, nullable=False)  # General Weighted Average
    rank = db.Column(db.Integer, nullable=True)
    total_units = db.Column(db.Integer, nullable=False)
    qualified = db.Column(db.Boolean, default=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

# =====================================
# LOGIN MANAGER
# =====================================

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

# =====================================
# UTILITY FUNCTIONS
# =====================================

def calculate_grade_equivalent(numerical_grade):
    """Convert numerical grade to GPA equivalent based on Norzagaray College scale"""
    if numerical_grade is None:
        return None, None
    
    if numerical_grade >= 98:
        return 1.00, "Excellent"
    elif numerical_grade >= 95:
        return 1.25, "Outstanding"
    elif numerical_grade >= 92:
        return 1.50, "Superior"
    elif numerical_grade >= 89:
        return 1.75, "Very Good"
    elif numerical_grade >= 86:
        return 2.00, "Good"
    elif numerical_grade >= 83:
        return 2.25, "Satisfactory"
    elif numerical_grade >= 80:
        return 2.50, "Fairly Satisfactory"
    elif numerical_grade >= 76:
        return 2.75, "Fair"
    elif numerical_grade >= 75:
        return 3.00, "Passed"
    else:
        return 5.00, "Failed"

def calculate_final_grade(prelim, midterm, final):
    """Calculate final average from three grading periods"""
    if prelim is None or midterm is None or final is None:
        return None
    return round((prelim + midterm + final) / 3, 2)

def check_deans_list_eligibility(student_id, semester, academic_year):
    """Check if student qualifies for Dean's List"""
    grades = Grade.query.filter_by(
        student_id=student_id,
        semester=semester,
        academic_year=academic_year
    ).all()
    
    if not grades:
        return False, 0, 0
    
    total_units = 0
    total_points = 0
    
    for grade in grades:
        if not grade.equivalent_grade or grade.equivalent_grade >= 5.00:
            return False, 0, 0  # Has failing grade
        
        if grade.equivalent_grade > 2.00:
            return False, 0, 0  # Has grade lower than 2.00
        
        # Get subject units
        subject = Subject.query.get(grade.subject_id)
        if subject:
            total_units += subject.units
            total_points += grade.equivalent_grade * subject.units
    
    if total_units < 18:
        return False, 0, total_units  # Not enough units
    
    gwa = total_points / total_units if total_units > 0 else 0
    
    # Must have GWA of 1.75 or better
    return gwa <= 1.75, gwa, total_units

def create_demo_accounts():
    """Create demo accounts for all user roles"""
    demo_users = [
        {
            'username': 'student_demo',
            'email': 'student@norzagaray.edu.ph',
            'password': 'student123',
            'role': 'student',
            'first_name': 'Juan',
            'last_name': 'Dela Cruz',
            'department': 'BSCS',
            'student_id': '2021-00001',
            'year_level': 3,
            'semester': 1
        },
        {
            'username': 'instructor_demo',
            'email': 'instructor@norzagaray.edu.ph',
            'password': 'instructor123',
            'role': 'instructor',
            'first_name': 'Maria',
            'last_name': 'Santos',
            'department': 'BSCS'
        },
        {
            'username': 'registrar_demo',
            'email': 'registrar@norzagaray.edu.ph',
            'password': 'registrar123',
            'role': 'registrar',
            'first_name': 'Roberto',
            'last_name': 'Garcia'
        },
        {
            'username': 'dean_demo',
            'email': 'dean@norzagaray.edu.ph',
            'password': 'dean123',
            'role': 'dean',
            'first_name': 'Elizabeth',
            'last_name': 'Reyes'
        },
        {
            'username': 'misit_demo',
            'email': 'misit@norzagaray.edu.ph',
            'password': 'misit123',
            'role': 'mis_it',
            'first_name': 'Carlos',
            'last_name': 'Lopez'
        }
    ]
    
    for user_data in demo_users:
        existing_user = User.query.filter_by(username=user_data['username']).first()
        if not existing_user:
            user = User()
            user.username = user_data['username']
            user.email = user_data['email']
            user.set_password(user_data['password'])
            user.role = user_data['role']
            user.first_name = user_data['first_name']
            user.last_name = user_data['last_name']
            user.department = user_data.get('department')
            user.student_id = user_data.get('student_id')
            user.year_level = user_data.get('year_level')
            user.semester = user_data.get('semester')
            
            db.session.add(user)
    
    db.session.commit()

# =====================================
# ROUTES
# =====================================

@app.route('/')
def index():
    """Home page route"""
    if current_user.is_authenticated:
        return redirect(url_for('dashboard'))
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    """Login page with demo accounts"""
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        
        user = User.query.filter_by(username=username).first()
        
        if user and user.check_password(password):
            login_user(user)
            next_page = request.args.get('next')
            return redirect(next_page) if next_page else redirect(url_for('dashboard'))
        else:
            flash('Invalid username or password', 'error')
    
    # Demo accounts for display
    demo_accounts = [
        {'role': 'Student', 'username': 'student_demo', 'password': 'student123'},
        {'role': 'Instructor', 'username': 'instructor_demo', 'password': 'instructor123'},
        {'role': 'Registrar', 'username': 'registrar_demo', 'password': 'registrar123'},
        {'role': 'Dean', 'username': 'dean_demo', 'password': 'dean123'},
        {'role': 'MIS/IT', 'username': 'misit_demo', 'password': 'misit123'}
    ]
    
    return render_template('login.html', demo_accounts=demo_accounts)

@app.route('/logout')
@login_required
def logout():
    """Logout route"""
    logout_user()
    flash('You have been logged out successfully', 'success')
    return redirect(url_for('login'))

@app.route('/dashboard')
@login_required
def dashboard():
    """Role-based dashboard routing"""
    if current_user.role == 'student':
        return redirect(url_for('student_dashboard'))
    elif current_user.role == 'instructor':
        return redirect(url_for('instructor_dashboard'))
    elif current_user.role == 'registrar':
        return redirect(url_for('registrar_dashboard'))
    elif current_user.role == 'dean':
        return redirect(url_for('dean_dashboard'))
    elif current_user.role == 'mis_it':
        return redirect(url_for('misit_dashboard'))
    else:
        flash('Invalid user role', 'error')
        return redirect(url_for('login'))

@app.route('/student/dashboard')
@login_required
def student_dashboard():
    """Student dashboard with grades and Dean's List status"""
    if current_user.role != 'student':
        flash('Access denied', 'error')
        return redirect(url_for('dashboard'))
    
    # Get student grades
    grades = Grade.query.filter_by(student_id=current_user.id).all()
    
    # Check Dean's List eligibility
    current_semester = 1  # This would be dynamic in production
    current_year = "2024-2025"
    eligible, gwa, total_units = check_deans_list_eligibility(
        current_user.id, current_semester, current_year
    )
    
    return render_template('student_dashboard.html', 
                         user=current_user, 
                         grades=grades,
                         deans_list_eligible=eligible,
                         gwa=gwa,
                         total_units=total_units)

@app.route('/instructor/dashboard')
@login_required
def instructor_dashboard():
    """Instructor dashboard for grade management"""
    if current_user.role != 'instructor':
        flash('Access denied', 'error')
        return redirect(url_for('dashboard'))
    
    # Get assigned subjects
    subjects = Subject.query.filter_by(instructor_id=current_user.id).all()
    
    return render_template('instructor_dashboard.html', 
                         user=current_user, 
                         subjects=subjects)

@app.route('/registrar/dashboard')
@login_required
def registrar_dashboard():
    """Registrar dashboard for academic oversight"""
    if current_user.role != 'registrar':
        flash('Access denied', 'error')
        return redirect(url_for('dashboard'))
    
    # Get pending grade submissions
    pending_grades = Grade.query.filter_by(is_locked=False).all()
    
    # Get all students
    students = User.query.filter_by(role='student').all()
    
    return render_template('registrar_dashboard.html', 
                         user=current_user, 
                         pending_grades=pending_grades,
                         students=students)

@app.route('/dean/dashboard')
@login_required
def dean_dashboard():
    """Dean dashboard for academic excellence tracking"""
    if current_user.role != 'dean':
        flash('Access denied', 'error')
        return redirect(url_for('dashboard'))
    
    # Get Dean's List records
    deans_list = DeansListRecord.query.filter_by(qualified=True).order_by(DeansListRecord.rank).all()
    
    return render_template('dean_dashboard.html', 
                         user=current_user, 
                         deans_list=deans_list)

@app.route('/misit/dashboard')
@login_required
def misit_dashboard():
    """MIS/IT dashboard for system administration"""
    if current_user.role != 'mis_it':
        flash('Access denied', 'error')
        return redirect(url_for('dashboard'))
    
    # Get system statistics
    total_users = User.query.count()
    total_students = User.query.filter_by(role='student').count()
    total_instructors = User.query.filter_by(role='instructor').count()
    
    return render_template('misit_dashboard.html', 
                         user=current_user,
                         total_users=total_users,
                         total_students=total_students,
                         total_instructors=total_instructors)

# =====================================
# API ROUTES
# =====================================

@app.route('/api/toggle-theme', methods=['POST'])
@login_required
def toggle_theme():
    """Toggle between dark and light theme"""
    data = request.get_json() or {}
    theme = data.get('theme', 'light')
    session['theme'] = theme
    return jsonify({'status': 'success', 'theme': theme})

# =====================================
# DATABASE INITIALIZATION
# =====================================

def init_database():
    """Initialize database with tables and demo data"""
    try:
        db.create_all()
        create_demo_accounts()
        print("Database initialized successfully!")
        return True
    except Exception as e:
        print(f"Database initialization error: {e}")
        return False

# =====================================
# APPLICATION STARTUP
# =====================================

if __name__ == '__main__':
    # Initialize database
    with app.app_context():
        init_database()
    
    # Run the application
    app.run(host='0.0.0.0', port=5000, debug=True)