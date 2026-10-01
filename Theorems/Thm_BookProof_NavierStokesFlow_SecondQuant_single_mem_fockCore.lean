-- Generated from ChapterNavierStokesSecondQuant.lean — theorem BookProof.NavierStokesFlow.SecondQuant.single_mem_fockCore
import Mathlib
import Definitions.Def_ChapterNavierStokesSecondQuant
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesFockFarisLavine
open BookProof.DirectSumEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable (D : ∀ m, Submodule ℂ (S m))
variable {D}


open scoped ENNReal




theorem BookProof.NavierStokesFlow.SecondQuant.single_mem_fockCore [DecidableEq ι] (m : ι) (x : S m) (hx : x ∈ D m) :
    lp.single 2 m x ∈ fockCore D := by sorry
