
import React, { Component } from 'react';
import {
	AppRegistry,
	StyleSheet,
	Text,
	View,
	PixelRatio,
	Platform,
	Dimensions,
	TouchableHighlight,
	NativeAppEventEmitter,
	NativeModules
} from 'react-native'


var RNBridgeModule=NativeModules.RNBridgeModule

var subscription

class CustomButton extends Component {
    render() {
        return (
          <TouchableHighlight
            style={styles.button}
            underlayColor="#a5a5a5"
            onPress={this.props.onPress}>
            <Text style={styles.buttonText}>{this.props.text}</Text>
          </TouchableHighlight>
        );
    }
}

export default class demo extends Component {

    constructor(props) {
		super(props);
	}

	componentDidMount() {
		subscription = NativeAppEventEmitter.addListener(
         	'EventReminder',
          	(reminder) => {
          		console.log('reminder',reminder)
          	}
        )
	}

	async _updateEvents(){
	    try{
	        var events = await RNBridgeModule.RNInvokeOCPromise({'name':'kyle'});
	        console.log(events)
	    }catch(e){
	    	console.log(e)
	    }
	}

	_updateByCallBack(){
		RNBridgeModule.RNInvokeOCCallBack(
        {'name':'kyle'},
        (error,events)=>{
            if(error){
              	console.error(error);
            }else{
              	console.log(events)
            }
      })
	}

	_openOCView(){
		RNBridgeModule.RNOpenOC('kyle')
	}

    render() {
        return (
            <View style={styles.center}>
                <Text>{this.props.str}</Text>
                <CustomButton text='RN → OC By Promise'
                   onPress={()=>this._updateEvents()}
                />
                <CustomButton text='RN → OC By CallBack'
                  onPress={this._updateByCallBack.bind(this)}
                />
                <CustomButton text='RN open OC View'
                  onPress={this._openOCView.bind(this)}
                />
                <CustomButton text='OC → RN'
                    onPress={()=>RNBridgeModule.OCcallRN({'name':'kyle'})}
                />
            </View>
        );
    }
}

const styles = StyleSheet.create({
	center: {
		flex:1,
		justifyContent: 'center',
		alignItems: 'center',
	},
	button: {
    	margin:10,
    	backgroundColor: '#108ee9',
    	width:Dimensions.get('window').width-30,
    	padding: 10,
  	},
  	buttonText:{
    	color:'white',
    	textAlign:'center'
  	}
})

AppRegistry.registerComponent('demo', () => demo);
