// Declare Memory for Global Distribution Parameters
// Declare Memory for the Number of Triangle Models min and max
int minNumberOfTriangleModels;
int maxNumberOfTriangleModels;
// Declare Memory for the NUmber of Triangles which will been derived from the Models min and max
int minNumberOfEntitiesOfTriangleModels;
int maxNumberOfEntitiesOfTriangleModels;

// Declare Memory for the Canvas Model
CanvasModel can; 

// Setup the Program Enviroment
void setup()
{
  // Declare a Canvas of 800 x 500 Pixels
  size(800, 500);
  
  // Initalize the Global Distribution Parameters
  // Set the min to 1 and the max to 6 Triangle Models as Default
  minNumberOfTriangleModels = 1;
  maxNumberOfTriangleModels = 6;
  // Set the min to 1 and the max to 6 Derived Triangles from every Triangle Model as Default
  minNumberOfEntitiesOfTriangleModels = 1;
  maxNumberOfEntitiesOfTriangleModels = 6;
  
  // Great the user
  greating();
  
  // Show the Menue
  menue();
  
  // Show the Distribution Parameters
  status();
  
}

// Declare a dummy draw Method to enable the Key Pressed Menue
void draw()
{
}

// Declare a Class to handle the delta Points as transformation Vectors
class DeltaPoint
{
  // Declare Memory for the delta dimmensions of the translation Vector
  float dx, dy;
  
  // Constructor Method which create a random translation Vector
  DeltaPoint()
  {
    // Set for X and Y Dimmension a Random Parameter between -1 and +1
    dx = random(2)-1;
    dy = random(2)-1;
  }
}

// Class to handle the Position of an Element
class Position
{
  // Position of a Element as Integer Values of a Location vector
  int x, y;
  
  // Constructor for a Position of an Element
  Position(int xx, int yy)
  {
    // Copy Parameters from Input to Class Atributes
    x = xx;
    y = yy;
  }
  
  // Constructor for a random Position
  Position()
  {
    // Choose a Position across the whole Canvas
    x = int(random(width));
    y = int(random(height));
  }
}

// Class to handle a whole Triangle
class Triangle
{
  // Declare Memory for the Shape Coordinates of the Triangle as translation Vectors
  DeltaPoint a, b, c;
  // Declare Memory for the Triangle
  color col;
  // Declare Memory for the Size of the Triangle
  int sice;
  
  // Constructor for a new random Triangle
  Triangle()
  {
    // Choose a random Color for the Triangle
    col =  color(int(random(255)), int(random(255)), int(random(255)));
    // Choose a random Size for the Triangle
    sice = int(random(min(width, height)/6));
    
    // Choose the Delta Vectors for the Triangle
    a = new DeltaPoint();
    b = new DeltaPoint();
    c = new DeltaPoint();
  }
  
  // Method to draw the Triangle
  // accepts the Position for the Triangle
  void drawing(Position pos)
  {
    // Set the Filling to the color of the Triangle
    fill(col);
    
    // Draw the Triangle by calculating the Corners of it 
    triangle( (a.dx*sice)+pos.x, (a.dy*sice)+pos.y,
      (b.dx*sice)+pos.x, (b.dy*sice)+pos.y,
      (c.dx*sice)+pos.x, (c.dy*sice)+pos.y);
      
  }
}

// Class to handle the Model for the Canvas
class CanvasModel
{
  // Declare a Conmtainer for the Triangle Models
  ArrayList<Triangle> triangles = new ArrayList<Triangle>();
  
  // Constructor for the Model of the Canvas
  CanvasModel()
  {
    // Choose a Number of Triangle Models from the Distribution Parameters of it
    int m = int( random(maxNumberOfTriangleModels-minNumberOfTriangleModels)+minNumberOfTriangleModels);
    // Iterrate about the choosen Number of Triangle Models 
    for(int n = 0; n < m; n++)
    {
      // Construct a new Triangle Model
      triangles.add( new Triangle());
    }
  }
  
  // Method to draw a new Image from the Canvas Model
  void newDrawing()
  {
    // Clear the Background to withe
    background(255);
    // Calls the central Drawing Method for the Canvas
    drawing();
  }
  
