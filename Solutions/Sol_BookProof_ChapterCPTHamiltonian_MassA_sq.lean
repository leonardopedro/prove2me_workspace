-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.MassA_sq
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassAZ_sq
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassA_eq_cast
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : MassA * MassA = -1 := by

  rw [MassA_eq_cast, ← map_mul, MassAZ_sq, map_neg, map_one]
