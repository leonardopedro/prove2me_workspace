-- Generated from ChapterTempleSeparationNecessary.lean — solution of BookProof.TempleSeparationNecessary.neg_mem_spectrum_witness
import Mathlib
import Definitions.Def_ChapterTempleSeparationNecessary
import Theorems.Thm_BookProof_TempleSeparationNecessary_other_ne_zero
import Theorems.Thm_BookProof_TempleSeparationNecessary_witness_other
open BookProof.TempleSeparationNecessary



noncomputable section


open BookProof.RitzCertificate

set_option maxHeartbeats 1000000 in
theorem solution (M : ℝ) : (-M) ∈ spectrum ℝ (witness M trial) := by

  intro hunit
  have hzero : (algebraMap ℝ (E2 →L[ℂ] E2) (-M) - witness M trial) other = 0 := by
    have halg : algebraMap ℝ (E2 →L[ℂ] E2) (-M) = ((-M : ℝ) : ℂ) • (1 : E2 →L[ℂ] E2) := by
      ext y
      simp [Algebra.algebraMap_eq_smul_one]
    rw [halg]
    simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.smul_apply,
      ContinuousLinearMap.one_apply, witness_other]
    exact sub_self _
  obtain ⟨u, hu⟩ := hunit
  have hmul : ((↑u⁻¹ : E2 →L[ℂ] E2) *
      (algebraMap ℝ (E2 →L[ℂ] E2) (-M) - witness M trial)) other = other := by
    rw [← hu, u.inv_mul, ContinuousLinearMap.one_apply]
  rw [ContinuousLinearMap.mul_apply, hzero, map_zero] at hmul
  exact other_ne_zero hmul.symm
