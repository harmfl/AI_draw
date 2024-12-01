from django.http import HttpResponseForbidden
from functools import wraps


def role_required(allowed_roles):
    def decorator(view_func):
        @wraps(view_func)
        def _wrapped_view(request, *args, **kwargs):
            # 检查用户是否已登录
            if not request.user.is_authenticated:
                return HttpResponseForbidden("您没有权限访问此页面，请先登录。")

            # 检查用户是否有 Profile 对象
            if not hasattr(request.user, 'profile'):
                return HttpResponseForbidden("用户配置文件缺失，无法验证权限。")

            # 检查用户角色是否在允许的角色中
            if request.user.profile.user_type not in allowed_roles:
                return HttpResponseForbidden("权限不足，您无权访问此页面。")

            return view_func(request, *args, **kwargs)

        return _wrapped_view

    return decorator
