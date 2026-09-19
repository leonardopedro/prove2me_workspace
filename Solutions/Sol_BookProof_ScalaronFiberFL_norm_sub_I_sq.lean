-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.norm_sub_I_sq
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_FarisLavine_inner_apply_self_im
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ F} (N : D →ₗ[ℂ] F) (hsym : SymmetricOn D N) (u : D) :
    ‖N u - Complex.I • (u : F)‖ ^ 2 = ‖N u‖ ^ 2 + ‖(u : F)‖ ^ 2 := by

  have him : (inner ℂ (N u) (u : F) : ℂ).im = 0 := inner_apply_self_im N hsym u
  have hre : (inner ℂ (N u) (Complex.I • (u : F)) : ℂ).re = 0 := by
    rw [inner_smul_right, Complex.mul_re, him]
    simp
  have hnorm : ‖Complex.I • (u : F)‖ = ‖(u : F)‖ := by
    rw [norm_smul]; simp
  rw [norm_sub_sq (𝕜 := ℂ), hnorm]
  simp only [RCLike.re_to_complex] at hre ⊢
  rw [hre]
  ring
