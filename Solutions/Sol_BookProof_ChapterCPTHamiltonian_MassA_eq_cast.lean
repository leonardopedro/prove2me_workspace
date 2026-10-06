-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.MassA_eq_cast
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution :
    MassA = (Int.castRingHom ℂ).mapMatrix MassAZ := by

  rw [MassA, dgamma, MassAZ, mgamma, smul_smul]
  simp
