-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.coe_inclusion_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (sym : Vel → ℝ) (x : lpFiniteModes Vel) :
    ((Submodule.inclusion (finiteModes_le_maxDom sym) x : maxDom sym) : L2I Vel)
      = (x : L2I Vel) := rfl
