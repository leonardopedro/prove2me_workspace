-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.Kin_MassA_anticomm
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_KinZ_MassAZ_anticomm
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_Kin_eq_cast
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassA_eq_cast
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) : Kin j * MassA + MassA * Kin j = 0 := by

  rw [Kin_eq_cast, MassA_eq_cast, ← map_mul, ← map_mul, ← map_add,
    KinZ_MassAZ_anticomm j, map_zero]
