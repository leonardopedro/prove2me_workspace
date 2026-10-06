-- Generated from ChapterTempleSeparationNecessary.lean — solution of BookProof.TempleSeparationNecessary.resid_witness
import Mathlib
import Definitions.Def_ChapterTempleSeparationNecessary
import Theorems.Thm_BookProof_TempleSeparationNecessary_witness_trial
import Theorems.Thm_BookProof_TempleSeparationNecessary_rayleigh_witness
open BookProof.TempleSeparationNecessary



noncomputable section


open BookProof.RitzCertificate

set_option maxHeartbeats 1000000 in
theorem solution (M : ℝ) : resid (witness M trial) trial = 0 := by

  rw [resid, rayleigh_witness, witness_trial]
  norm_num
