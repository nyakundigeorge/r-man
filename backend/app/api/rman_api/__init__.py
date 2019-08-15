# flake8: noqa
from flask import Blueprint
from app.__meta__ import api

url = f"{api.get('version', 'v1')}/{api.get('base_route', 'rman')}"

mail = Blueprint(
    name="R-MAN",
    import_name=__name__,
    url_prefix=f"/api/{url}",
    static_folder="static",
    template_folder="templates",
)

from . import rest_api