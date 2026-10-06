-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.HermiteBandHigher.IsBandDeg.comp
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Theorems.Thm_BookProof_HermiteBandHigher_IsBandR_comp
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {m₁ m₂ : ℕ} {T U : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hU : IsBandDeg m₂ U) (hT : IsBandDeg m₁ T) : IsBandDeg (m₁ + m₂) (U ∘ₗ T) := by

  obtain ⟨r₁, h₁⟩ := hT
  obtain ⟨r₂, h₂⟩ := hU
  exact ⟨r₁ + r₂, h₂.comp h₁⟩
