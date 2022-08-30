import math

# A faulty CircleDrawer 

class BadCircleDrawer:
    def __init__(self):
        pass

    def computeTheta(self, x,y, x_centre, y_centre):
        return math.atan2(x-x_centre, y-y_centre)
    
    def sortedInsert(self, theList, x, y, x_centre, y_centre):
        for index, value in enumerate(theList):
            oldTheta = self.computeTheta(value[0],value[1],x_centre,y_centre)
            newTheta = self.computeTheta(x,y, x_centre, y_centre)
            if oldTheta > newTheta:
                theList.insert(index, (x,y))
                return theList
        theList.append((x,y))
        return theList


    def midPointCircleDraw(self,x_centre, y_centre, r): 

        x = r 
        y = 0
        points = []

        # Printing the initial point the  
        # axes after translation  
        points = self.sortedInsert( points, 
                                    x + x_centre, y + y_centre,
                                    x_centre, y_centre)  

        # When radius is zero only a single  
        # point be printed  
        if (r > 0) : 

            points = self.sortedInsert( points, 
                                    -x + x_centre, -y + y_centre,
                                    x_centre, y_centre)  

            points = self.sortedInsert( points, 
                                    y + x_centre,  x + y_centre, 
                                    x_centre, y_centre)  

            points = self.sortedInsert( points, 
                                    -y + x_centre, -x + y_centre,
                                    x_centre, y_centre)  

        # Initialising the value of P  
        P = 1 - r  


        while x > y: 

            y += 1

            # Mid-point inside or on the perimeter 
            if P <= 0:  
                P = P + 2 * y + 1

            # Mid-point outside the perimeter  
            else:          
                x -= 1
                P = P + 2 * y - 2 * x + 1

            # All the perimeter points have  
            # already been printed  
            if (x < y): 
                break

            # Printing the generated point its reflection  
            # in the other octants after translation  
            #points = self.sortedInsert( points,
            #                          x + x_centre, y + y_centre,
            #                          x_centre, y_centre)  

            #points = self.sortedInsert( points,
            #                          -x + x_centre, y + y_centre,
            #                          x_centre, y_centre) 

            #points = self.sortedInsert( points,
            #                          x + x_centre, -y + y_centre,
            #                          x_centre, y_centre) 
            #
            #points = self.sortedInsert( points,
            #                          -x + x_centre, -y + y_centre, 
            #                          x_centre, y_centre) 
            #
            #
            ## If the generated point on the line x = y then  
            ## the perimeter points have already been printed  
            #if x != y: 

            #    points = self.sortedInsert( points,
            #                              y + x_centre, x + y_centre,
            #                              x_centre, y_centre)  

            #    points = self.sortedInsert( points,
            #                              -y + x_centre, x + y_centre,
            #                              x_centre, y_centre) 

            #    points = self.sortedInsert( points,
            #                              y + x_centre, -x + y_centre,
            #                              x_centre, y_centre) 

            #    points = self.sortedInsert( points,
            #                              -y + x_centre, -x + y_centre, 
            #                              x_centre, y_centre) 


        #repeat the first point to make the circle complete
        points.append(points[0])

        return points

    def draw_circles(self, inputs):
        circles = []
        for x,y,r in inputs:
            circle = self.midPointCircleDraw(x,y,r)
            circles.append( circle )
        return circles

