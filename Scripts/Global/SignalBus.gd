extends Node

# A card has been clicked
signal playCard(card: CardUI)

# A card is queued for "discarding"
signal poolCard(card: CardUI)

# Empty deck
signal noCards(deck: Deck)

# Plays attack animation
signal playAnimation()

# Tells game node that animation finished
signal finishAnimation()
