Hyperbomb
=========

Hyperbomb is a highly customizable and multiplayer Bomberman remake.

Plan:

Components
----------

BombDropper:
+int bombAmount
+int bombSpread

Movable:
+int speed
+int direction

FlameSpreader:
+int range

UpgradeCollector

Score:
+int score

CellPosition:
+int x
+int y

PixelPosition:
+int x
+int y

Damageable:
+int health;

KeyControl:
+int upKey
+int downKey
+int leftKey
+int rightKey

TimedEffect:
+float timeRemaining
+enum EffectType(TIMED_VANISH, TIMED_DAMAGE);

AIControl:
+enum NextMove(AI_WAIT, AI_MOVE_UP,AI_MOVE_DOWN, AI_MOVE_LEFT, AI_MOVE_RIGHT, AI_DROP_BOMB)
