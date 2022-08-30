import math

# Adapted from:  
# https://www.geeksforgeeks.org/mid-point-circle-drawing-algorithm/

# This is identical to that of SlowCircleDrawer
# So you can accelerate it!


class MyCircleDrawer:
    def __init__(self):
        pass
        

    def computeTheta(self, x,y, x_centre, y_centre):
        return math.atan2(x-x_centre, y-y_centre)
    
    def sortedInsert(self, pdict, x, y, x_centre, y_centre):# newTheta):
        newTheta = math.degrees(math.atan2(x-x_centre, y-y_centre))
        if(0<newTheta<180):
            
            for index in range(len(pdict["points1"])):
            
            #oldTheta = self.computeTheta(value[0],value[1],x_centre,y_centre)
                if pdict["thetas1"][index] > newTheta:
                    pdict["points1"].insert(index, (x,y))
                    pdict["thetas1"].insert(index, newTheta)
                    return pdict
            pdict["points1"].append((x,y))
            pdict["thetas1"].append(newTheta)
        else:
            
            for index in range(len(pdict["points2"])):
            
            #oldTheta = self.computeTheta(value[0],value[1],x_centre,y_centre)
                if pdict["thetas2"][index] > newTheta:
                    pdict["points2"].insert(index, (x,y))
                    pdict["thetas2"].insert(index, newTheta)
                    return pdict
            pdict["points2"].append((x,y))
            pdict["thetas2"].append(newTheta)
        
        return pdict


    def midPointCircleDraw(self,x_centre, y_centre, r): 

        x = r 
        y = 0
        ptDict = {"points1":list(), "points2":list(), "thetas1":list(), "thetas2":list()}
        #ptDict = dict()
       # points = []
       # thetas = []

        # Printing the initial point the  
        # axes after translation  
        #newTheta = math.degrees( math.atan2(x, y))

        ptDict = self.sortedInsert( ptDict,
                                    x + x_centre, y + y_centre,
                                    x_centre, y_centre)
                                    #newTheta)
        
        # When radius is zero only a single  
        # point be printed  
        if (r > 0) : 

            ptDict = self.sortedInsert(  ptDict,
                                    -x + x_centre, -y + y_centre,
                                     x_centre, y_centre)
                                #    180-newTheta)  
            
            ptDict = self.sortedInsert(  ptDict,
                                    y + x_centre,  x + y_centre,
                                    x_centre, y_centre)
                                #    90-newTheta)  
            
            ptDict = self.sortedInsert(  ptDict,
                                    -y + x_centre, -x + y_centre,
                                     x_centre, y_centre)
                                       #      270-newTheta)  
            
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

          #  print(str(x)+", "+str(y)+", "+ str(P))

            # All the perimeter points have  
            # already been printed  
            if (x < y): 
                break

            # Printing the generated point its reflection  
            # in the other octants after translation
           # newTheta = math.degrees(math.atan2(x, y))
            ptDict = self.sortedInsert(  ptDict,
                                      x + x_centre, y + y_centre,
                                       x_centre, y_centre)
                                     # newTheta)  
            
            ptDict = self.sortedInsert(  ptDict,
                                      -x + x_centre, y + y_centre,
                                       x_centre, y_centre)
                                     # 180-newTheta) 
            
            ptDict = self.sortedInsert(  ptDict,
                                      x + x_centre, -y + y_centre,
                                       x_centre, y_centre)
                                     # 360-newTheta) 
            
            ptDict = self.sortedInsert( ptDict,
                                      -x + x_centre, -y + y_centre,
                                       x_centre, y_centre)
                                    #  180+newTheta) 
            



            # If the generated point on the line x = y then  
            # the perimeter points have already been printed  
            if x != y: 

                ptDict = self.sortedInsert( ptDict,
                                          y + x_centre, x + y_centre,
                                           x_centre, y_centre)
                                     #    90-newTheta)
                
                ptDict = self.sortedInsert( ptDict,
                                          -y + x_centre, x + y_centre,
                                           x_centre, y_centre)
                                      #    270+newTheta)   
                
                ptDict = self.sortedInsert( ptDict,
                                          y + x_centre, -x + y_centre,
                                           x_centre, y_centre)
                                       #   90+newTheta) 
                    
                ptDict = self.sortedInsert( ptDict,
                                          -y + x_centre, -x + y_centre, 
                                           x_centre, y_centre)
                                       #   270-newTheta)                            


        #repeat the first point to make the circle complete
        
        
        ptDict["points1"].append(ptDict["points2"][-1])
        ptDict["points2"].pop(-1)
        
        #print(ptDict["points2"])
        #print(ptDict["points1"])
        ptDict["points2"].extend(ptDict["points1"])
        #print(ptDict["points2"])
        return ptDict["points2"]

    def draw_circles(self, inputs):
        circles = []
        for x,y,r in inputs:
            circle = self.midPointCircleDraw(x,y,r)
            circles.append( circle )
        return circles
