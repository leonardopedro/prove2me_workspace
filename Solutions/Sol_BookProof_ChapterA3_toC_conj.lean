-- Generated from ChapterA3b.lean — solution of BookProof.ChapterA3.toC_conj
import Mathlib
import Definitions.Def_ChapterA3b
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin 4) (Fin 4) ℝ) :
    (toC M).map (starRingEnd ℂ) = toC M := by

  ext i j; simp [toC]
