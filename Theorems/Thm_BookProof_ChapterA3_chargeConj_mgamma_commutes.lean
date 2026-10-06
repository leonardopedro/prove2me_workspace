-- Generated from ChapterA3b.lean — theorem BookProof.ChapterA3.chargeConj_mgamma_commutes
import Mathlib
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.chargeConj_mgamma_commutes (μ : Fin 4) (v : Fin 4 → ℂ) :
    chargeConj (mgamma μ *ᵥ v) = mgamma μ *ᵥ chargeConj v := by sorry
