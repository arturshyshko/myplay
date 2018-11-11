from psycopg2 import connect

from django.core.management.base import BaseCommand
from psycopg2._psycopg import ProgrammingError
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

from django.conf import settings


class Command(BaseCommand):
    help = 'Create DB needed to run Myplay project'

    def handle(self, *args, **options):
        # Creating database
        con = connect(
            database='postgres',
            user=settings.DATABASES['default']['USER'],
            host=settings.DATABASES['default']['HOST'],
            password=settings.DATABASES['default']['PASSWORD']
        )

        db_name = settings.DATABASES['default']['NAME']

        con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cur = con.cursor()
        try:
            cur.execute(f'CREATE DATABASE {db_name}')
            print(f'Created database {db_name}')
        except ProgrammingError:
            print(f'Database {db_name} is already created')
        finally:
            cur.close()
            con.close()