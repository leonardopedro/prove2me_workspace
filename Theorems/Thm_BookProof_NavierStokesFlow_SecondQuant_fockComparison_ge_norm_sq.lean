-- Generated from ChapterNavierStokesFockFarisLavine.lean — theorem BookProof.NavierStokesFlow.SecondQuant.fockComparison_ge_norm_sq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
import Definitions.Def_ChapterBddBelowFiberSumEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.BddBelowFiberSumEsa
open BookProof.DirectSumEsa
open BookProof.NavierStokesFlow.DiagonalEsa
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.FarisLavineLift
open BookProof.NavierStokesFlow.FarisLavineLift.ComparisonData
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}


open scoped ENNReal



open FarisLavineLift


theorem BookProof.NavierStokesFlow.SecondQuant.fockComparison_ge_norm_sq (d : ℕ) (p q : Fin d → ℕ → ℝ) (v : fockCore fiberCore) :
    ‖(v : lp fiberSector 2)‖ ^ 2
      ≤ (inner ℂ ((v : lp fiberSector 2))
          ((fockComparison d p q v : fockCore fiberCore) : lp fiberSector 2) : ℂ).re := by sorry
