-- Generated from ChapterNavierStokesAffineFiberEsa.lean — theorem BookProof.NavierStokesFlow.AffineFiber.affH_ne_zero_of_pos_shear
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber

variable {ι : Type*}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (P : PairShift ι)


open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian


2I ℕ) : ℕ → ℂ) (n + 2) = _
  have hp2 := PairShift.pairH_coe (P := affData hκ hc) (basisState κ c n) (n + 2)
  refine hp2.trans ?_
  rw [hfst, hsnd, add_zero]

/-- With a non-zero constant part the affine fiber Hamiltonian does not vanish
on the ground state: the `±1`-sh := by sorry
