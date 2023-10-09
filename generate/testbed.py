import pymunk
from pymunk import Vec2d
import random
import matplotlib.pyplot as plt
import pymunk.matplotlib_util
from ItarusAves import make_structure, blocks
import math
import copy

# object specification:
# Fully specified object:
# [0, x, y, width, height, rotation, body_type]
# Partially specified object (from itarus):
# [type, x, y]


def distance(coordA, coordB):
    return math.sqrt((coordA[0]-coordB[0])**2 + (coordA[1]-coordB[1])**2)


def coords(object):
    return (object[1], object[2])


def remove_duplicates(objects):
    result = []
    for i in objects:
        exists = False
        for j in result:
            dist = distance(coords(i), coords(j))
            if dist < 0.01:
                exists = True
                break
        if not exists:
            result.append(i)
    return result


def get_itarus_dimensions(object: list[int]) -> tuple[int, int]:
    if object[0] == 0:
        return (object[3], object[4])
    else:
        return tuple(blocks[str(object[0])])


def get_itarus_rotation(object: list[int]) -> float:
    if object[0] == 0:
        return object[5]
    else:
        return 0.0


def add_itarus_objects_to_space(objects: list, space: pymunk.Space):
    shapes = []
    for object in objects:
        dimensions = get_itarus_dimensions(object)
        if object[0] == 0 and object[6] == pymunk.Body.STATIC:
            body = pymunk.Body(body_type=pymunk.Body.STATIC)
            color = (0, 0, 0, 255)
            friction = 1.0
        else:
            mass = 10.0
            moment = pymunk.moment_for_box(mass, dimensions)
            body = pymunk.Body(mass, moment)
            color = (180, 180, 0, 255)
            friction = 0.3
        rotation = get_itarus_rotation(object)
        body.angle = rotation
        body.position = Vec2d(object[1], object[2])
        shape = pymunk.Poly.create_box(body, dimensions)
        shape.friction = friction
        shape.color = color
        space.add(body, shape)
        shapes.append(shape)
    return shapes


def bounding_box_to_dimensions(bb: pymunk.BB):
    return (bb.right - bb.left, bb.top - bb.bottom)


def extract_itarus_objects_from_space(space: pymunk.Space, objects: list):
    new_objects = []
    for shape, object in zip(space.shapes, objects):
        body = shape.body
        x = body.position.x
        y = body.position.y
        rotation = body.angle
        width, height = get_itarus_dimensions(object)
        new_objects.append([0, x, y, width, height, rotation, body.body_type])
    return new_objects


def create_ground(width: int):
    body = pymunk.Body(body_type=pymunk.Body.STATIC)
    body.position = Vec2d(0, -1)
    shape = pymunk.Poly.create_box(body, (width*2, 2))
    shape.friction = 1.0
    shape.color = (0, 0, 0, 255)
    return body, shape, (0, 0, -1, width*2, 2, 0, pymunk.Body.STATIC)


def random_x(minimal, maximal, random=random.Random()):
    x = random.gauss((minimal+maximal)/2, (maximal-minimal)/6)
    return min(max(x, minimal), maximal)


def to_static_object(object):
    if object[0] == 0:
        return [0, object[1], object[2], object[3], object[4], object[5], pymunk.Body.STATIC]
    else:
        width, height = get_itarus_dimensions(object)
        return [0, object[1], object[2], width, height, 0.0, pymunk.Body.STATIC]


def is_static(object):
    return len(object) >= 7 and object[6] == pymunk.Body.STATIC


