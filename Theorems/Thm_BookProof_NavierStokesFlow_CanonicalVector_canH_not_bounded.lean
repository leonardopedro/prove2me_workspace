-- Generated from ChapterNavierStokesCanonicalVector.lean — theorem BookProof.NavierStokesFlow.CanonicalVector.canH_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

theorem BookProof.NavierStokesFlow.CanonicalVector.canH_not_bounded (hA : A 0 0 ≠ 0) (C : ℝ) :
    ∃ x : lpFiniteModes Vel, ‖(x : L2I Vel)‖ = 1
      ∧ C < ‖((canH A c x : lpFiniteModes Vel) : L2I Vel)‖ := by sorry
