-- Generated from ChapterA3c.lean — theorem BookProof.ChapterA3.mgammaR_indep
import Mathlib
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.mgammaR_indep (c : Fin 4 → ℝ) (h : ∑ ν, c ν • mgammaR ν = 0) :
    ∀ ν, c ν = 0 := by sorry
