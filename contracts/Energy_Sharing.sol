pragma solidity ^0.4.15;


contract Energy_Sharing {
    struct Meter{
        uint Token;
        bytes32 Status;
        address Receiver;
    }

    mapping(address => Meter) public _MeterWallet;
    address [] public NeibourhoodMeters;

    event Balance(address _meter, uint _balance);
    event checkstatus(address _meter, bytes32 _stas);

    function Registry(){
        address meter = msg.sender;
        for(uint i = 0; i < NeibourhoodMeters.length; i++ ){
            if(NeibourhoodMeters[i] == meter){
                throw; // make sure it is not double registed
            }
        }
        NeibourhoodMeters.push(meter);
        _MeterWallet[meter].Token = 100; // each meter has initial token of 100
        _MeterWallet[meter].Status = "Neutral"; // each meter has default status of not traded
    }

    function PostRequest(bytes32 inquiry) returns(bytes32){
        if(inquiry == "buy"){
            _MeterWallet[msg.sender].Status = "buy";

        }
        else{
            _MeterWallet[msg.sender].Status = "sell";
        }
        return "accepted!";
    }

    function Buy() returns(address){
        bool found = false;
        address sending;
        for(uint i = 0; i < NeibourhoodMeters.length; i++ ){
            if(_MeterWallet[NeibourhoodMeters[i]].Status == "sell"){
                found = true;
                _MeterWallet[NeibourhoodMeters[i]].Status = "Neutral"; // make sure it is not double registed
                _MeterWallet[NeibourhoodMeters[i]].Token += 1;
                _MeterWallet[NeibourhoodMeters[i]].Receiver = msg.sender;
                sending = NeibourhoodMeters[i];
                break;
            }
        }
        if(found == true){
            return sending;
        }
        else{
            throw;
        }
    }

    function Sell() returns(address){
        address seller = msg.sender;
        if(_MeterWallet[seller].Status == "Neutral"){
            return _MeterWallet[seller].Receiver;
        }
        else{
            throw;
        }
    }

    function CheckBalance() {
        address get_reading = msg.sender;
        Balance(get_reading, _MeterWallet[get_reading].Token);
    }

    function CheckStatus() {
        address get_status = msg.sender;
        checkstatus(get_status, _MeterWallet[get_status].Status);

    }

}
