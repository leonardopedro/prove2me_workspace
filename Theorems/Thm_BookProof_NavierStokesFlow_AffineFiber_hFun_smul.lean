-- Generated from ChapterNavierStokesAffineFiberEsa.lean — theorem BookProof.NavierStokesFlow.AffineFiber.hFun_smul
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber

variable {ι : Type*}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (P : PairShift ι)


open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

open ShiftHamiltonian in
theorem BookProof.NavierStokesFlow.AffineFiber.hFun_smul (S : ShiftData ι) (a : ℂ) (X : ι → ℂ) (β : ι) :
    S.hFun (fun α => a * X α) β = a * S.hFun X β := by sorry
