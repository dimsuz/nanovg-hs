module NanoVG.Internal.GL2 where

import qualified Data.Set as S
import           Data.Word
import           Foreign.C.Types

import           NanoVG.Internal.Types
import           NanoVG.Internal.Context
import           NanoVG.Internal.FFIHelpers

-- For now only the GL2 backend is supported
#define NANOVG_GL2
-- We need to include this to define GLuint
#include "GL/glew.h"
#include "nanovg.h"
#include "nanovg_gl.h"

{#pointer *NVGcontext as Context newtype nocode#}

{#enum NVGcreateFlags as CreateFlags
         {underscoreToCase} with prefix = "NVG_"
         deriving (Show,Read,Eq,Ord)#}

{#fun unsafe nvgCreateGL2 as createGL2
        {bitMask`S.Set CreateFlags'} -> `Context'#}
{#fun unsafe nvgDeleteGL2 as deleteGL2
        {`Context'} -> `()'#}

type GLuint = Word32

{#fun unsafe nvglCreateImageFromHandleGL2 as createImageFromHandleGL2
        {`Context',fromIntegral`GLuint',`CInt',`CInt',`CreateFlags'} -> `Image'Image#}

{#fun unsafe nvglImageHandleGL2 as imageHandleGL2
        {`Context',imageHandle`Image'} -> `GLuint'fromIntegral#}
