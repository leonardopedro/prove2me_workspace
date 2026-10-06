-- Generated from ChapterHermiteBandCalculusHigher.lean — theorem BookProof.HermiteBandHigher.IsBandR.comp
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand
open BookProof.HermiteBandHigher

variable {d : ℕ}



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2


theorem BookProof.HermiteBandHigher.IsBandR.comp {r₁ r₂ m₁ m₂ : ℕ}
    {T U : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hU : IsBandR r₂ m₂ U) (hT : IsBandR r₁ m₁ T) :
    IsBandR (r₁ + r₂) (m₁ + m₂) (U ∘ₗ T) := by sorry
