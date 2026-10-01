-- Generated from ChapterNavierStokesAffineFiberEsa.lean — theorem BookProof.NavierStokesFlow.AffineFiber.PairShift.pairH_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber.PairShift

variable {ι : Type*}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (P : PairShift ι)


open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

theorem BookProof.NavierStokesFlow.AffineFiber.PairShift.pairH_apply (x : maxDom P.sym) :
    (pairH P x : L2I ι) = (ShiftData.shiftH P.fst x : L2I ι)
      + (ShiftData.shiftH P.snd x : L2I ι) := by sorry
