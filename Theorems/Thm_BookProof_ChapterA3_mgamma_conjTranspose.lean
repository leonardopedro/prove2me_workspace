-- Generated from ChapterPauliCommutant.lean — theorem BookProof.ChapterA3.mgamma_conjTranspose
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.mgamma_conjTranspose (μ : Fin 4) :
    (mgamma μ)ᴴ = (if μ = 0 then (-1 : ℂ) else 1) • mgamma μ := by sorry
