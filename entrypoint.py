#!/usr/bin/env python

import os
import stat
import subprocess
import time

import schedule
from envparse import env

env.read_envfile()

socket = env('DOCKER_SOCK', default='/var/run/docker.sock')


def validate_socket():
    """Validate if we have access to the socket, die otherwise"""
    mode = os.stat(socket).st_mode

    assert stat.S_ISSOCK(mode)

    print(socket, 'ok')


def docker(*args):
    return subprocess.check_output(['docker', f'-Hunix://{socket}', *args]).decode()


def prune():
    print('Running docker system prune..')
    print(
        docker('system', 'prune', '--volumes', '--all', '--force'),
    )

    print('Running docker volume prune...')
    print(
        docker('volume', 'prune', '--force'),
    )


if __name__ == '__main__':
    validate_socket()

    at = env('AT', default='05:44')
    print(f'Scheduling periodic prune at {at}...')

    schedule.every().day.at(at).do(prune)

    while True:
        schedule.run_pending()
        time.sleep(1)
