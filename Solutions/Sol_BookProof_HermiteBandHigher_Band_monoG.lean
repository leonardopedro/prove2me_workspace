-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.Band.monoG
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {r M : ℕ}
    {C : ℝ} {g g' : ℕ → ℝ} (hC : 0 ≤ C) (hg : ∀ n, g n ≤ g' n) (h : Band T r M C g) :
    Band T r M C g' := by

  intro α
  obtain ⟨f, hrep, hcard, hband, hcoef⟩ := h α
  exact ⟨f, hrep, hcard, hband, fun β =>
    le_trans (hcoef β) (mul_le_mul_of_nonneg_left (hg α.degree) hC)⟩
