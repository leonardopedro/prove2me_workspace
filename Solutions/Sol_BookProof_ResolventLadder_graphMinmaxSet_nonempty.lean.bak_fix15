-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.graphMinmaxSet_nonempty
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_res_mem
import Theorems.Thm_BookProof_ResolventLadder_res_injective
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {k : ℕ} {W : Submodule ℂ F}
    (hW : Module.finrank ℂ W = k + 1) : (graphMinmaxSet T k).Nonempty := by

  classical
  set R : F →ₗ[ℂ] F := (res hT : F →ₗ[ℂ] F) with hR
  have hinj : Function.Injective R := res_injective hT hsv
  have hfd : FiniteDimensional ℂ W := .of_finrank_pos (by rw [hW]; omega)
  have hequiv : W ≃ₗ[ℂ] (W.map R) := Submodule.equivMapOfInjective R hinj W
  have hrank : Module.finrank ℂ (W.map R) = k + 1 := by
    rw [← hequiv.finrank_eq, hW]
  have hdom : InDomain T (W.map R) := by
    rintro y hy
    obtain ⟨w, -, rfl⟩ := Submodule.mem_map.mp hy
    exact ⟨w - res hT w, res_mem hT w⟩
  exact ⟨_, W.map R, hrank, hdom, rfl⟩
