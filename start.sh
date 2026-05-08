#!/bin/bash
set -e

cd "$(dirname "$0")"

export DJANGO_SETTINGS_MODULE=portfolio.settings
export PORT="${PORT:-3000}"

echo "Making migrations..."
python manage.py makemigrations main --noinput

echo "Running migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Creating sample data if needed..."
python manage.py shell -c "
from main.models import Profile
if not Profile.objects.exists():
    Profile.objects.create(
        name='রাহেলা আহমেদ',
        tagline='Full Stack Developer | Django & React Enthusiast',
        bio='আমি একজন passionate web developer যিনি সুন্দর এবং কার্যকরী ওয়েবসাইট তৈরি করতে ভালোবাসি। Django, React এবং modern web technologies দিয়ে কাজ করি।',
        email='rahela@example.com',
        github='https://github.com/',
        linkedin='https://linkedin.com/'
    )
    print('Profile created.')

from main.models import Skill
if not Skill.objects.exists():
    skills = [
        ('Python', 'backend', 90, '🐍', 1),
        ('Django', 'backend', 88, '🎯', 2),
        ('REST API', 'backend', 85, '🔌', 3),
        ('JavaScript', 'frontend', 82, '⚡', 4),
        ('React', 'frontend', 80, '⚛️', 5),
        ('HTML/CSS', 'frontend', 90, '🎨', 6),
        ('PostgreSQL', 'database', 78, '🐘', 7),
        ('SQLite', 'database', 85, '💾', 8),
        ('Git', 'tools', 88, '🔧', 9),
        ('Docker', 'tools', 72, '🐳', 10),
    ]
    for name, cat, level, icon, order in skills:
        Skill.objects.create(name=name, category=cat, level=level, icon=icon, order=order)
    print('Skills created.')

from main.models import Project
if not Project.objects.exists():
    projects = [
        ('E-Commerce Platform', 'Django এবং React দিয়ে তৈরি একটি সম্পূর্ণ ই-কমার্স সাইট যেখানে পেমেন্ট গেটওয়ে, প্রোডাক্ট ম্যানেজমেন্ট এবং অর্ডার ট্র্যাকিং আছে।', 'Django, React, PostgreSQL, Stripe', '', '', True, 1),
        ('Blog Platform', 'Markdown সাপোর্ট, ট্যাগ সিস্টেম এবং কমেন্ট সেকশন সহ একটি আধুনিক ব্লগিং প্ল্যাটফর্ম।', 'Django, Bootstrap, SQLite', '', '', False, 2),
        ('Task Manager', 'টিম কোলাবরেশনের জন্য একটি রিয়েল-টাইম টাস্ক ম্যানেজমেন্ট অ্যাপ।', 'Django, Channels, WebSocket, React', '', '', False, 3),
    ]
    for title, desc, tech, gh, live, feat, order in projects:
        Project.objects.create(title=title, description=desc, tech_stack=tech, github_url=gh, live_url=live, featured=feat, order=order)
    print('Projects created.')

from main.models import Experience
if not Experience.objects.exists():
    exps = [
        ('Tech Solutions BD', 'Senior Django Developer', '2022 - Present', 'Django REST Framework দিয়ে scalable API তৈরি করা, PostgreSQL optimization এবং junior developers দের mentoring করি।', 1),
        ('StartupXYZ', 'Junior Web Developer', '2020 - 2022', 'React frontend এবং Django backend দিয়ে বিভিন্ন client project সম্পন্ন করেছি।', 2),
    ]
    for co, role, dur, desc, order in exps:
        Experience.objects.create(company=co, role=role, duration=dur, description=desc, order=order)
    print('Experience created.')
"

echo "Starting Django server on port $PORT..."
exec python manage.py runserver "0.0.0.0:$PORT"
