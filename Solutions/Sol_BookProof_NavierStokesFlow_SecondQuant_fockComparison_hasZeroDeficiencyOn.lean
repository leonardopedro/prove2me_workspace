-- Generated from ChapterNavierStokesFockFarisLavine.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockComparison_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_diagComparison_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_SecondQuant_fockOp_hasZeroDeficiencyOn
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant









open scoped ENNReal



open BookProof.NavierStokesFlow.FarisLavineLift

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}



















open BookProof.NavierStokesFlow.FarisLavineLift BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.DiagonalEsa

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) (p q : Fin d → ℕ → ℝ) :
    HasZeroDeficiencyOn (fockCore fiberCore) (fockComparison d p q) := fockOp_hasZeroDeficiencyOn _ fun _ => diagComparison_hasZeroDeficiencyOn d p q
