-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.friedrichs_hypothesis_holds
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.FriedrichsExtension




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open scoped InnerProductSpace ENNReal lp
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in

theorem solution :
    ∀ (D' : Submodule ℂ F) (H' : D' →ₗ[ℂ] F), Dense (D' : Set F) →
      SymmetricOn D' H' → (∀ x : D', 0 ≤ quadForm H' x) →
      ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsPositiveSelfAdjointExtension H' A :=
  fun D' H' hdense hsym hpos =>
    friedrichs_extension_exists ⟨D', H', hsym, hpos⟩ hdense
