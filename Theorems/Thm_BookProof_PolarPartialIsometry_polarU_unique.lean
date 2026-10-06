-- Generated from ChapterPolarPartialIsometry.lean — theorem BookProof.PolarPartialIsometry.polarU_unique
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.EsaClosure
open BookProof.PolarPartialIsometry

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}
variable (P Q : Dom →ₗ[ℂ] F)
  (h : ∀ x y : Dom, (inner ℂ (P x) (P y) : ℂ) = inner ℂ (Q x) (Q y))
variable [CompleteSpace F]
variable [CompleteSpace F] {D : Submodule ℂ F} (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
  (hsym : SymmetricOn D A)



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar


theorem BookProof.PolarPartialIsometry.polarU_unique (V : F →L[ℂ] F)
    (hV : ∀ x : clDom A, V (absOn A hdense hsym x) = clExt A hdense hsym x)
    (hV0 : ∀ z ∈ (initSpace (absOn A hdense hsym))ᗮ, V z = 0) : V = polarU A hdense hsym := by sorry
