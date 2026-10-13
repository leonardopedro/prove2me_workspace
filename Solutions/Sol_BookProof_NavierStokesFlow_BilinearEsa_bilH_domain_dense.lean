-- Generated from ChapterNavierStokesBilinearEsa.lean — solution of BookProof.NavierStokesFlow.BilinearEsa.bilH_domain_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesBilinearEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.BilinearEsa



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution :
    Dense ((lpFiniteModes (ℕ × J) : Submodule ℂ (L2I (ℕ × J))) : Set (L2I (ℕ × J))) := lpFiniteModes_dense
