-- Generated from ChapterScalaronHermiteEsa.lean — solution of BookProof.ScalaronHermiteEsa.GaussExpDecay.aestronglyMeasurable
import Mathlib
import Definitions.Def_ChapterScalaronHermiteEsa
open BookProof.ScalaronHermiteEsa




open MeasureTheory Complex MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {u : Vd d → ℂ} (hu : GaussExpDecay u) :
    AEStronglyMeasurable u (volume : Measure (Vd d)) := by

  have h0 := (hu 0).aestronglyMeasurable
  simp only [zero_mul, Real.exp_zero, one_mul] at h0
  have hinv : Continuous fun x : Vd d => (((gaussD x)⁻¹ : ℝ) : ℂ) :=
    Complex.continuous_ofReal.comp
      (continuous_gaussD.inv₀ fun x => ne_of_gt (gaussD_pos x))
  refine (hinv.aestronglyMeasurable.mul h0).congr (Filter.Eventually.of_forall fun x => ?_)
  simp only [Pi.mul_apply]
  rw [← mul_assoc, ← Complex.ofReal_mul, inv_mul_cancel₀ (ne_of_gt (gaussD_pos x)),
    Complex.ofReal_one, one_mul]
