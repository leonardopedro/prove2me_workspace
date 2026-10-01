-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.Band.mono
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand
open BookProof.HermiteBand.Band

variable {d : ℕ}



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis


theorem BookProof.HermiteBand.Band.mono {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {r M M' : ℕ}
    {C C' : ℝ} {g : ℕ → ℝ} (hg : ∀ n, 0 ≤ g n) (hM : M ≤ M') (hC : C ≤ C')
    (h : Band T r M C g) : Band T r M' C' g := by sorry
