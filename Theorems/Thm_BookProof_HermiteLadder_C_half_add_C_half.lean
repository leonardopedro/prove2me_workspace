-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.C_half_add_C_half
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
open BookProof.HermiteLadder

variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section


theorem BookProof.HermiteLadder.C_half_add_C_half :
    (C (1 / 2 : ℂ) : MvPolynomial (Fin d) ℂ) + C (1 / 2 : ℂ) = 1 := by sorry
