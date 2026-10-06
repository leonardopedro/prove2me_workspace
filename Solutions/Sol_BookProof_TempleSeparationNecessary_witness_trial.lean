-- Generated from ChapterTempleSeparationNecessary.lean — solution of BookProof.TempleSeparationNecessary.witness_trial
import Mathlib
import Definitions.Def_ChapterTempleSeparationNecessary
import Theorems.Thm_BookProof_TempleSeparationNecessary_witness_apply
import Theorems.Thm_BookProof_TempleSeparationNecessary_norm_trial
open BookProof.TempleSeparationNecessary



noncomputable section


open BookProof.RitzCertificate

set_option maxHeartbeats 1000000 in
theorem solution (M : ℝ) : witness M trial trial = 0 := by

  have h : (inner ℂ trial trial : ℂ) = 1 := by
    rw [inner_self_eq_norm_sq_to_K, norm_trial]; norm_num
  rw [witness_apply, h, one_smul, sub_self, smul_zero]
