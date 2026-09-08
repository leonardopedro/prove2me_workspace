-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.Band.toBand2
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
import Theorems.Thm_BookProof_HermiteBand_g1_le_g2
open BookProof.HermiteBand
open BookProof.HermiteBand.Band








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {M : ℕ} {C : ℝ}
    (hC : 0 ≤ C) (h : Band T 1 M C g1) : Band T 2 M C g2 := by

  intro α
  obtain ⟨f, hrep, hcard, hband, hcoef⟩ := h α
  refine ⟨f, hrep, hcard, fun β hβ => le_trans (hband β hβ) (by norm_num), fun β => ?_⟩
  exact le_trans (hcoef β) (by
    have h1 := g1_le_g2 α.degree
    nlinarith [g1_nonneg α.degree])
