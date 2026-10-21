-- Generated from ChapterPauliFundamental.lean — solution of BookProof.ChapterPauliFundamental.pauliFundamental
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Theorems.Thm_BookProof_ChapterPauliFundamental_pauli_exists
import Theorems.Thm_BookProof_ChapterPauliFundamental_pauli_unique
open BookProof.ChapterPauliFundamental



open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

set_option maxHeartbeats 1000000 in
theorem solution : PauliFundamental := by

  intro A B hA hB
  exact ⟨pauli_exists hA hB, fun S T hS hT hSeq hTeq => pauli_unique hA S T hS hT hSeq hTeq⟩
