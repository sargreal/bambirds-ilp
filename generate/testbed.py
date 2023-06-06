import pymunk
from pymunk import Vec2d
import random
import matplotlib.pyplot as plt
import pymunk.matplotlib_util
from ItarusAves import make_structure, blocks
import math
import copy

def distance(coordA,coordB):
    return math.sqrt((coordA[0]-coordB[0])**2 + (coordA[1]-coordB[1])**2)

def coords(object):
    return (object[1],object[2])

def remove_duplicates(objects):
    result = []
    for i in objects:
        exists = False
        for j in result:
            dist = distance(coords(i),coords(j))
            if dist < 0.01:
                exists = True
                break
        if not exists:
            result.append(i)
    return result

def add_itarus_objects_to_space(objects: list,space:pymunk.Space):
    shapes = []
    for object in objects:
        mass = 10.0
        dimensions = blocks[str(object[0])]
        moment = pymunk.moment_for_box(mass, dimensions)
        body = pymunk.Body(mass, moment)
        body.position = Vec2d(object[1], object[2])
        shape = pymunk.Poly.create_box(body, dimensions)
        shape.friction = 0.3
        shape.color = (180, 180, 0, 255)
        space.add(body, shape)
        shapes.append(shape)
    return shapes


class TestBed:
    def __init__(self, width, height, max_steps, remove=False, min_percent=0.8, seed=None):
        self.max_steps = max_steps
        self.seed = seed
        self.running = True
        self.drawing = True
        self.random = random.Random(seed)
        self.width = width
        self.height = height 
        self.remove = remove
        self.min_percent = min_percent
        self.objects:list[(int,int,int)] = []
        self.shapes:list[pymunk.Shape] = []
        self.create_sb_world()
        # self.create_world()

    def create_world(self):
        self.space = pymunk.Space()
        self.space.gravity = Vec2d(0.0, -9.0)
        self.space.sleep_time_threshold = 0.3

        static_lines = [
            pymunk.Segment(self.space.static_body, Vec2d(20, 55), Vec2d(600, 55), 1),
            pymunk.Segment(self.space.static_body, Vec2d(550, 55), Vec2d(550, 400), 1),
        ]
        for l in static_lines:
            l.friction = 0.3
        self.space.add(*static_lines)

        for x in range(5):
            for y in range(10):
                size = 20
                mass = 1
                moment = pymunk.moment_for_box(mass, (size, size))
                body = pymunk.Body(mass, moment)
                body.position = Vec2d(300 + x * 50, 55  + (y+0.5) * (size + 0.1))
                shape = pymunk.Poly.create_box(body, (size, size))
                shape.friction = 0.3
                self.objects.append([1,body.position.x,body.position.y])
                self.shapes.append(shape)
                self.space.add(body, shape)

    def create_sb_world(self):
        ### Init pymunk and create space
        self.space = pymunk.Space()
        self.space.gravity = (0.0, -9.0)
        self.space.sleep_time_threshold = 0.3
        self.space.collision_slop = 0.01
        ### ground
        shape = pymunk.Segment(self.space.static_body, (-self.width, -1), (self.width, -1), 1.0)
        shape.friction = 1.0
        shape.color = (0, 0, 0, 255)
        self.space.add(shape)


        #### Structure
        self.objects,_,_ = make_structure(0,0,self.width,self.height, self.random)
        if self.remove:
            total = len(self.objects)
            min_count = min(1,int(self.min_percent * total))
            count = self.random.randint(min_count,total)
            self.objects = self.random.sample(self.objects, k=count)
        self.shapes = add_itarus_objects_to_space(self.objects,self.space)

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
            distance = shape.body.position.get_distance((object[1], object[2]))
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
                if type(shapes[0]) == pymunk.Poly and type(shapes[1]) == pymunk.Poly:
                    shapeA = self.get_index_of_shape(shapes[0])
                    shapeB = self.get_index_of_shape(shapes[1])
                    
                    if arbiter.normal.angle_degrees > 45 and  arbiter.normal.angle_degrees < 135:
                        supports.append((shapeA,shapeB))
                    elif arbiter.normal.angle_degrees < -45 and  arbiter.normal.angle_degrees > -135:
                        supports.append((shapeB,shapeA))
                elif type(shapes[0]) == pymunk.Segment or type(shapes[1]) == pymunk.Segment:
                    shape = self.get_index_of_shape(shapes[1]) if type(shapes[0]) == pymunk.Segment else self.get_index_of_shape(shapes[0])
                    supports.append(("ground",shape))
            
            return True
        collision_handler._set_begin(begin_handler)
        self.step()
        generating = False
        return supports

    def draw(self, file):
        fig = plt.figure(figsize=(14, 10))
        ax = plt.axes(xlim=(-self.width, self.width), ylim=(-1, self.height))
        # ax = plt.axes(xlim=(0, 600), ylim=(0, 400))
        ax.set_aspect("equal")
        options = pymunk.matplotlib_util.DrawOptions(ax)
        self.space.debug_draw(options)
        fig.savefig(file, bbox_inches="tight")
        plt.close()
