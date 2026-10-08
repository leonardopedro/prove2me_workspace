-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.Band.toBand2
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}


theorem BookProof.HermiteBand.Band.toBand2 {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {M : ℕ} {C : ℝ}
    (hC : 0 ≤ C) (h : Band T 1 M C g1) : Band T 2 M C g2 := by sorry
