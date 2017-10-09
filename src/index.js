import './main.css';
import { Main } from './Main.elm';

Main.embed(document.getElementById('root'), { apiRoot: process.env.RESUMIS_API_ROOT});
