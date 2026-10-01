-- Generated from ChapterNavierStokesAffineFiberEsa.lean — theorem BookProof.NavierStokesFlow.AffineFiber.hFun_add
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
theorem BookProof.NavierStokesFlow.AffineFiber.hFun_add (S : ShiftData ι) (X Y : ι → ℂ) (β : ι) :
    S.hFun (fun α => X α + Y α) β = S.hFun X β + S.hFun Y β := by sorry
