//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

class DieSide {
    var value: Int
    var count: Int
    var points: Int
    var counted: Bool = false

    init(value: Int, count: Int, points: Int) {
        self.value = value
        self.count = count
        self.points = points
    }
}

class Die: SKSpriteNode {
    var selected: Bool = false
    var selectable: Bool = true
    //var value: Int = Int()
    var currentPosition: CGPoint = CGPoint()
    var homePosition: CGPoint = CGPoint()
}

class GameScene: SKScene, SKPhysicsContactDelegate {

    var straight = false
    var fullHouse = false
    var threePair = false
    var threeOAK: Bool = false
    var fourOAK: Bool = false
    var fiveOAK: Bool = false
    var sixOAK: Bool = false
    var pairs = 0
    
    let physicsContactDelegate = self
    
    var currentDiceArray: [Die] = [Die]()
    var currentDie: Die = Die()
    
    var die1: Die = Die()
    var die2: Die = Die()
    var die3: Die = Die()
    var die4: Die = Die()
    var die5: Die = Die()
    var die6: Die = Die()
    
    var dieSidesArray: [DieSide] = [DieSide]()
    var dieSide1: DieSide?
    var dieSide2: DieSide?
    var dieSide3: DieSide?
    var dieSide4: DieSide?
    var dieSide5: DieSide?
    var dieSide6: DieSide?
    
    var currentRollScore: Int = Int()
    var score: Int = Int()
    
    var currentRollArray: [DieSide] = [DieSide]()
    var diePositionsArray: [CGPoint] = [CGPoint]()
    var dieHomeLocationArray: [CGPoint] = [CGPoint]()
    
    let lowStraight: [Int] = [1,2,3,4,5]
    let highStraight: [Int] = [2,3,4,5,6]
    let sixDieStraight: [Int] = [1,2,3,4,5,6]
    
    var diePosition1: CGPoint = CGPoint()
    var diePosition2: CGPoint = CGPoint()
    var diePosition3: CGPoint = CGPoint()
    var diePosition4: CGPoint = CGPoint()
    var diePosition5: CGPoint = CGPoint()
    var diePosition6: CGPoint = CGPoint()
    
    var gameTable: SKSpriteNode = SKSpriteNode()
    
    var hasScoringDice: Bool = false
    
    var ones = 0
    var twos = 0
    var threes = 0
    var fours = 0
    var fives = 0
    var sixes = 0

    override func didMove(to view: SKView) {
        setupGameScene()
        setupGameElements()

        currentRoll: repeat {
            //for die in currentDiceArray {
                rollDice()
                newRoll()
                print("has scoring dice: \(hasScoringDice)")
            //}
        } while !hasScoringDice
    }
    
    func setupGameScene() {
        //setupGameTable()
        
    }
    
    func setupGameElements() {
        setupDice()
        setupdieSidesArray()
        //setupDieHomeLocations()
    }
    
    func rollDice() {
        getDieSides()
        calcDieRoll()
    }
    
    func getDieSides() {
        for die in currentDiceArray where die.selectable {
            let value = Int(arc4random_uniform(6)+1)
            
            switch value {
            case 1:
                dieSidesArray[value - 1].count += 1
                currentRollArray.append(dieSide1!)
                hasScoringDice = true
            case 2:
                dieSidesArray[value - 1].count += 1
                currentRollArray.append(dieSide2!)
            case 3:
                dieSidesArray[value - 1].count += 1
                currentRollArray.append(dieSide3!)
            case 4:
                dieSidesArray[value - 1].count += 1
                currentRollArray.append(dieSide4!)
            case 5:
                dieSidesArray[value - 1].count += 1
                currentRollArray.append(dieSide5!)
                hasScoringDice = true
            case 6:
                dieSidesArray[value - 1].count += 1
                currentRollArray.append(dieSide6!)
            default:
                break
            }
        }
        for die in currentRollArray {
            print("current Roll: \(die.value), count: \(die.count)")
        }
    }
    
    func calcDieRoll() {
        hasScoringDice = checkForStraight()
        if hasScoringDice {
            hasScoringDice = checkForLikeDice()
        } else {
            hasScoringDice = checkForPairs()
        }
        
        if hasScoringDice {
            //checkForFullHouse()
            hasScoringDice = checkForScoringDice()
        }
        if hasScoringDice {
            showScoreTotal()
        }
        var id = 0
        for die in currentRollArray where die.counted {
            currentRollArray.remove(at: id)
            if currentRollArray.count == 0 {
                print("start new roll")
                break
            } else {
                id += 1
            }
        }
    }

