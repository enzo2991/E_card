import React, { useState, useEffect } from 'react'
import { useNuiEvent } from './hooks/useNuiEvent'
import { useKeyPress } from './hooks/useKeyPress'
import { fetchNui } from './utils/fetchNui'
import { convertImage } from './utils/imagetobase64'

interface dataEntry {
  card: string,
  firstname: string
  lastname:string,
  birthday:string,
  sexe:string,
  taille:string | null,
  permis: string[] | null,
  link: string,
}

const App: React.FC = () => {
  const [isVisible, setIsVisible] = useState(false);
  const [data, setData] = useState<dataEntry | null>(null)
  const isEscapePressed = useKeyPress("Escape");
  const isBackspacePressed = useKeyPress('Backspace');


  useEffect(() => {
    if ((isEscapePressed || isBackspacePressed) && isVisible) {
      document.body.style.display = 'none';
      setIsVisible(false);
      setData(null)
    }
  },[isEscapePressed, isBackspacePressed,isVisible])

  useNuiEvent('getMugshot',async (data)  => {
    const baseUrl = await convertImage(data.txd);
    fetchNui("answerMugshot",{url:baseUrl})
  })

  useNuiEvent('openUi',(data) =>{
    if (!isVisible){
      document.body.style.display = 'block';
      setIsVisible(true);
      setData(data);
      switch(data.card){
        case 'drive':
          break;
        case 'weapon':
          break;
      }
    }
  })

  return (
    <>
      <div className='flex absolute w-96 h-48 top-10 right-5 rounded bg-gray-500/50 gap-2'>
        <img className='ml-2 mt-2 w-20 h-24' src={data?.link} alt="Profile"/>
        <div className='p-2'>
          <p className='text-sm'><span className='font-bold'>Nom :</span><br/>{data?.firstname}</p>
          <p className='text-sm'><span className='font-bold'>Prénom :</span><br/>{data?.lastname}</p>
          <p className='text-sm'><span className='font-bold'>Date de naissance :</span><br/>{data?.birthday}</p>
          <p className='text-sm'><span className='font-bold'>Sexe :</span><br/>{data?.sexe}</p>
        </div>
        {data?.card == 'idcard' && (
            <div className='p-2'>
              <p className='text-sm'><span className='font-bold'>taille :</span><br/>{data?.taille}</p>
            </div>
        )}
        {data?.card !== 'idcard' && (
          <div className='flex flex-col gap-2 p-2'>
            <h6 className='font-bold text-xl'>permis</h6>
            <ul className='flex flex-col gap-2'>
            {data?.permis?.map((key,index) => {
              return (
                <li key={index} className='rounded bg-gray-400/50 text-center'>{key}</li>
              )
            })}
            </ul>
          </div>
        )}
      </div>
    </>
  )
}

export default App
