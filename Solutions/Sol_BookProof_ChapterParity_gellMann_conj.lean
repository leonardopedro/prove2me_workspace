-- Generated from ChapterParity.lean — solution of BookProof.ChapterParity.gellMann_conj
import Mathlib
import Definitions.Def_ChapterParity
open BookProof.ChapterParity



open Matrix
open scoped ComplexConjugate

variable {n : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 8) :
    (gellMann a).map (starRingEnd ℂ) = (gellMannConjSign a) • gellMann a := by

  fin_cases a <;>
  · ext i j; fin_cases i <;> fin_cases j <;>
      simp [gellMann, gellMannConjSign, Matrix.map_apply, Matrix.smul_apply,
        Complex.conj_ofReal, map_ofNat]
