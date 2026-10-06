-- Generated from ChapterPositiveSquareRootUnique.lean — theorem BookProof.PositiveSquareRoot.absRel_unique_nonneg_sqrt
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
open BookProof.PositiveSquareRoot

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open scoped ComplexOrder


theorem BookProof.PositiveSquareRoot.absRel_unique_nonneg_sqrt (A : D →ₗ[ℂ] F) :
    IsNonnegSelfAdjoint (absRel A) ∧
      {p : F × F | ∃ w, (p.1, w) ∈ absRel A ∧ (w, p.2) ∈ absRel A}
        = (factorRel A : Set (F × F)) ∧
      ∀ T : Submodule ℂ (F × F), IsNonnegSelfAdjoint T →
        {p : F × F | ∃ w, (p.1, w) ∈ T ∧ (w, p.2) ∈ T} = (factorRel A : Set (F × F)) →
        T = absRel A := by sorry
