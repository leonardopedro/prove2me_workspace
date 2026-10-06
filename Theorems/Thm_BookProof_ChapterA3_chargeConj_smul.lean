-- Generated from ChapterA3b.lean — theorem BookProof.ChapterA3.chargeConj_smul
import Mathlib
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.chargeConj_smul (c : ℂ) (v : Fin 4 → ℂ) :
    chargeConj (c • v) = conj c • chargeConj v := by sorry
