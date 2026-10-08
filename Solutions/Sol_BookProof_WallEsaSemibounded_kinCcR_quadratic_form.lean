-- Generated from ChapterWallEsaSemibounded.lean — solution of BookProof.WallEsaSemibounded.kinCcR_quadratic_form
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
import Theorems.Thm_BookProof_WallEsaSemibounded_integral_conj_neg_deriv2_mul
import Theorems.Thm_BookProof_ScalaronEsa_ccEquiv_coe
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_left
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
open BookProof.WallEsaSemibounded




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (f : ccSchwartz ℝ) :
    (inner ℂ (kinCcR (ccEquiv ℝ f))
        ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2 : ℝ) : ℂ) :=
  (ℝ, ℂ)) :
      (inner ℂ (g.toLp 2 (volume : Measure ℝ)) (g.toLp 2 (volume : Measure ℝ)) : ℂ)
        = ((∫ x, ‖g x‖ ^ 2 : ℝ) : ℂ) := by
    rw [inner_toLp_left]
    rw [← integral_complex_ofReal]
    refine integral_congr_ae ?_
    filter_upwards [g.coeFn_toLp 2 (volume : Measure ℝ)] with x hx
    rw [hx, Complex.normSq_eq_conj_mul_self.symm, Complex.sq_norm]
  
  /-- The kinetic quadratic form on the compactly supported smooth core is the Dirichlet
  energy. -/
  theorem kinCcR_quadratic_form (f : ccSchwartz ℝ) :
      (inner ℂ (kinCcR (ccEquiv ℝ f))
          ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
        = ((∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2 : ℝ) : ℂ) := by
    have hincl : Submodule.inclusion (ccDomain_le_schwartzDomain (E := ℝ)) (ccEquiv ℝ f)
        = schwartzEquiv ℝ (f : 𝓢(ℝ, ℂ)) := Subtype.ext rfl
    have hkin : kinC
