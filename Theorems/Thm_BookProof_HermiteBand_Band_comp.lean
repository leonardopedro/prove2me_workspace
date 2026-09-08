-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.Band.comp
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand
open BookProof.HermiteBand.Band







noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

theorem BookProof.HermiteBand.Band.comp {T U : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {M₁ M₂ : ℕ}
    {C₁ C₂ : ℝ} (hC₁ : 0 ≤ C₁) (hC₂ : 0 ≤ C₂)
    (hU : Band U 1 M₂ C₂ g1) (hT : Band T 1 M₁ C₁ g1) :
    Band (U ∘ₗ T) 2 (M₁ * M₂) (2 * M₁ * C₁ * C₂) g2 := by sorry
