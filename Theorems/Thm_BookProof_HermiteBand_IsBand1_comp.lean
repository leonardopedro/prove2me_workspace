-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.IsBand1.comp
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand
open BookProof.HermiteBand.IsBand1



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

theorem BookProof.HermiteBand.IsBand1.comp {T U : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hU : IsBand1 U) (hT : IsBand1 T) : IsBand2 (U ∘ₗ T) := by sorry
