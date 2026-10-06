-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.MassA_conjTranspose
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassAZ_transpose
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_castMat_conjTranspose
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassA_eq_cast
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : (MassA)ᴴ = -MassA := by

  rw [MassA_eq_cast, castMat_conjTranspose, MassAZ_transpose, map_neg]
