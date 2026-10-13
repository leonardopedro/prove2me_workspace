-- Generated from ChapterNavierStokesLagrangianEsa.lean — solution of BookProof.NavierStokesFlow.LagrangianEsa.latticeLag_hFull_ne_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_latticeLagData_hFull_apply
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_momentum_apply
import Theorems.Thm_BookProof_NavierStokesFlow_single_mem_finiteModes
import Definitions.Def_ChapterContinuityUnitary
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa





open FullEsa
open BookProof.ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitaryInfinite

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

set_option maxHeartbeats 1000000 in

theorem solution :
    (latticeLagData (fun _ => zeroField) zeroField (fun _ => 0) (le_refl (0 : ℝ))).hFull ≠ 0 := by
  intro hzero
  set L := latticeLagData (fun _ => zeroField) zeroField (fun _ => 0) (le_refl (0 : ℝ)) with hL
  have hmem : (lp.single 2 (0 : ℤ) (1 : ℂ) : L2Z) ∈ L.D := single_mem_finiteModes 0 1
  have h := congrArg (fun T : L.D →ₗ[ℂ] L.D => ((T ⟨_, hmem⟩ : L.D) : L2Z)) hzero
  simp only [LinearMap.zero_apply, Submodule.coe_zero] at h
  rw [latticeLagData_hFull_apply] at h
  have hsingle : ((lp.single 2 (0 : ℤ) (1 : ℂ) : L2Z) : ℤ → ℂ) = Pi.single 0 1 := by
    funext k
    simp [lp.single_apply]
  have h0 := congrArg (fun g : L2Z => (g : ℤ → ℂ) 0) h
  simp only [latticeLagCLM, ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply,
    ContinuousLinearMap.mul_apply, lp.coeFn_add, lp.coeFn_smul,
    lp.coeFn_zero, Pi.add_apply, Pi.smul_apply, Pi.zero_apply, smul_eq_mul, Fin.sum_univ_three,
    momentum_apply, velocityOp_apply, hsingle, zeroField] at h0
  norm_num [Pi.single_apply, Complex.ext_iff] at h0
