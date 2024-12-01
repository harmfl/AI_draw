# forms.py
from django import forms
from .models import Drawing

class DrawingForm(forms.ModelForm):
    class Meta:
        model = Drawing
        fields = ['name', 'image', 'feedback']  # 包含您希望用户上传的字段
