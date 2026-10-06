-- Generated from ChapterParityHiggs.lean — solution of BookProof.ChapterParityHiggs.pauli2_map_conj
import Mathlib
import Definitions.Def_ChapterParityHiggs
open BookProof.ChapterParityHiggs



open Matrix
open scoped Kronecker
open scoped ComplexConjugate


open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution : pauli2.map (starRingEnd ℂ) = -pauli2 := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [pauli2, Matrix.map_apply, Complex.conj_I]
