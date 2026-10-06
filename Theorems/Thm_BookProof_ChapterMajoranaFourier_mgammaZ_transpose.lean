-- Generated from ChapterMajoranaFourier.lean — theorem BookProof.ChapterMajoranaFourier.mgammaZ_transpose
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterMajoranaFourier


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterMajoranaFourier.mgammaZ_transpose (μ : Fin 4) :
    (mgammaZ μ)ᵀ = if μ = 0 then -mgammaZ μ else mgammaZ μ := by sorry
