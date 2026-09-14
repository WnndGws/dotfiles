#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.14"
# dependencies = [
#     "loguru",
#     "rich",
#     "typer",
# ]
# ///
"""Description."""

import typer
from loguru import logger
from rich.console import Console
from rich.logging import RichHandler

# Setup logger with RichHandler for better output
logger.remove()
logger.add(
    RichHandler(rich_tracebacks=True, show_path=True, tracebacks_show_locals=True),
    level="WARNING",
)

app = typer.Typer(add_completion=False)
console = Console()


@app.command()
def main() -> None:
    pass


if __name__ == "__main__":
    app()
