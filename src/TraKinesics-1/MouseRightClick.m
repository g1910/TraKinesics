function MouseRightClick( pointer, x, y )
    import java.awt.event.* ;
    pointer.mouseMove(x, y) ;
    pointer.mousePress(InputEvent.BUTTON3_MASK) ;
    pointer.mouseRelease(InputEvent.BUTTON3_MASK) ;
end

