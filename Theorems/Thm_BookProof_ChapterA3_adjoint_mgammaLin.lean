-- Generated from ChapterPauliCommutant.lean — theorem BookProof.ChapterA3.adjoint_mgammaLin
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.adjoint_mgammaLin (μ : Fin 4) :
    LinearMap.adjoint (mgammaLin μ) = (if μ = 0 then (-1 : ℂ) else 1) • mgammaLin μ := by sorry
