-- Generated from ChapterNavierStokesFockFarisLavine.lean — theorem BookProof.NavierStokesFlow.SecondQuant.fockComparison_ge_norm_sq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant








open scoped ENNReal



open FarisLavineLift

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}



















open FarisLavineLift LpNat DiagonalEsa

theorem BookProof.NavierStokesFlow.SecondQuant.fockComparison_ge_norm_sq (d : ℕ) (p q : Fin d → ℕ → ℝ) (v : fockCore fiberCore) :
    ‖(v : lp fiberSector 2)‖ ^ 2
      ≤ (inner ℂ ((v : lp fiberSector 2))
          ((fockComparison d p q v : fockCore fiberCore) : lp fiberSector 2) : ℂ).re := by sorry
