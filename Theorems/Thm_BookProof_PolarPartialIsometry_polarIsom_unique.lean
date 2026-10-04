-- Generated from ChapterPolarPartialIsometry.lean — theorem BookProof.PolarPartialIsometry.polarIsom_unique
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


theorem BookProof.PolarPartialIsometry.polarIsom_unique (V : F →L[ℂ] F) (hV : ∀ x : Dom, V (P x) = Q x)
    (hV0 : ∀ z ∈ (initSpace P)ᗮ, V z = 0) : V = polarIsom P Q h := by sorry
