-- Generated from ChapterScalaronCoreEsa.lean — solution of BookProof.ScalaronEsa.contDiff_starobinskyV
--
-- The potential is `M⁴/(16α)·(1 − e^{−√(2/3)·φ/M})²`: a constant times the square of a difference
-- of a constant and the exponential of an affine function.  The proof is the source chapter's, and
-- it was validated against the same definition in `../timepiece` (Lean 4.28) before submission.
import Mathlib
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky


open Filter Topology


noncomputable section

theorem solution (M alpha : ℝ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun phi : ℝ => starobinskyV M alpha phi) := by
  unfold starobinskyV
  exact contDiff_const.mul
    ((contDiff_const.sub (Real.contDiff_exp.comp
      ((contDiff_const.mul contDiff_id).div_const M))).pow 2)
