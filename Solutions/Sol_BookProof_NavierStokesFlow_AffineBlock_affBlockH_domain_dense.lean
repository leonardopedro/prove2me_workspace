-- Generated from ChapterNavierStokesAffineBlockEsa.lean — solution of BookProof.NavierStokesFlow.AffineBlock.affBlockH_domain_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineBlockEsa
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber BilinearEsa

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution :
    Dense ((lpFiniteModes (ℕ × J) : Submodule ℂ (L2I (ℕ × J))) : Set (L2I (ℕ × J))) := lpFiniteModes_dense
