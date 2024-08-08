import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.tsx'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import './index.scss'
import { debugData } from './utils/debugData';

debugData([{
  action:'openUi',
  data:{
    card: 'drive',
    link: "https://i.giphy.com/3ohryvhbXLR2BDZrQk.webp",
    firstname: "firstname",
    lastname: "lastname",
    sexe:'M',
    taille:"180 cm",
    permis:["voiture","moto","camion","bike"],
    birthday: '13/06/2000',
  }
}])

const queryClient = new QueryClient();

ReactDOM.createRoot(document.getElementById('root')!).render(
  <QueryClientProvider client={queryClient}>
    <React.StrictMode>
      <App />
    </React.StrictMode>
  </QueryClientProvider>
)
