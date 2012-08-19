﻿Ext.define('FpMnf.view.orders.OrdGrid', {
	extend : 'Ext.grid.Panel',
	alias : 'widget.ordgrid',
	requires : ['FpMnf.view.orders.OrdTool', 'FpMnf.view.mainform.TotalTool'],
	initComponent : function () {
		Ext.apply(this, {
			store : 'OrdsSt',
			columns : [{
                            xtype: 'gridcolumn',
                            width: 47,
							
                            dataIndex: 'ROrdNum',
                            text: '№'
                        },
                        {
                            xtype: 'gridcolumn',
                            width: 150,
							
                            dataIndex: 'status',
                            text: 'Статус'
                        },
                        
						{
							xtype: 'gridcolumn',
							
                            width: 70,
                            dataIndex: 'DateIn',
							
                            text: 'Дата'
						},
                        {
                            xtype: 'gridcolumn',
                            width: 114,
							
                            dataIndex: 'ORGCity',
                            text: 'Город'
                        },
                        {
                            xtype: 'gridcolumn',
                            flex:1,
							
                            dataIndex: 'CName',
                            text: 'Отправитель'
                        },
                        {
                            xtype: 'gridcolumn',
                            width: 114,
							
                            dataIndex: 'DESTCity',
                            text: 'Город'
                        },
                        {
                            xtype: 'gridcolumn',
                            flex:1,
							
                            dataIndex: 'DName',
                            text: 'Получатель'
                        },
                        {
                            xtype: 'gridcolumn',
                            width: 41,
							
                            dataIndex: 'Packs',
                            text: 'Кол.'
                        },
                        {
                            xtype: 'gridcolumn',
                            width: 51,
							
                            dataIndex: 'Wt',
                            text: 'Вес'
                        },
                        {
                            xtype: 'gridcolumn',
                            width: 51,
							
                            dataIndex: 'VolWt',
                            text: 'Об. вес'
                        },
                        {
                            xtype: 'gridcolumn',
                            width: 70,
							
                            dataIndex: 'wb_no',
                            text: '№ накл.'
                        }
			],
			dockedItems : [{
					xtype : 'ordtool',
					dock : 'top'
				}, {
					xtype : 'totaltool',
					dock : 'bottom'
				}
			]
		});
		this.callParent(arguments);
	}
});
