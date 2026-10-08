-- Generated from ChapterNavierStokesAffineFiberEsa.lean — theorem BookProof.NavierStokesFlow.AffineFiber.affH_domain_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (P : PairShift ι)

theorem BookProof.NavierStokesFlow.AffineFiber.affH_domain_dense :
    Dense ((lpFiniteModes ℕ : Submodule ℂ (L2I ℕ)) : Set (L2I ℕ)) := by sorry
