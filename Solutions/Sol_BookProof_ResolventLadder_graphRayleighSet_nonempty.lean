-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.graphRayleighSet_nonempty
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_RitzMinMax_exists_unit_mem
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
theorem solution {S : Submodule ℂ F} (hS : 0 < Module.finrank ℂ S)
    (hdom : InDomain T S) : (graphRayleighSet T S).Nonempty := by

  obtain ⟨y, hy, hy1⟩ := exists_unit_mem S hS
  obtain ⟨z, hz⟩ := hdom y hy
  exact ⟨_, y, z, hz, hy, hy1, rfl⟩