  // Method to draw a new Element / Triangle
  // accepts a Triangle Model 
  void drawingElement(Triangle tri)
  {
    // Choose the Number of Triangle Instances Created from the given Model
    int m = int(random(maxNumberOfEntitiesOfTriangleModels-minNumberOfEntitiesOfTriangleModels)+minNumberOfEntitiesOfTriangleModels);
    // Iterate about the Numbe of Triangle Instances
    for( int n = 0; n < m; n++)
    {
      // Choose a random Position for the Triangle Instance
      Position pos = new Position();
      // Draws a Triangle Instance at the choosen Position
      tri.drawing(pos);
    }
  }
  
  // Method to draw the Canvas Model even to a forgiven other Drawing Result
  void drawing()
  {
  // Iterratzes about the Triangle Models
  for (Triangle triangle : triangles) {
    // Call the Drawing Method to the actual Triangle Model
    drawingElement( triangle );
    }
  }
}

// KeyPressed Menue Control
void keyPressed()
{
  char c = key;
  switch(c)
  {
    // Create a new Canvas Model by Pressing n
    case 'n': can = new CanvasModel(); break;
    // Give a new Set of Triangles to the Canvas by Pressing m
    case 'm': can.drawing(); break;
    // Clear the Canvas and draw a new Triangle Set by Pressing the , (Comma )
    case ',': can.newDrawing(); break;
    
    // Controll about the Min NUmber of the Distribution Parameters
    // Controll the min of the Triangle Models
    case 'q': minNumberOfTriangleModels += 1; break;
    case 'a': if( minNumberOfTriangleModels > 1) { minNumberOfTriangleModels -= 1;} break;
    // Controll the min of the derived Instances from the Models
    case 'w': minNumberOfEntitiesOfTriangleModels += 1; break;
    case 's': if( minNumberOfEntitiesOfTriangleModels > 1){ minNumberOfEntitiesOfTriangleModels -= 1;} break;
 
    // Controll the Max Number of the Distribution Parameters
    // Controll the max of the Triangle Models
    case 'e': maxNumberOfTriangleModels += 1; break;
    case 'd': if( maxNumberOfTriangleModels > 1) {maxNumberOfTriangleModels -= 1;} break;
    // Controll the max of the derived Instancs from the Models
    case 'r': maxNumberOfEntitiesOfTriangleModels += 1; break;
    case 'f': if( maxNumberOfEntitiesOfTriangleModels > 1) {maxNumberOfEntitiesOfTriangleModels -= 1;} break;
    
    // Save the actual Image to a png File by Pressimg the x 
    case 'x': save("SerialismTriangleDrawing.png");
  }
  // Reshowing the Menue 
  menue();
  // Show the Status of the Derivation Parameters
  status();
}

// Prsenting the User a Menue Interface
void menue()
{
  println(" You can generate a new Model of Serialism Triangles by pressing n");
  println(" You can draw a new Canvas with Triangles by pressing the , ( Comma )");
  println(" You can add a new Set of Serialism Triangles by pressing the m");
  
  println(" You can increase by q and decrease by a the Number of maximal Triangle Models");
  println(" You can increase by w and decrease by s the Number of maximal Triangle Instances from each Triangle Model");
  
  
  println(" You can increase by q and decrease by a the Number of minimal Triangle Models");
  println(" You can increase by w and decrease by s the Number of minimal Triangle Instances from each Triangle Model");
}

// Method to Show the Status of the Distribution Parameters
void status()
{
  println(" The Status of the derivation Parameters are:");
  println(" The Number of to generate Triangle Models are");
  println( minNumberOfTriangleModels + " To " + maxNumberOfTriangleModels);
  println(" The Number of to derivate Triangles Instances ");
  println(" from each Triangle Model are ");
  println( minNumberOfEntitiesOfTriangleModels + " To " + maxNumberOfEntitiesOfTriangleModels);
}

// Greating the User Method
void greatinng()
{
  // Explain the Program and great the User
  println(" Welcome to the Serialism Triangle Drawer ");
  println(" ----------------------------------------- ");
  println(" With this Program you can draw Triangles in ");
  println(" Serialism Style ");
}
