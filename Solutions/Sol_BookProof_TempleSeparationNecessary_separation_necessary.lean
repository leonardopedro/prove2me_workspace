-- Generated from ChapterTempleSeparationNecessary.lean — solution of BookProof.TempleSeparationNecessary.separation_necessary
import Mathlib
import Definitions.Def_ChapterTempleSeparationNecessary
import Theorems.Thm_BookProof_TempleSeparationNecessary_isSelfAdjoint_witness
import Theorems.Thm_BookProof_TempleSeparationNecessary_norm_trial
import Theorems.Thm_BookProof_TempleSeparationNecessary_rayleigh_witness
import Theorems.Thm_BookProof_TempleSeparationNecessary_resid_witness
import Theorems.Thm_BookProof_TempleSeparationNecessary_neg_mem_spectrum_witness
import Theorems.Thm_BookProof_TempleSeparationNecessary_bddBelow_spectrum
open BookProof.TempleSeparationNecessary



noncomputable section


open BookProof.RitzCertificate

set_option maxHeartbeats 1000000 in
theorem solution (M : ℝ) :
    ∃ (A : E2 →L[ℂ] E2) (x : E2), IsSelfAdjoint A ∧ ‖x‖ = 1 ∧
      rayleigh A x = 0 ∧ resid A x = 0 ∧ sInf (spectrum ℝ A) ≤ -M :=
  ⟨witness M trial, trial, isSelfAdjoint_witness M trial, norm_trial,
      rayleigh_witness M, resid_witness M,
      csInf_le (bddBelow_spectrum _) (neg_mem_spectrum_witness M)⟩
