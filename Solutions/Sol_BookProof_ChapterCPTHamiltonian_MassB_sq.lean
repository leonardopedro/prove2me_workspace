-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.MassB_sq
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassBZ_sq
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassB_eq_cast
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : MassB * MassB = -1 := by

  rw [MassB_eq_cast, ← map_mul, MassBZ_sq, map_neg, map_one]
