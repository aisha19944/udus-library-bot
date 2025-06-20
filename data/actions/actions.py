import pandas as pd
from typing import Any, Text, Dict, List
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher

class ActionCheckBookAvailability(Action):

    def name(self) -> Text:
        return "action_check_book_availability"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        book_title = next(tracker.get_latest_entity_values("book_title"), None)

        if not book_title:
            dispatcher.utter_message(text="Please tell me the book title you're looking for.")
            return []

        try:
            df = pd.read_excel("books.xlsx")
        except Exception as e:
            dispatcher.utter_message(text="Sorry, I couldn't access the book database.")
            return []

        match = df[df['title'].str.lower() == book_title.lower()]

        if not match.empty:
            book = match.iloc[0]
            dispatcher.utter_message(
                text=f"✅ Yes, *{book['title']}* by {book['author']} is available on Shelf {book['shelf']}."
            )
        else:
            dispatcher.utter_message(
                text=f"❌ Sorry, I couldn’t find *{book_title}* in our catalog."
            )

        return []