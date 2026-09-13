-- Generated from ChapterNavierStokesFockFarisLavine.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockComparison_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_SecondQuant_fockCore_dense
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
theorem solution :
    Dense ((fockCore fiberCore : Submodule ℂ (lp fiberSector 2)) : Set (lp fiberSector 2)) := fockCore_dense fun _ => lpFiniteModes_dense
