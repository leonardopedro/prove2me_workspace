-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.Band.smul
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand
open BookProof.HermiteBand.Band








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {r M : ℕ}
    {C : ℝ} {g : ℕ → ℝ} (c : ℂ) (h : Band T r M C g) :
    Band (c • T) r M (‖c‖ * C) g := by

  classical
  intro α
  obtain ⟨f, hrep, hcard, hband, hcoef⟩ := h α
  refine ⟨c • f, ?_, ?_, ?_, ?_⟩
  · simp only [LinearMap.smul_apply, hrep, hcomb, map_smul]
  · exact le_trans (Finset.card_le_card (Finsupp.support_smul)) hcard
  · intro β hβ
    exact hband β (Finsupp.support_smul hβ)
  · intro β
    have h1 : ‖(c • f) β‖ = ‖c‖ * ‖f β‖ := by
      simp [Finsupp.smul_apply]
    rw [h1, mul_assoc]
    exact mul_le_mul_of_nonneg_left (hcoef β) (norm_nonneg c)
