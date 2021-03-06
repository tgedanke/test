Ext.define('Courier.view.NewCountForm', {
	alias : 'widget.newcountform',
	extend : 'Ext.form.Panel',
	layout : {
		type : 'vbox'
	},
	bodyPadding : 10,
	items : [{
			xtype : 'label',
			itemId : 'wb_no'/*,
			fieldLabel : 'Накладная',
			readOnly : true*/
		}, 
		{
			xtype : 'textfield',
			name : 'wb_no',
			hidden : true/*
			fieldLabel : 'Накладная',
			readOnly : true*/
		},
		{
			xtype : 'numberfield',
			minValue : 0,
			name : 'packs',
			width : 233,
			hideTrigger : true,
			fieldLabel : 'Количество',
			allowBlank : false
		}
	]
});
