#!/usr/bin/env -S uv run --script
## Run this script using uv
## init uv with `uv init && uv venv && source .venv/bin/activate`
## Check `skeletons/tools/py` for a list of currently preferred tools

# import alive-progress
# import configparser
# import pathlib
import sys

# import arrow
# import fastapi
# import httpx
# import humanise
# import joblib
# import maturin
# import orjson
# import plumbum
# import polars
# import pydantic
# import pyright
# import pyspy
# import pytest
# import questionary
# import regex
# import schedule
# import tenacity
# import thefuzz
# import typer
from loguru import logger
from rich.logging import RichHandler

# Setup logger with RichHandler for better output
logger.remove()
logger.add(
    sys.stderr,
)
logger.configure(
    handlers=[
        {
            "sink": RichHandler(
                rich_tracebacks=True, show_path=True, tracebacks_show_locals=True
            ),
            "level": "INFO",
        }
    ]
)

if __name__ == "__main__":
    pass
