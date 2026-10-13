-- Generated from ChapterFriedrichsSquareFactorization.lean — solution of BookProof.FriedrichsSquare.isFriedrichsSqExtension_iff_eq_factorRel
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Theorems.Thm_BookProof_FriedrichsSquare_adjPairs_mono
import Theorems.Thm_BookProof_FriedrichsSquare_adjPairs_factorRel
import Theorems.Thm_BookProof_FriedrichsSquare_IsFriedrichsSqExtension_symmetric
import Theorems.Thm_BookProof_FriedrichsSquare_le_factorRel_of_symmetric_extension
import Theorems.Thm_BookProof_FriedrichsSquare_isFriedrichsSqExtension_factorRel
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_selfAdjoint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterStoneConverse
open BookProof.FriedrichsSquare




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.ClosureUniqueness
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace F] {A : D →ₗ[ℂ] F}
    (hsym : SymmetricOn D A) {hstab : ∀ v : D, (A v : F) ∈ D} {R : Submodule ℂ (F × F)} :
    IsFriedrichsSqExtension A hstab R ↔ R = factorRel A := by

  constructor
  · intro hR
    have hle : R ≤ factorRel A :=
      le_factorRel_of_symmetric_extension hsym hR.extends_sq hR.symmetric hR.form_domain
    refine le_antisymm hle ?_
    calc factorRel A = adjPairs (factorRel A) := (adjPairs_factorRel A).symm
      _ ≤ adjPairs R := adjPairs_mono hle
      _ = R := hR.selfAdjoint
  · rintro rfl
    exact isFriedrichsSqExtension_factorRel A hsym hstab
