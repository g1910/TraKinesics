function MouseLeftClick( pointer, x, y )
    import java.awt.event.* ;
    pointer.mouseMove(x, y) ;
    pointer.mousePress(InputEvent.BUTTON1_MASK) ;
    pointer.mouseRelease(InputEvent.BUTTON1_MASK) ;
end

