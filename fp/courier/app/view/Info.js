Ext.define('Courier.view.Info', {
	extend : 'Ext.toolbar.Toolbar',
	alias: 'widget.info',
	//title: 'infopanel',
	items: [{
		xtype: 'label',
		text:''
	},'-',
	{
	text:'test',
	action: 'test'
	},'->',
	{
		xtype: 'label',
		itemId: 'count',
		text:''
	}
	
	]
});