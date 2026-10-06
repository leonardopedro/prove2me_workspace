-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.Kin_sq
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_KinZ_sq
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_Kin_eq_cast
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) : Kin j * Kin j = 1 := by

  rw [Kin_eq_cast, ← map_mul, KinZ_sq, map_one]
