-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.canH_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_canH_eq_velH
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
import Theorems.Thm_BookProof_NavierStokesFlow_ThreeComponent_velH_not_bounded
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (hA : A 0 0 ≠ 0) (C : ℝ) :
    ∃ x : lpFiniteModes Vel, ‖(x : L2I Vel)‖ = 1
      ∧ C < ‖((canH A c x : lpFiniteModes Vel) : L2I Vel)‖ := by

  obtain ⟨β, h1, h2⟩ := velH_not_bounded A c hA C
  refine ⟨coreState β, h1, ?_⟩
  have hEq : ((canH A c (coreState β) : lpFiniteModes Vel) : L2I Vel)
      = (velH A c (velState A c β) : L2I Vel) := by
    have h := congrArg (fun T : lpFiniteModes Vel →ₗ[ℂ] L2I Vel => T (coreState β))
      (canH_eq_velH A c)
    exact h
  rw [hEq]
  exact h2

/-! 
