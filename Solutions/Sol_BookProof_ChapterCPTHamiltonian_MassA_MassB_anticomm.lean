-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.MassA_MassB_anticomm
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassAZ_MassBZ_anticomm
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassA_eq_cast
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassB_eq_cast
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : MassA * MassB + MassB * MassA = 0 := by

  rw [MassA_eq_cast, MassB_eq_cast, ← map_mul, ← map_mul, ← map_add,
    MassAZ_MassBZ_anticomm, map_zero]
