outlets = 1; 

function anything() 
{
	var o = this.messagename; 
	var digest = 'undocumented' + '\uD83D\uDE2C';
	var dict = max.getrefdict(o);

	if(typeof dict !== 'function') 
	{
		digest = dict.get('digest'); 
	}  
    outlet(0,digest);   
}
