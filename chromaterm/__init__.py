'''Color your output to terminal'''

from .__version__ import __version__
from .core import Color, Palette, Rule, Config, COLOR_TYPES

__all__ = ['Color', 'Palette', 'Rule', 'Config', 'COLOR_TYPES', '__version__']

# Support for python -m chromaterm
if __name__ == '__main__':
    import sys
    from .cli import main
    sys.exit(main())