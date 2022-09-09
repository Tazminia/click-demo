import click
import logging
from sys import stdout

logging.basicConfig(
    level=logging.INFO,
    format="[%(asctime)s] %(levelname)s [%(name)s.%(funcName)s:%(lineno)d] %(message)s",
    datefmt="%d/%b/%Y %H:%M:%S",
    stream=stdout,
)
LOGGER = logging.getLogger("hello_world")
LOGGER.setLevel(logging.INFO)

@click.command()
@click.option(
    "-n",
    "--name",
    default=None,
    show_default=True,
    help="When defined, name will be added to the greeting message",
)
@click.option(
    "-r",
    "--repeat",
    default=0,
    show_default=True,
    help="Controls how many times to repeat the greeting message. 0 means it will be shown only once.",
)
@click.option(
    "--caps/--no-caps",
    default=False,
    show_default=True,
    help="Controls showing the greeting message in capital letters",
)
def say_hello(name: str, repeat: int, caps: bool):
    greeting_message = "Hello"
    if name:
        greeting_message = f"{greeting_message} {name}"
    if caps:
        greeting_message = greeting_message.upper()
    greetings = 0
    while greetings <= repeat:
        LOGGER.info(greeting_message)
        greetings = greetings + 1
