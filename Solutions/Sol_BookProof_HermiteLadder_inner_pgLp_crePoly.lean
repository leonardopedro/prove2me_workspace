-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.inner_pgLp_crePoly
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_inner_pgLp_annPoly
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p q : MvPolynomial (Fin d) ℂ) :
    (inner ℂ (pgLp q) (pgLp (crePoly i p)) : ℂ) = inner ℂ (pgLp (annPoly i q)) (pgLp p) := by

  rw [← inner_conj_symm, ← inner_pgLp_annPoly, inner_conj_symm]
