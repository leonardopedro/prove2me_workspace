-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.hamPolyL_eq
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal
open BookProof.QgHermiteFriedrichs

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset (Fin d)) (q : MvPolynomial (Fin d) ℂ) :
    hamPolyL S q = -(∑ j ∈ S, coreDL j ∘ₗ coreDL j) + mulL q := by

  refine LinearMap.ext fun p => ?_
  simp [hamPolyL_apply, kinPolyS, LinearMap.sum_apply, coreDL_apply]
