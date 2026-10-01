-- Generated from ChapterNavierStokesAffineFiberEsa.lean — theorem BookProof.NavierStokesFlow.AffineFiber.affData_amp₁
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

theorem BookProof.NavierStokesFlow.AffineFiber.affData_amp₁₁ {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 ≤ c) :
    (affData hκ hc).amp₁ = amp κ := by sorry
