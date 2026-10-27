-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.inv_sub_one_le_of_rayleigh_le
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_one_le_add_mul_rayleigh_of_unit
import Theorems.Thm_BookProof_ChapterDutchBook_Coherent_nonneg
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
theorem solution (hT : IsNonnegSelfAdjoint T) {y z : F}
    (hyz : (y, z) ∈ T) (hy : ‖y‖ = 1) {c : ℝ} (hc : 0 < c)
    (hle : rayleighVal (res hT) y ≤ c) : 1 / c - 1 ≤ (inner ℂ y z : ℂ).re := by

  have hg : 0 ≤ (inner ℂ y z : ℂ).re := hT.nonneg _ hyz
  have h1 := one_le_add_mul_rayleigh_of_unit hT hyz hy
  have h2 : (1 + (inner ℂ y z : ℂ).re) * rayleighVal (res hT) y
      ≤ (1 + (inner ℂ y z : ℂ).re) * c :=
    mul_le_mul_of_nonneg_left hle (by linarith)
  have h3 : 1 / c ≤ 1 + (inner ℂ y z : ℂ).re := by
    rw [div_le_iff₀ hc]
    linarith
  linarith
