-- Generated from ChapterPolarPartialIsometry.lean — theorem BookProof.PolarPartialIsometry.inner_polarIsom
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Definitions.Def_ChapterA4
open BookProof.PolarPartialIsometry

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}
variable (P Q : Dom →ₗ[ℂ] F)
  (h : ∀ x y : Dom, (inner ℂ (P x) (P y) : ℂ) = inner ℂ (Q x) (Q y))
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness


theorem BookProof.PolarPartialIsometry.inner_polarIsom (z w : F) :
    (inner ℂ (polarIsom P Q h z) (polarIsom P Q h w) : ℂ)
      = inner ℂ ((initSpace P).starProjection z) ((initSpace P).starProjection w) := by sorry
