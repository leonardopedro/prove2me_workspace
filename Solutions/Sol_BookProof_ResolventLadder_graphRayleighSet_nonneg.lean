-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.graphRayleighSet_nonneg
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
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
theorem solution (hT : IsNonnegSelfAdjoint T) {S : Submodule ℂ F} {t : ℝ}
    (ht : t ∈ graphRayleighSet T S) : 0 ≤ t := by

  obtain ⟨y, z, hyz, -, -, rfl⟩ := ht
  exact hT.nonneg _ hyz
