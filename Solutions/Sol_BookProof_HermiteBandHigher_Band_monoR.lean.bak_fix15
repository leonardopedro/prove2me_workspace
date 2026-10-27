-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.Band.monoR
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
theorem solution {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {r r' M : ℕ}
    {C : ℝ} {g : ℕ → ℝ} (hr : r ≤ r') (h : Band T r M C g) : Band T r' M C g := by

  intro α
  obtain ⟨f, hrep, hcard, hband, hcoef⟩ := h α
  exact ⟨f, hrep, hcard, fun β hβ => le_trans (hband β hβ) hr, hcoef⟩
