//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

class DieSide {
    var name: String
    var value: Int
    var count: Int
    var points: Int
    var counted: Bool = false

    init(name: String, value: Int, count: Int, points: Int) {
        self.name = name
        self.value = value
        self.count = count
        self.points = points
    }
}

class Die: SKSpriteNode {
    var selected: Bool = false
    var selectable: Bool = true
    var value: Int = Int()
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
    
    var defaultDiceArray: [Die] = [Die]()
    var currentDiceArray: [Die] = [Die]()
    var currentDie: Die = Die()
    
    var die1: Die = Die()
    var die2: Die = Die()
    var die3: Die = Die()
    var die4: Die = Die()
    var die5: Die = Die()
    var die6: Die = Die()
    
    var defaultDieSidesArray: [DieSide] = [DieSide]()
    var currentDieSidesArray: [DieSide] = [DieSide]()
    var dieSide1: DieSide?
    var dieSide2: DieSide?
    var dieSide3: DieSide?
    var dieSide4: DieSide?
    var dieSide5: DieSide?
    var dieSide6: DieSide?
    
    var currentRollScore: Int = Int()
    var score: Int = Int()
    
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
    
    var hasScoringDice: Bool = true
    
    override func didMove(to view: SKView) {
        setupGameScene()
        setupGameElements()

        while hasScoringDice || currentDiceArray.count != 0 {
            rollDice()
            print("has scoring dice: \(hasScoringDice)")
        }
        if !hasScoringDice {
            print("Farkle")
        } else {
            newRoll()
        }
    }
    
    func removeCountedDice() {
        for dieSide in currentDieSidesArray where dieSide.counted {
            let currentValue = dieSide.value
            
            for die in currentDiceArray {
                currentDiceArray.removeAll(where: { $0.value == currentValue })
                print("dieSide Value: \(dieSide.value)")
                print("die of Value: \(die.value) removed:")
            }
        }
        print("currentDiceArray Count: \(currentDiceArray.count)")
        for die in currentDiceArray {
            print("die of value: \(die.value)")
        }
        //print("Current Dice Array: \(currentDiceArray.enumerated())")
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
        currentDieSidesArray.removeAll()
        for _ in currentDiceArray {
            let value = Int(arc4random_uniform(6)+1)
            
            switch value {
            case 1:
                defaultDieSidesArray[value - 1].count += 1
                currentDieSidesArray.append(dieSide1!)
                hasScoringDice = true
            case 2:
                defaultDieSidesArray[value - 1].count += 1
                currentDieSidesArray.append(dieSide2!)
            case 3:
                defaultDieSidesArray[value - 1].count += 1
                currentDieSidesArray.append(dieSide3!)
            case 4:
                defaultDieSidesArray[value - 1].count += 1
                currentDieSidesArray.append(dieSide4!)
            case 5:
                defaultDieSidesArray[value - 1].count += 1
                currentDieSidesArray.append(dieSide5!)
                hasScoringDice = true
            case 6:
                defaultDieSidesArray[value - 1].count += 1
                currentDieSidesArray.append(dieSide6!)
            default:
                break
            }
        }
        for dieSide in currentDieSidesArray {
            print("current Roll: \(dieSide.value), count: \(dieSide.count)")
        }
    }
    
    func calcDieRoll() {
        hasScoringDice = checkForStraight()
        if straight {
            showScoreTotal()
            return
        }
        if hasScoringDice {
            hasScoringDice = checkForLikeDice()
        } else {
            hasScoringDice = checkForPairs()
        }
        if fiveOAK {
            showScoreTotal()
            return
        }
        if fullHouse {
            showScoreTotal()
            return
        }
        if hasScoringDice {
            hasScoringDice = checkForScoringDice()
        }
        if hasScoringDice {
            showScoreTotal()
        }
        if currentDiceArray.isEmpty {
            setupDice()
        }
        /*
        var id = 0
        for die in currentDieSidesArray {
            currentDieSidesArray.remove(at: id)
            if currentDieSidesArray.count == 0 {
                print("start new roll")
                break
            } else {
                id += 1
            }
        }
        */
        
    }

    func checkForStraight() -> Bool {
        var dieValues = [Int]()
        for dieSide in currentDieSidesArray where dieSide.counted == false {
            dieValues.append(dieSide.value)
        }
        dieValues = dieValues.sorted()
        
        if dieValues ==  [1,2,3,4,5] || dieValues == [2,3,4,5,6] || dieValues == [1,2,3,4,5,6] {
            currentRollScore += 1500
            straight = true
            hasScoringDice = true
            removeCountedDice()
        }
        //showScoreTotal()
        return hasScoringDice
    }
    
