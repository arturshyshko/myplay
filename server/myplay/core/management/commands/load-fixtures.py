from django.core.management.base import BaseCommand
from django.conf import settings
from django.contrib.auth.models import User


class Command(BaseCommand):
    help = 'Load fixtures to db'

    def handle(self, *args, **options):
        user, _ = User.objects.update_or_create(
            email='test@gmail.com',
            username='admin',
            defaults={
                'first_name': 'test',
                'last_name': 'test',
            }
        )

        user.set_password('Admin1234')
        user.is_staff = True
        user.is_superuser = True
        user.save()
