from django.urls import re_path
from . import consumers

websocket_urlpatterns = [
    re_path(r'ws/remote-stream/(?P<client_type>\w+)/(?P<student_id>\d+)/$', consumers.RemoteStreamConsumer.as_asgi()),
]
