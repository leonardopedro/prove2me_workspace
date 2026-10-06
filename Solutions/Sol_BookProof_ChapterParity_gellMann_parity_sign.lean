-- Generated from ChapterParity.lean — solution of BookProof.ChapterParity.gellMann_parity_sign
import Mathlib
import Definitions.Def_ChapterParity
import Theorems.Thm_BookProof_ChapterParity_gellMann_conj
open BookProof.ChapterParity



open Matrix
open scoped ComplexConjugate

variable {n : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 8) :
    -((gellMann a).map (starRingEnd ℂ)) = (-(gellMannConjSign a)) • gellMann a := by

  rw [gellMann_conj, neg_smul]
