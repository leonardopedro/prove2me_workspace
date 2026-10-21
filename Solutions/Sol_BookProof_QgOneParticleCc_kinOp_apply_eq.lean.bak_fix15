-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.kinOp_apply_eq
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (f : 𝓢(Vd d, ℂ)) (x : Vd d) :
    (kinOp d f) x = -lapC (f : Vd d → ℂ) x := by

  have h : (kinOp d f)
      = (∑ i : Fin d, ((-1 : ℝ) : ℂ) • secondDeriv (kinDir d i) f)
        + ((0 : ℝ) : ℂ) • f := by
    simp [kinOp, constCoeffOp]
  rw [h]
  simp only [SchwartzMap.add_apply, SchwartzMap.sum_apply, SchwartzMap.smul_apply, smul_eq_mul,
    Complex.ofReal_neg, Complex.ofReal_one, Complex.ofReal_zero, zero_mul, add_zero,
    secondDeriv_apply_eq, lapC, dcoord, neg_one_mul, ← Finset.sum_neg_distrib]
  rfl
