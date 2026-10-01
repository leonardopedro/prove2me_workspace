-- Generated from ChapterNavierStokesAffineFiberEsa.lean — theorem BookProof.NavierStokesFlow.AffineFiber.PairShift.pairH_relative_bound
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

theorem BookProof.NavierStokesFlow.AffineFiber.PairShift.pairH_relative_bound (x : maxDom P.sym) :
    ‖(pairH P x : L2I ι)‖ ^ 2
      ≤ 2 * ‖(diagMax P.sym x : L2I ι)‖ ^ 2 + (32 * P.K ^ 2) * ‖(x : L2I ι)‖ ^ 2 := by sorry