    func newRoll() {
        hasScoringDice = false
        
        for die in currentRollArray {
            die.count = 0
            die.counted = false
        }
        
        currentRollArray.removeAll()
        
        currentRollScore = 0
        straight = false
        fullHouse = false
        threeOAK = false
        fourOAK = false
        fiveOAK = false
        sixOAK = false
        threePair = false
        pairs = 0
        
        ones = 0
        twos = 0
        threes = 0
        fours = 0
        fives = 0
        sixes = 0
    }
    
    func checkForStraight() -> Bool {
        var dieValues = [Int]()
        for die in currentRollArray where die.counted == false {
            dieValues.append(die.value)
        }
        dieValues = dieValues.sorted()
        
        if dieValues ==  [1,2,3,4,5] || dieValues == [2,3,4,5,6] || dieValues == [1,2,3,4,5,6] {
            currentRollScore += 1500
            straight = true
            hasScoringDice = true
        }
        if straight {
            for die in currentRollArray {
                die.counted = true
            }
        }
        //showScoreTotal()
        return hasScoringDice
    }
    
    func checkForLikeDice() -> Bool {
        for die in currentRollArray where die.count == 3 {
            if !die.counted {
                currentRollScore += die.points * 100
                die.counted = true
            }
            threeOAK = true
            hasScoringDice = true
        }
        for die in currentRollArray where die.count == 4 {
            if !die.counted {
                currentRollScore += (die.points * 100) * 2
                die.counted = true
            }
            fourOAK = true
            hasScoringDice = true
        }
        for die in currentRollArray where die.count == 5 {
            if !die.counted {
                currentRollScore += (die.points * 100) * 3
            die.counted = true
            }
            fiveOAK = true
            hasScoringDice = true
        }
        for die in currentRollArray where die.count == 6 {
            if !die.counted {
                currentRollScore += (die.points * 100) * 4
                die.counted = true
            }
            sixOAK = true
            hasScoringDice = true
        }
       // showScoreTotal()
        return hasScoringDice
    }
    
    func checkForPairs() -> Bool {
        for die in currentRollArray where die.count == 2 {
            pairs += 1
        }
        if pairs == 1 && threeOAK == true {
            currentRollScore += 750
            threeOAK = false
            fullHouse = true
            hasScoringDice = true
        }
        if pairs == 3 {
            currentRollScore += 500
            threePair = true
            for die in currentRollArray {
                die.counted = true
            }
            hasScoringDice = true
        }
        for die in currentRollArray where die.count == 2 {
            if !fullHouse {
                if die.value == 1 {
                    currentRollScore += 100
                    die.counted = true
                    hasScoringDice = true
                } else if die.value == 5 {
                    currentRollScore += 50
                    die.counted = true
                    hasScoringDice = true
                }
            }
        }
        //showScoreTotal()
        return hasScoringDice
    }
    
    func checkForFullHouse() -> Bool {
        if threeOAK == true && pairs == 1{
            currentRollScore += 750
            threeOAK = false
            fullHouse = true
            hasScoringDice = true
        }
        //showScoreTotal()
        return hasScoringDice
    }
    
    func checkForScoringDice() -> Bool {
        for die in currentRollArray where !die.counted {
            if die.value == 1 {
                currentRollScore += 100
                hasScoringDice = true
                //die.counted = true
            } else if die.value == 5 {
                currentRollScore += 50
                hasScoringDice = true
                //die.counted = true
            }
        }
        return hasScoringDice
    }
    
    func showScoreTotal() {
        if currentRollScore == 0 {
            hasScoringDice = false
        }
        score += currentRollScore
        print("current roll score: \(currentRollScore)")
        currentRollScore = 0
        print("current Score: \(score)")
    }
    
    /*
    func setupGameTable() {
        gameTable = SKSpriteNode(imageNamed: "WindowPopup")
        gameTable.name = "Game Table"
        gameTable.zPosition = 5
        gameTable.size = CGSize(width: frame.size.width - 75, height: frame.size.height + 20)
        gameTable.position = CGPoint(x: (self.frame.maxX - (frame.size.width / 2) + 40), y: 0)
        gameTable.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: gameTable.frame.minX - 15, y: gameTable.frame.minY + 40), size: CGSize(width: gameTable.size.width - 140, height: gameTable.size.height - 80)))
        gameTable.physicsBody?.affectedByGravity = false
        gameTable.physicsBody?.allowsRotation = false
        gameTable.physicsBody?.isDynamic = true
        gameTable.physicsBody?.restitution = 0.75
        
        gameTable.physicsBody?.categoryBitMask = 1
        gameTable.physicsBody?.collisionBitMask = 1
        gameTable.physicsBody?.contactTestBitMask = 1
    }
     */
    
