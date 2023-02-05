const hre = require("hardhat")

async function main() {
    await hre.run("compile")
    const filHackathon = await hre.ethers.getContractFactory("FileContract")
    let _citeFee = hre.ethers.utils.parseEther("0.01", "ether")
    const fil = await filHackathon.deploy(_citeFee)

    await fil.deployed()
    // 上传论文
    // let citedPaper = []
    // await fil.publishPaper("paperName", "paperCid", citedPaper)
    // // 获得个人论文列表
    // let paperList = await fil.getPaperList()
    // console.log(paperList)
    // let firstPaper = paperList[0]
    // let paperId = firstPaper[2]
    // console.log("paperId", paperId)
    // // 引用论文
    // await fil.publishPaper("paperName", "paperCid", [paperId], {
    //     value: hre.ethers.utils.parseEther("0.01"),
    // })
    // // 获得论文详情
    // let paper = await fil.getPaper(paperId)
    // console.log("paper详情", paper)
    // // 获得引用数
    // // let citeNum = await fil.getCiteCount(paperId)
    // // console.log("引用数", citeNum)
    // // // 获得被引用数
    // // let citedNum = await fil.getCitedCount(paperId)
    // // console.log("被引用数", citedNum)
    // paperList = await fil.getPaperList()
    // console.log('论文列表',paperList)
    // console.dir(paperList[1]["citeTargetList"])
    console.log("Greeter deployed to:", fil.address)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
1
