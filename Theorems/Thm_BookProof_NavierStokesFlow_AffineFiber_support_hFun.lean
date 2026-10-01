-- Generated from ChapterNavierStokesAffineFiberEsa.lean — theorem BookProof.NavierStokesFlow.AffineFiber.support_hFun
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
theorem BookProof.NavierStokesFlow.AffineFiber.support_hFun (S : ShiftData ι) (X : ι → ℂ) :
    Function.support (S.hFun X)
      ⊆ S.shift '' Function.support X ∪ S.shift ⁻¹' Function.support X := by sorry
