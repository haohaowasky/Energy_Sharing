pragma solidity ^0.4.15;
contract Energy_Sharing {
    struct Meter{
        uint Token;
        bytes32 Status;
    }

    mapping(address => Meter) public _MeterWallet;
    mapping(address => address) public _TradingLedger; // from sell point to buy
    address [] public NeibourhoodMeters;
    address [] public TradingLedger;

    event Balance(address _meter, uint _balance);
    event checkstatus(address _meter, bytes32 _stas);

    function Energy_Sharing(uint _Token, bytes32 _Status) public{ // constructor 
        address meter = msg.sender;
        for(uint i = 0; i < NeibourhoodMeters.length; i++ ){
            if(NeibourhoodMeters[i] == meter){
                revert(); // make sure it is not double registed
            }
        }
        NeibourhoodMeters.push(meter);
        _MeterWallet[meter].Token = _Token; // each meter has initial token of 100
        _MeterWallet[meter].Status = _Status; // each meter has default status of not traded
    }

    function PostRequest(bytes32 inquiry) public{
        if(inquiry == "buy"){
            _MeterWallet[msg.sender].Status = "buy";
        }
        else{
            _MeterWallet[msg.sender].Status = "sell";
        }
    }

    function Buy() returns(bool)  {
        bool found = false;
        for(uint i = 0; i < NeibourhoodMeters.length; i++ ){
            if(_MeterWallet[NeibourhoodMeters[i]].Status == "sell"){
                found = true;
                _MeterWallet[NeibourhoodMeters[i]].Status = "neutral"; // make sure it is not double registed
                _MeterWallet[NeibourhoodMeters[i]].Token += 1;
                _TradingLedger[NeibourhoodMeters[i]] = msg.sender;
                break;
            }
        }
        
        return found;

    }

    function Sell() returns(address) {
        address seller = msg.sender;
        if(_MeterWallet[seller].Status == "neutral"){
            return _TradingLedger[seller];
        }
        else{
            revert();
        }
    }

    function CheckBalance() public{
        address get_reading = msg.sender;
        Balance(get_reading, _MeterWallet[get_reading].Token);
    }

    function CheckStatus() public{
        address get_status = msg.sender;
        checkstatus(get_status, _MeterWallet[get_status].Status);
    }

}