    func setupDice() {
        let die1 = Die()
        die1.name = "Die 1"
        let die2 = Die()
        die2.name = "Die 2"
        let die3 = Die()
        die3.name = "Die 3"
        let die4 = Die()
        die4.name = "Die 4"
        let die5 = Die()
        die5.name = "Die 5"
        let die6 = Die()
        die6.name = "Die 6"
        
        currentDiceArray = [die1, die2, die3, die4, die5]
        for die in currentDiceArray {
            currentDie = die
            currentDie.zPosition = 1
            currentDie.zRotation = 0
            currentDie.size = CGSize(width: 64, height: 64)
            
            currentDie.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
            currentDie.physicsBody?.affectedByGravity = false
            currentDie.physicsBody?.isDynamic = true
            currentDie.physicsBody?.allowsRotation = true
            currentDie.physicsBody?.categoryBitMask = 1
            currentDie.physicsBody?.contactTestBitMask = 1
            currentDie.physicsBody?.collisionBitMask = 1
            currentDie.physicsBody?.restitution = 0.5
            currentDie.physicsBody?.linearDamping = 4
            currentDie.physicsBody?.angularDamping = 5

            currentDie.selected = false
            currentDie.selectable = true
            //currentDie.value = 0
            //self.addChild(currentDie)
        }
    }
    
    func setupdieSidesArray() {
        dieSide1 = DieSide(value: 1, count: 0, points: 10)
        dieSide2 = DieSide(value: 2, count: 0, points: 2)
        dieSide3 = DieSide(value: 3, count: 0, points: 3)
        dieSide4 = DieSide(value: 4, count: 0, points: 4)
        dieSide5 = DieSide(value: 5, count: 0, points: 5)
        dieSide6 = DieSide(value: 6, count: 0, points: 6)
        
        dieSidesArray = [dieSide1, dieSide2, dieSide3, dieSide4, dieSide5, dieSide6] as! [DieSide]
    }
    
    /*
    func setupDieHomeLocations() {
        for die in currentDiceArray {
            
            switch die.name {
            case "Die 1":
                diePosition1 = CGPoint(x: -(gameTable.size.width / 7), y: gameTable.frame.minY + 100)
                die1.texture = SKTexture(imageNamed: "Die1")
                die1.position = diePosition1
            case "Die 2":
                diePosition2 = CGPoint(x: die1.position.x + die2.size.width, y: gameTable.frame.minY + 100)
                //die2.texture = SKTexture(imageNamed: "Die2")
                die2.position = diePosition2
            case "Die 3":
                diePosition3 = CGPoint(x: die2.position.x + die3.size.width, y: gameTable.frame.minY + 100)
                //die3.texture = SKTexture(imageNamed: "Die3")
                die3.position = diePosition3
            case "Die 4":
                diePosition4 = CGPoint(x: die3.position.x + die4.size.width, y: gameTable.frame.minY + 100)
                //die4.texture = SKTexture(imageNamed: "Die4")
                die4.position = diePosition4
            case "Die 5":
                diePosition5 = CGPoint(x: die4.position.x + die5.size.width, y: gameTable.frame.minY + 100)
                //die5.texture = SKTexture(imageNamed: "Die5")
                die5.position = diePosition5
            case "Die 6":
                diePosition6 = CGPoint(x: die5.position.x + die6.size.width, y: gameTable.frame.minY + 100)
                //die6.texture = SKTexture(imageNamed: "Die6")
                die6.position = diePosition6
            default:
                break
            }

        }
        
    }
    */
    
   
    func touchDown(atPoint pos : CGPoint) {




        /*
        guard let n = spinnyNode.copy() as? SKShapeNode else { return }
        
        n.position = pos
        n.strokeColor = SKColor.green
        addChild(n)
        */
    }
    
    func touchMoved(toPoint pos : CGPoint) {





        /*
        guard let n = self.spinnyNode.copy() as? SKShapeNode else { return }
        
        n.position = pos
        n.strokeColor = SKColor.blue
        addChild(n)
        */
    }
    
    func touchUp(atPoint pos : CGPoint) {




        /*
        guard let n = spinnyNode.copy() as? SKShapeNode else { return }
        
        n.position = pos
        n.strokeColor = SKColor.red
        addChild(n)
        */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {



        /*
        for t in touches { touchDown(atPoint: t.location(in: self)) }
        */
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {




        /*
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
        */
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {




        /*
        for t in touches { touchUp(atPoint: t.location(in: self)) }
        */
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {




        /*
        for t in touches { touchUp(atPoint: t.location(in: self)) }
        */
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
