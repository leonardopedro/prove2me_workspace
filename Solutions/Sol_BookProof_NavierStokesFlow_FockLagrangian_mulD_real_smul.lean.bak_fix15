-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.mulD_real_smul
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_const_mul
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {g h : X → ℝ} (r : ℝ) (hh : Measurable h)
    (hdom : DominatedOn μ g h) :
    ((r : ℝ) : ℂ) • mulD μ hh hdom
      = mulD μ ((measurable_const (a := r)).mul hh) (DominatedOn.const_mul r hdom) := by

  refine LinearMap.ext fun f => Subtype.ext (Lp.ext ?_)
  filter_upwards [mulD_coeFn μ hh hdom f,
    mulD_coeFn μ ((measurable_const (a := r)).mul hh) (DominatedOn.const_mul r hdom) f,
    Lp.coeFn_smul ((r : ℝ) : ℂ) ((mulD μ hh hdom f : boundedEnergyCore μ g) : Lp ℂ 2 μ)]
    with x h1 h2 h3
  simp only [LinearMap.smul_apply, Submodule.coe_smul]
  rw [h3]
  simp only [Pi.smul_apply, smul_eq_mul]
  rw [h1, h2]
  push_cast
  simp only [Pi.mul_apply, Complex.ofReal_mul]
  ring
