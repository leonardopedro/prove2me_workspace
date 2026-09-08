-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.annPoly_hpsi
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand







noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

theorem BookProof.HermiteBand.annPoly_hpsi (i : Fin d) (α : Fin d →₀ ℕ) :
    annPoly i (hpsi α) = ((Real.sqrt (α i : ℝ) : ℝ) : ℂ) • hpsi (α - Finsupp.single i 1) := by sorry