    func checkForLikeDice() -> Bool {
        for dieSide in currentDieSidesArray where dieSide.count == 3 {
            if !dieSide.counted {
                currentRollScore += dieSide.points * 100
                dieSide.counted = true
                if currentDiceArray.isEmpty {
                    setupDice()
                }
                removeCountedDice()
            }
            threeOAK = true
            hasScoringDice = true
            //showScoreTotal()
        }
        for dieSide in currentDieSidesArray where dieSide.count == 4 {
            if !dieSide.counted {
                currentRollScore += (dieSide.points * 100) * 2
                dieSide.counted = true
                if currentDiceArray.isEmpty {
                    setupDice()
                }
                removeCountedDice()
            }
            fourOAK = true
            hasScoringDice = true
            //showScoreTotal()
        }
        for dieSide in currentDieSidesArray where dieSide.count == 5 {
            if !dieSide.counted {
                currentRollScore += (dieSide.points * 100) * 3
                dieSide.counted = true
                if currentDiceArray.isEmpty {
                    setupDice()
                }
                removeCountedDice()
            }
            fiveOAK = true
            hasScoringDice = true
            //showScoreTotal()
        }
        for dieSide in currentDieSidesArray where dieSide.count == 6 {
            if !dieSide.counted {
                currentRollScore += (dieSide.points * 100) * 4
                dieSide.counted = true
                if currentDiceArray.isEmpty {
                    setupDice()
                }
                removeCountedDice()
            }
            sixOAK = true
            hasScoringDice = true
            //showScoreTotal()
        }
        return hasScoringDice
    }
    
    func checkForPairs() -> Bool {
        for dieSide in currentDieSidesArray where dieSide.count == 2 {
            pairs += 1
        }
        if pairs == 1 && threeOAK == true {
            currentRollScore += 750
            threeOAK = false
            fullHouse = true
            hasScoringDice = true
            //showScoreTotal()
        }
        if pairs == 3 {
            currentRollScore += 500
            threePair = true
            for dieSide in currentDieSidesArray {
                dieSide.counted = true
            }
            removeCountedDice()
            hasScoringDice = true
            //showScoreTotal()
       }
        for dieSide in currentDieSidesArray where dieSide.count == 2 {
            if !fullHouse {
                if dieSide.value == 1 {
                    currentRollScore += 100
                    dieSide.counted = true
                    if currentDiceArray.isEmpty {
                        setupDice()
                    }
                    removeCountedDice()
                    hasScoringDice = true
                } else if dieSide.value == 5 {
                    currentRollScore += 50
                    dieSide.counted = true
                    if currentDiceArray.isEmpty {
                        setupDice()
                    }
                    removeCountedDice()
                    hasScoringDice = true
                }
                //showScoreTotal()
            }
        }
        return hasScoringDice
    }
    
    func checkForFullHouse() -> Bool {
        if threeOAK == true && pairs == 1{
            currentRollScore += 750
            threeOAK = false
            fullHouse = true
            hasScoringDice = true
            //showScoreTotal()
        }
        return hasScoringDice
    }
    
    func checkForScoringDice() -> Bool {
        for dieSide in currentDieSidesArray where !dieSide.counted {
            if dieSide.value == 1 {
                currentRollScore += (100 * dieSide.count)
                hasScoringDice = true
                dieSide.counted = true
                if currentDiceArray.isEmpty {
                    setupDice()
                }
                //showScoreTotal()
            } else if dieSide.value == 5 {
                currentRollScore += (50 * dieSide.count)
                hasScoringDice = true
                dieSide.counted = true
                removeCountedDice()
                if currentDiceArray.isEmpty {
                    setupDice()
                }
                //showScoreTotal()
            }
            removeCountedDice()
        }
        return hasScoringDice
    }
    
    func newRoll() {
        hasScoringDice = false
        currentDieSidesArray.removeAll()

        resetDice()
        setupdieSidesArray()

        currentRollScore = 0
        straight = false
        fullHouse = false
        threeOAK = false
        fourOAK = false
        fiveOAK = false
        sixOAK = false
        threePair = false
        pairs = 0
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
        die1.value = 1
        let die2 = Die()
        die2.name = "Die 2"
        die2.value = 2
        let die3 = Die()
        die3.name = "Die 3"
        die3.value = 3
        let die4 = Die()
        die4.name = "Die 4"
        die4.value = 4
        let die5 = Die()
        die5.name = "Die 5"
        die5.value = 5
        let die6 = Die()
        die6.name = "Die 6"
        die6.value = 6
        
        defaultDiceArray = [die1, die2, die3, die4, die5]
        
        currentDiceArray = defaultDiceArray
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
        }
    }
    
    func resetDice() {
        currentDiceArray = defaultDiceArray
        for die in currentDiceArray {
            currentDie = die
            currentDie.selected = false
            currentDie.selectable = true
        }
    }
    
    func setupdieSidesArray() {
        dieSide1 = DieSide(name: "Die 1", value: 1, count: 0, points: 10)
        dieSide2 = DieSide(name: "Die 2", value: 2, count: 0, points: 2)
        dieSide3 = DieSide(name: "Die 3", value: 3, count: 0, points: 3)
        dieSide4 = DieSide(name: "Die 4", value: 4, count: 0, points: 4)
        dieSide5 = DieSide(name: "Die 5", value: 5, count: 0, points: 5)
        dieSide6 = DieSide(name: "Die 6", value: 6, count: 0, points: 6)
        
        defaultDieSidesArray = [dieSide1, dieSide2, dieSide3, dieSide4, dieSide5, dieSide6] as! [DieSide]
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
