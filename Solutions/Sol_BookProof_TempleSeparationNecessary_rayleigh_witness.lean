-- Generated from ChapterTempleSeparationNecessary.lean — solution of BookProof.TempleSeparationNecessary.rayleigh_witness
import Mathlib
import Definitions.Def_ChapterTempleSeparationNecessary
import Theorems.Thm_BookProof_TempleSeparationNecessary_witness_trial
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Definitions.Def_ChapterRitzCertificate
open BookProof.TempleSeparationNecessary



noncomputable section


open BookProof.RitzCertificate

set_option maxHeartbeats 1000000 in
theorem solution (M : ℝ) : rayleigh (witness M trial) trial = 0 := by

  rw [rayleigh, witness_trial, inner_zero_right, Complex.zero_re]
