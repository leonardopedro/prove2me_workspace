-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.canH_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterNavierStokesIkebeKato
import Theorems.Thm_BookProof_NavierStokesFlow_ThreeComponent_velH_essentiallySelfAdjointOn_core
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn (lpFiniteModes Vel)
      ((lpFiniteModes Vel).subtype.comp (canH A c)) := by

  rw [canH_eq_velH]
  exact velH_essentiallySelfAdjointOn_core A c
