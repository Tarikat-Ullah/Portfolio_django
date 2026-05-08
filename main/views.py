from django.shortcuts import render, redirect
from django.contrib import messages
from .models import Profile, Skill, Project, Experience
from .forms import ContactForm


def home(request):
    profile = Profile.objects.first()
    skills = Skill.objects.all()
    projects = Project.objects.all()
    experiences = Experience.objects.all()

    skill_categories = {}
    for skill in skills:
        cat = skill.get_category_display()
        if cat not in skill_categories:
            skill_categories[cat] = []
        skill_categories[cat].append(skill)

    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'আপনার বার্তা পাঠানো হয়েছে! ধন্যবাদ।')
            return redirect('home')
    else:
        form = ContactForm()

    context = {
        'profile': profile,
        'skill_categories': skill_categories,
        'projects': projects,
        'experiences': experiences,
        'form': form,
    }
    return render(request, 'main/home.html', context)
