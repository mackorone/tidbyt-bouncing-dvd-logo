load("encoding/base64.star", "base64")
load("render.star", "render")


FRAME_WIDTH = 64
FRAME_HEIGHT = 32

IMAGE_WIDTH = 15
IMAGE_HEIGHT = 9
IMAGE = """iVBORw0KGgoAAAANSUhEUgAAAA8AAAAJCAYAAADtj3ZXAAAAQUlEQVQokWNgwA3+I2Fc8hgK/iPR//HwMWxhYMBuEDZDcSpCNwiX4VhdgK4AlxiKBnRMUB5fiBJyIUHnE6WQZJsBSnw7xZmNBscAAAAASUVORK5CYII="""

COLORS = [
    "#0ef",  # light blue
    "#f70",  # orange
    "#02f",  # dark blue
    "#fe0",  # yellow
    "#f20",  # red
    "#f08",  # pink
    "#b0f",  # purple
]


def main():
    pos_x = 0
    pos_y = 0
    vel_x = 1
    vel_y = 1
    color_index = 0
    frames = []
    for i in range(300):
        frames.append(get_frame(pos_x, pos_y, color_index))
        state = step(pos_x, pos_y, vel_x, vel_y, color_index)
        pos_x, pos_y, vel_x, vel_y, color_index = state
    return render.Root(
        delay=100,
        child=render.Animation(frames)
    )


def get_frame(pos_x, pos_y, color_index):
    return render.Padding(
        pad=(pos_x, pos_y, 0, 0),
        child=render.Stack(
            children=[
                render.Box(
                    width=IMAGE_WIDTH,
                    height=IMAGE_HEIGHT,
                    color=COLORS[color_index],
                ),
                render.Image(base64.decode(IMAGE)),
            ]
        )
    )


def step(pos_x, pos_y, vel_x, vel_y, color_index):
    pos_x += vel_x
    pos_y += vel_y
    if pos_x < 0 or FRAME_WIDTH - IMAGE_WIDTH < pos_x:
        pos_x -= 2 * vel_x
        vel_x = -1 * vel_x
        color_index += 1
    if pos_y < 0 or FRAME_HEIGHT - IMAGE_HEIGHT < pos_y:
        pos_y -= 2 * vel_y
        vel_y = -1 * vel_y
        color_index += 1
    return (pos_x, pos_y, vel_x, vel_y, color_index % len(COLORS))
