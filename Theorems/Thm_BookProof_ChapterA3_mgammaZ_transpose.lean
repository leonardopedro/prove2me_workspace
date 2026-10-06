-- Generated from ChapterPauliCommutant.lean — theorem BookProof.ChapterA3.mgammaZ_transpose
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.mgammaZ_transpose (μ : Fin 4) :
    (mgammaZ μ)ᵀ = (if μ = 0 then (-1 : ℤ) else 1) • mgammaZ μ := by sorry
