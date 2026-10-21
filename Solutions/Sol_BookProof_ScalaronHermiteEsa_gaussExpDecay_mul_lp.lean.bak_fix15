-- Generated from ChapterScalaronHermiteEsa.lean — solution of BookProof.ScalaronHermiteEsa.gaussExpDecay_mul_lp
import Mathlib
import Definitions.Def_ChapterScalaronHermiteEsa
import Theorems.Thm_BookProof_ScalaronHermiteEsa_gaussExpDecay_of_memLp_mul
open BookProof.ScalaronHermiteEsa




open MeasureTheory Complex MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {g : Vd d → ℂ} {C c : ℝ}
    (hg : AEStronglyMeasurable g (volume : Measure (Vd d)))
    (hbd : ∀ x, ‖g x‖ ≤ C * Real.exp (c * ‖x‖)) (w : L2d d) :
    GaussExpDecay (fun x : Vd d => g x * (w : Vd d → ℂ) x) := by

  refine gaussExpDecay_of_memLp_mul (C := C) (c := c) (hg.mul (Lp.memLp w).1) (Lp.memLp w)
    fun x => ?_
  rw [norm_mul]
  exact mul_le_mul_of_nonneg_right (hbd x) (norm_nonneg _)
