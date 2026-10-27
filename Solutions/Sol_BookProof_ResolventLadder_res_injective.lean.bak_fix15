-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.res_injective
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_res_mem
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
theorem solution (hT : IsNonnegSelfAdjoint T) (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) :
    Function.Injective (res hT) := by

  intro a b hab
  have h0 : res hT (a - b) = 0 := by rw [map_sub, hab, sub_self]
  have hmem := res_mem hT (a - b)
  rw [h0] at hmem
  have := hsv _ (by simpa using hmem)
  exact sub_eq_zero.1 this
