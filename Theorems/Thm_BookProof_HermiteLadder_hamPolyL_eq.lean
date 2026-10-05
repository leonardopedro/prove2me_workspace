-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.hamPolyL_eq
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.QgHermiteFriedrichs
open BookProof.HermiteLadder

variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section


theorem BookProof.HermiteLadder.hamPolyL_eq (S : Finset (Fin d)) (q : MvPolynomial (Fin d) ℂ) :
    hamPolyL S q = -(∑ j ∈ S, coreDL j ∘ₗ coreDL j) + mulL q := by sorry
