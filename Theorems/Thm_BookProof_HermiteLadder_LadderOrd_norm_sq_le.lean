-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.LadderOrd.norm_sq_le
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.HermiteLadder



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}


theorem BookProof.HermiteLadder.LadderOrd.norm_sq_le {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {n : ℕ}
    (hT : LadderOrd T n) :
    ∃ C : ℝ≥0∞, C ≠ ⊤ ∧ ∀ p, ENNReal.ofReal (‖pgLp (T p)‖ ^ 2) ≤ C * hn n (pgLp p) := by sorry
