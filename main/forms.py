from django import forms
from .models import ContactMessage


class ContactForm(forms.ModelForm):
    class Meta:
        model = ContactMessage
        fields = ['name', 'email', 'subject', 'message']
        widgets = {
            'name': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'আপনার নাম',
            }),
            'email': forms.EmailInput(attrs={
                'class': 'form-control',
                'placeholder': 'আপনার ইমেইল',
            }),
            'subject': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'বিষয়',
            }),
            'message': forms.Textarea(attrs={
                'class': 'form-control',
                'placeholder': 'আপনার বার্তা লিখুন...',
                'rows': 5,
            }),
        }
