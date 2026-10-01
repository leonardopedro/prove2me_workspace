-- Generated from ChapterNavierStokesAffineFiberEsa.lean — theorem BookProof.NavierStokesFlow.AffineFiber.hFun_zero
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
theorem BookProof.NavierStokesFlow.AffineFiber.hFun_zero (S : ShiftData ι) (β : ι) : S.hFun (fun _ : ι => (0 : ℂ)) β = 0 := by sorry
