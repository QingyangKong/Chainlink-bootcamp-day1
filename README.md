# Chainlink-bootcamp-day1
This the sample codes for Chainlink 2-day bootcamp day1
In day 1 of the bootcamp, you will compelete the NFT smart contract that allows minter to mint NFT randomly.

## Instructions
- Open [remix](https://remix.ethereum.org/) online IDE for Solidity.
- Get test tokens(Polygon mumbai in the case) from [faucets](https://faucets.chain.link/mumbai).
- Create subscription in Chainlink [VRF App](https://vrf.chain.link/) and get a SubId.
- Deploy the smart contract `VRFv2Consumer.sol` with the subscription ID.
- Deploy the smart contract `NFTDogs.sol`.
- Call function `setNft` with address of deployed `NFTDogs.sol`.
- Call function `setVrf` with address of deployed `VRFv2Consumer.sol`.
- Call function `safeMint`.
- Check if the fulfillment is successful in [VRF App](https://vrf.chain.link/).
- Head to [Opensea](https://testnets.opensea.io/) on testnet to check which dog you got!

## smart contracts
- NFTDogs.sol: ERC-721 smart contract that allows minter to mint NFT randomly. 
- VRFv2Consumer.sol: is called by NFTDogs.sol to send VRF request.

## Tips:
Sample codes are based on Polygon testnet mumbai, if you prefer other testnets, update the configurations such as keyHash and VRFCoordinatorV2 address in the `VRFv2Consumer.sol`. These 2 parameters can be in Chainlink documents.