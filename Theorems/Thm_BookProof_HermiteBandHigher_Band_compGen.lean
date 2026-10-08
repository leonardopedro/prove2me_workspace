-- Generated from ChapterHermiteBandCalculusHigher.lean — theorem BookProof.HermiteBandHigher.Band.compGen
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand
open BookProof.HermiteBandHigher



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}


theorem BookProof.HermiteBandHigher.Band.compGen {T U : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    {r₁ r₂ M₁ M₂ m₁ m₂ : ℕ} {C₁ C₂ : ℝ} (hC₁ : 0 ≤ C₁) (hC₂ : 0 ≤ C₂)
    (hT : Band T r₁ M₁ C₁ (gpow m₁)) (hU : Band U r₂ M₂ C₂ (gpow m₂)) :
    Band (U ∘ₗ T) (r₁ + r₂) (M₁ * M₂)
      (M₁ * C₁ * C₂ * Real.sqrt ((r₁ : ℝ) + 1) ^ m₂) (gpow (m₁ + m₂)) := by sorry
