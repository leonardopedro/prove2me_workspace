-- Generated from ChapterNavierStokesFockFarisLavine.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockComparison_ge_norm_sq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_SecondQuant_fockOp_ge_norm_sq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant









open scoped ENNReal



open FarisLavineLift

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}



















open FarisLavineLift LpNat DiagonalEsa

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) (p q : Fin d → ℕ → ℝ) (v : fockCore fiberCore) :
    ‖(v : lp fiberSector 2)‖ ^ 2
      ≤ (inner ℂ ((v : lp fiberSector 2))
          ((fockComparison d p q v : fockCore fiberCore) : lp fiberSector 2) : ℂ).re := fockOp_ge_norm_sq _ (fun _ x => (diagComparisonData d p q).comparison_ge_norm_sq x) v