class TestBed:
    def __init__(self, width, height, max_steps, remove=False, min_percent=0.8, seed=None, static_objects=False):
        self.max_steps = max_steps
        self.seed = seed
        self.running = True
        self.drawing = True
        self.random = random.Random(seed)
        self.width = width
        self.height = height
        self.remove = remove
        self.static_objects = static_objects
        self.min_percent = min_percent
        self.objects: list[tuple[int, ...]] = []
        self.shapes: list[pymunk.Shape] = []

    def create_sb_world(self):
        # Init pymunk and create space
        self.space = pymunk.Space()
        self.space.gravity = (0.0, -9.0)
        self.space.sleep_time_threshold = 0.3
        self.space.collision_slop = 0.01
        # ground
        body, shape, object = create_ground(self.width)
        self.space.add(body, shape)
        self.shapes.append(shape)
        self.objects.append(object)

        # Structure
        structure_objects, _, _ = make_structure(
            0, 0, self.width, self.height, self.random)
        if self.remove:
            structure_objects = (self.filter_objects(structure_objects))
        if self.static_objects:
            structure_objects = self.random_static(
                0, len(structure_objects), structure_objects)
        self.objects.extend(structure_objects)
        self.shapes.extend(add_itarus_objects_to_space(
            structure_objects, self.space))

    def create_random_world(self):
        self.space = pymunk.Space()
        self.space.gravity = (0.0, -9.0)
        self.space.sleep_time_threshold = 0.3
        self.space.collision_slop = 0.01
        # ground
        body, shape, object = create_ground(self.width)
        self.space.add(body, shape)
        self.shapes.append(shape)
        self.objects.append(object)

        # Create random object at top of space and let it fall
        for i in range(random.randint(10, 40)):
            mass = 10.0
            random_object = self.random.choice(list(blocks.keys()))
            dimensions = get_itarus_dimensions([int(random_object), 0, 0])
            moment = pymunk.moment_for_box(mass, dimensions)
            body = pymunk.Body(mass, moment)
            # Position at top of space and random x
            body.position = Vec2d(
                random_x(-self.width + dimensions[0], self.width - dimensions[0], random=self.random), self.height)
            body.rotation = self.random.uniform(0, 2 * math.pi)
            shape = pymunk.Poly.create_box(body, dimensions)
            shape.friction = 0.3
            shape.color = (180, 180, 0, 255)
            self.space.add(body, shape)
            self.objects.append((int(random_object), int(
                body.position.x), int(body.position.y)))
            self.shapes.append(shape)
            # Simulate a bit to stabilize the simulation
            self.draw(f'tmp/add-object-{i:02}.png')
            for _ in range(1000):
                self.space.step(0.01)
        # Extract objects from space

        self.draw(f'tmp/intermediate.png')
        self.objects = extract_itarus_objects_from_space(
            self.space, self.objects)

        if self.remove:
            self.objects = self.filter_objects(start_index=1)
        if self.static_objects:
            self.objects = self.random_static(0, len(self.objects))

        # Recreate the stable scene to be able to evaluate interactions between objects
        self.space = pymunk.Space()
        self.space.gravity = (0.0, -9.0)
        self.space.sleep_time_threshold = 0.3
        self.space.collision_slop = 0.01

        # Add objects
        self.shapes = add_itarus_objects_to_space(self.objects, self.space)

        self.draw(f'tmp/final.png')

    def filter_objects(self, objects=None, start_index=0):
        if not objects:
            objects = self.objects
        total = len(objects)
        if start_index > 0:
            total = total - start_index

        min_count = min(1, int(self.min_percent * total))
        count = self.random.randint(min_count, total)
        return objects[:start_index] + self.random.sample(objects[start_index:], k=count)

    def random_static(self, start: int, stop: int, objects: list | None = None):
        if not objects:
            objects = self.objects
        objects = copy.deepcopy(objects)
        options = list(range(len(objects)))
        k = self.random.randrange(max(0, start), min(len(objects), stop))
        static_indexes = self.random.sample(options, k)
        for index in static_indexes:
            object = objects[index]
            objects[index] = to_static_object(object)
        return objects

    def run(self):
        while self.space.current_time_step < self.max_steps:
            # self.draw(f'tmp/image-{self.space.current_time_step}.png')
            self.step()

    def step(self):
        step_dt = 1 / 250
        self.space.step(self.space.current_time_step + step_dt)

    def compare(self):
        result = []
        for object, shape in zip(self.objects, self.shapes):
            distance = abs(shape.body.position.y - object[2])
            if distance < 1:
                result.append('unchanged')
            else:
                result.append('moved')
        return result

    def get_index_of_shape(self, shape: pymunk.Shape):
        return self.shapes.index(shape)

    def get_supports(self):
        collision_handler = self.space.add_default_collision_handler()

        # List of pairs (indexA,indexB), where indexA supports indexB
        supports = []
        generating = True

        def begin_handler(arbiter: pymunk.Arbiter, space: pymunk.Space, data):
            shapes = arbiter.shapes
            if generating:
                shapeA = self.get_index_of_shape(shapes[0])
                shapeB = self.get_index_of_shape(shapes[1])

                # Supporting happens from below
                # Static objects are not supported
                if arbiter.normal.angle_degrees > 45 and arbiter.normal.angle_degrees < 135:
                    if not is_static(self.objects[shapeB]):
                        supports.append((shapeA, shapeB))
                elif arbiter.normal.angle_degrees < -45 and arbiter.normal.angle_degrees > -135:
                    if not is_static(self.objects[shapeA]):
                        supports.append((shapeB, shapeA))

            return True
        collision_handler._set_begin(begin_handler)
        self.step()
        generating = False
        return supports

    def filter_supports(self, supports):
        # For each supporting object, check if other object would fall if supporter was removed
        # Should return a filtered list of supports
        # Need to copy space to not modify the original
        result = []
        for support in supports:
            space = copy.deepcopy(self.space)
            other_shape = space.shapes[support[1]]
            other_original = self.objects[support[1]]
            space.remove(space.shapes[support[0]])
            for _ in range(1000):
                space.step(0.01)
            location_change = other_shape.body.position.get_distance(
                (other_original[1], other_original[2]))
            if location_change > 1:
                result.append(support)
        return result

    def draw(self, file, space=None):
        if not space:
            space = self.space
        fig = plt.figure(figsize=(14, 10))
        ax = plt.axes(xlim=(-self.width, self.width), ylim=(-1, self.height))
        # ax = plt.axes(xlim=(0, 600), ylim=(0, 400))
        ax.set_aspect("equal")
        options = pymunk.matplotlib_util.DrawOptions(ax)
        space.debug_draw(options)
        fig.savefig(file, bbox_inches="tight")
        plt.close()
