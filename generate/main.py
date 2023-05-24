from testbed import TestBed


if __name__ == "__main__":
    tb = TestBed(5,5,50,True, seed=None)
    tb.draw('before.png')
    tb.run()
    print(tb.compare())
    tb.draw('after.png')

    print(len(tb.space.bodies))