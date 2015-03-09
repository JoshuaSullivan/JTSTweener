JTSTweener
==========
JTSTweener is a simple numeric tweening class allowing block-based animation of properties not supported by UIView or CAAnimation.

*CAUTION:* Be aware that storing references to tweener objects that have progress and completion blocks referencing the creating classes is a stupendous way to create a retain cycle. You do not need to store a reference to the tweener object unless you need the ability to pause or cancel it outside of the progress block invocation. If you do store a reference to a tweener, be sure you're only capturing weak references to self. 

When a tweener is complete, it will automatically destroy its stored blocks. At this point, the tweener is useless and should be discarded.
