## 区块链原理  
1. 基本概念  
区块链是一种分布式账本技术，它由一个个数据块组成链条，每个块包含一定时间内的交易信息，并且通过加密算法与前一个块相连，形成不可篡改、可追溯的链式结构。

2. 核心原理  
分布式账本：区块链网络中的每个节点都保存着一份完整的账本副本，账本上记录了所有的交易信息。当有新的交易发生时，需要经过网络中多数节点的验证和确认才能被记录到账本中。  
加密技术：使用哈希算法（如 SHA - 256）对每个数据块进行加密，生成唯一的哈希值。哈希值不仅可以验证数据的完整性，还用于将各个数据块链接起来。每个块的哈希值包含了前一个块的哈希值，一旦某个块的数据被篡改，其哈希值就会改变，后续所有块的哈希值也会随之改变，从而使篡改行为很容易被发现。   
共识机制：为了保证分布式账本的一致性和可靠性，区块链网络需要一种共识机制来决定哪个节点有权添加新的区块。常见的共识机制有工作量证明（PoW）、权益证明（PoS）、委托权益证明（DPoS）等。   
智能合约：是一种自动执行的合约，它以代码的形式存在于区块链上。当满足预设的条件时，智能合约会自动执行相应的操作，无需第三方干预。   


## Java 实现简单区块链项目    
以下是一个使用 Java 实现简单区块链的示例代码：     
java-blockchain-example       
Java 实现简单区块链项目 V1  
生成 BlockchainExample.java   
代码说明       
Block 类：表示区块链中的一个区块，包含区块的哈希值、前一个区块的哈希值、数据和时间戳。calculateHash 方法用于计算区块的哈希值。     
Blockchain 类：表示整个区块链，包含一个区块列表。createGenesisBlock 方法用于创建创世区块，addBlock 方法用于添加新的区块，isChainValid 方法用于验证区块链的完整性。     
BlockchainExample 类：主类，用于测试区块链的功能。创建一个区块链实例，添加几个区块，并验证区块链的完整性。   
这个示例只是一个简单的区块链实现，实际的区块链项目要复杂得多，需要考虑更多的因素，如共识机制、网络通信、智能合约等。    


```
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

// 区块类
class Block {
    public String hash;
    public String previousHash;
    private String data;
    private long timeStamp;

    public Block(String data, String previousHash, long timeStamp) {
        this.data = data;
        this.previousHash = previousHash;
        this.timeStamp = timeStamp;
        this.hash = calculateHash();
    }

    // 计算区块的哈希值
    public String calculateHash() {
        String dataToHash = previousHash + Long.toString(timeStamp) + data;
        MessageDigest digest = null;
        byte[] bytes = null;
        try {
            digest = MessageDigest.getInstance("SHA-256");
            bytes = digest.digest(dataToHash.getBytes());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        StringBuilder buffer = new StringBuilder();
        for (byte b : bytes) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                buffer.append('0');
            }
            buffer.append(hex);
        }
        return buffer.toString();
    }
}

// 区块链类
class Blockchain {
    public List<Block> chain;

    public Blockchain() {
        this.chain = new ArrayList<>();
        this.chain.add(createGenesisBlock());
    }

    // 创建创世区块
    public Block createGenesisBlock() {
        return new Block("Genesis Block", "0", System.currentTimeMillis());
    }

    // 获取最新的区块
    public Block getLatestBlock() {
        return chain.get(chain.size() - 1);
    }

    // 添加新的区块
    public void addBlock(Block newBlock) {
        newBlock.previousHash = getLatestBlock().hash;
        newBlock.hash = newBlock.calculateHash();
        chain.add(newBlock);
    }

    // 验证区块链的完整性
    public boolean isChainValid() {
        for (int i = 1; i < chain.size(); i++) {
            Block currentBlock = chain.get(i);
            Block previousBlock = chain.get(i - 1);

            if (!currentBlock.hash.equals(currentBlock.calculateHash())) {
                return false;
            }

            if (!currentBlock.previousHash.equals(previousBlock.hash)) {
                return false;
            }
        }
        return true;
    }
}

// 主类
public class BlockchainExample {
    public static void main(String[] args) {
        Blockchain blockchain = new Blockchain();

        // 添加区块
        blockchain.addBlock(new Block("Transaction 1", blockchain.getLatestBlock().hash, System.currentTimeMillis()));
        blockchain.addBlock(new Block("Transaction 2", blockchain.getLatestBlock().hash, System.currentTimeMillis()));

        // 验证区块链的完整性
        System.out.println("Is blockchain valid? " + blockchain.isChainValid());
    }
}    
```
