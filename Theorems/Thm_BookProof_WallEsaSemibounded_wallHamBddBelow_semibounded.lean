-- Generated from ChapterWallEsaSemibounded.lean — theorem BookProof.WallEsaSemibounded.wallHamBddBelow_semibounded
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
open BookProof.WallEsaSemibounded

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

ards [(f : 𝓢(ℝ, ℂ)).coeFn_toLp 2 (volume : Measure ℝ)] with x hx
  rw [hx]
  simp only [mulCc_apply, map_mul, Complex.conj_ofReal, Complex.ofReal_mul]
  rw [mul_assoc, Complex.normSq_eq_conj_mul_self.symm, Complex.sq_norm]

theorem BookProof.WallEsaSemibounded.wallHamBddBelow_semibounded (f : ccSchwartz ℝ) :
    ‖((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2
      = ∫ x, ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
  have h := inner_toLp_self (f : 𝓢(ℝ := by sorry
