-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.Kin_anticomm
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_KinZ_anticomm
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_Kin_eq_cast
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) (h : i ≠ j) :
    Kin i * Kin j + Kin j * Kin i = 0 := by

  rw [Kin_eq_cast, Kin_eq_cast, ← map_mul, ← map_mul, ← map_add, KinZ_anticomm i j h, map_zero]
