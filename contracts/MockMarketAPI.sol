// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract MockMarketAPI {
    struct PublishedDeal {
        bool verified;
        string cid;
        uint64 dealId;
        bytes client;
        uint256 size;
        uint256 price;
        uint256 duration;
        string TransferChannelID;
    }

    PublishedDeal[] public _publishedDeals;

    // mock data from https://kb.factor8.io/en/docs/filecoin/testnets/hyperspace/deals
    function mockPublishPapper() public {
        PublishedDeal memory deal;
        deal.verified = true;
        deal.cid = "bafyreibfuawqrbdk6ctrjg6fstox5w7hwbtrlyhpqbancpmkmyukpokgk4";
        deal.dealId = 785;
        deal.client = abi.encodePacked("t01337");
        deal.size = 34359738368;
        deal.duration = 528764;
        deal.price = 0;
        deal
            .TransferChannelID = "12D3KooWLV9ykkpuTb2MibaDz5N37t6ZZ3oMy4F33hMQ527Xn9Dd-12D3KooWHh1mUwb827kFC27zvmvKc13XtKRFRDQgAkHBecn6anx9-1674042946480025085";

        _publishedDeals.push(deal);
    }
}
