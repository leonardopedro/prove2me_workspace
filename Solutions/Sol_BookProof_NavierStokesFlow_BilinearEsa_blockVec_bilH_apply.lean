-- Generated from ChapterNavierStokesBilinearEsa.lean — solution of BookProof.NavierStokesFlow.BilinearEsa.blockVec_bilH_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesBilinearEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.BilinearEsa



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ : J → ℝ) (x : lpFiniteModes (ℕ × J)) (j : J) (n : ℕ) :
    ((bilH κ x : L2I (ℕ × J)) : ℕ × J → ℂ) (n, j)
      = hFun (κ j) (fun m => ((x : L2I (ℕ × J)) : ℕ × J → ℂ) (m, j)) n := rfl
