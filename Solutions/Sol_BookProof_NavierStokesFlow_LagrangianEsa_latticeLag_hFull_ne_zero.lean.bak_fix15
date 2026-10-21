-- Generated from ChapterNavierStokesLagrangianEsa.lean — solution of BookProof.NavierStokesFlow.LagrangianEsa.latticeLag_hFull_ne_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_latticeLagData_hFull_apply
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_momentum_apply
import Theorems.Thm_BookProof_NavierStokesFlow_single_mem_finiteModes
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

set_option maxHeartbeats 1000000 in
theorem solution :
    (latticeLagData (fun _ => zeroField) zeroField (fun _ => 0) (le_refl (0 : ℝ))).hFull ≠ 0 :=
  w fr hnu).hasZeroDeficiencyOn_of_boundedRealization
      (latticeLagCLM v w fr nu) (latticeLagCLM_isSymmetric v w fr nu)
      (latticeLagData_hFull_apply v w fr hnu)
  
  /-- The zero field of `ℓ^∞(ℤ)`, used to exhibit the purely kinetic realization. -/
  noncomputable def zeroField : LinfZ := 0
  
  /-- **The lattice realization is not degenerate**: already the kinetic term
  alone — the discrete Laplacian `½∑Pᵢ²` — is a nonzero operator, so the essential
  self-adjointness statement above is not about the zero operator. -/
  theorem latticeLag_hFull_ne_zero :
      (latticeLagData (fun _ => zeroField) zeroField (fun _ => 0) (le_refl (0 : ℝ))).hFull ≠ 0 := by
    intro hzero
    set L := latticeLagData (fun _ => zeroField) zeroField (fun _ => 0) (le_refl (0 : ℝ)) with hL
    have hmem : (lp.single 2 (0 : ℤ) (1 : ℂ) : L2Z) ∈ L.D := single_mem_finiteModes 0 1
    have h := congrArg (fun T : L.D →ₗ[ℂ] L.D => ((T ⟨_, hmem⟩ : L.D) : L2Z)) hzer
