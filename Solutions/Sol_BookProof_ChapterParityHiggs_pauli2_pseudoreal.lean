-- Generated from ChapterParityHiggs.lean — solution of BookProof.ChapterParityHiggs.pauli2_pseudoreal
import Mathlib
import Definitions.Def_ChapterParityHiggs
import Theorems.Thm_BookProof_ChapterParityHiggs_pauli2_map_conj
import Theorems.Thm_BookProof_ChapterParity_pauli2_sq
open BookProof.ChapterParityHiggs



open Matrix
open scoped Kronecker
open scoped ComplexConjugate


open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution : pauli2 * (pauli2.map (starRingEnd ℂ)) = -1 := by

  rw [pauli2_map_conj, Matrix.mul_neg, pauli2_sq]
