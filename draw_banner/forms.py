from django import forms
from .models import Drawing

class DrawingForm(forms.ModelForm):
    class Meta:
        model = Drawing
        fields = ['name', 'image', 'feedback']  # 选择表单需要填写的字段
