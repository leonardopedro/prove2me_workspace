-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.IsBand1.toBand2
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}


theorem BookProof.HermiteBand.IsBand1.toBand2 {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (h : IsBand1 T) : IsBand2 T := by sorry
