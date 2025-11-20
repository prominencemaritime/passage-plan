#src/alerts/passage_plan.py
"""Passage Plan Alert Implementation.""" 
from typing import Dict, List 
import pandas as pd 
from datetime import datetime, timedelta 
from zoneinfo import ZoneInfo 
 
from src.core.base_alert import BaseAlert 
from src.core.config import AlertConfig 
from src.db_utils import get_db_connection, validate_query_file 


class PassagePlanAlert(BaseAlert):
    """Alert for Passage Plan events"""
