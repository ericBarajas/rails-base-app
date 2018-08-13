/* eslint no-console:0 */

// jquery

import $ from 'jquery';

global.$ = $
global.jQuery = $



import 'jquery-ui';

require.context('file-loader?name=[path][name].[ext]&context=node_modules/jquery-ui-dist!jquery-ui-dist', true,    /jquery-ui\.css/ );
require.context('file-loader?name=[path][name].[ext]&context=node_modules/jquery-ui-dist!jquery-ui-dist', true,    /jquery-ui\.theme\.css/ );


// jquery-ujs
import {} from 'jquery-ujs';





// bootstrap
import 'bootstrap/dist/js/bootstrap';



// autocomplete
//require('bootstrap-autocomplete-input-assets/src/js/bootstrap3-typeahead.min.js');
//require('bootstrap-autocomplete-input-assets/src/js/bootstrap-autocomplete-input.min.js');



//
require.context('../images/', true, /\.(gif|jpg|png|svg)$/i)


